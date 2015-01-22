public class RoundRobinScheduler{

//Wrapper class to sort schedule records
public class SchedulerWrapper implements Comparable {

    public Scheduler__c Sched;
    
    // Constructor 
    public SchedulerWrapper(Scheduler__c Sch) {
        Sched = Sch;
    }
    
    // Compare Schedulers based on the ID.
    public Integer compareTo(Object compareTo) {
        // Cast argument to OpportunityWrapper
        SchedulerWrapper compareToSched = (SchedulerWrapper)compareTo;
        
        // The return value of 0 indicates that both elements are equal.
        Integer returnValue = 0;
        if (Sched.ID > compareToSched.Sched.ID) {
            // Set return value to a positive value.
            returnValue = 1;
        } else if (Sched.ID < compareToSched.Sched.ID) {
            // Set return value to a negative value.
            returnValue = -1;
        }
        
        return returnValue;       
    }
}

public boolean rrState=false;

public static boolean isRun=false;

public void instRR()
{
    //User u = [SELECT Id, Alias, Email, EmailEncodingKey, LastName, LanguageLocaleKey, LocaleSidKey, ProfileId, TimeZoneSidKey, UserName FROM User WHERE Alias='mkash' limit 1];
    //System.runAs(u)
    //{
        rrState=true;
        testMethodRun();    
    //}
}

public void batchRR()
{
    if(!isRun){
    rrState=false;
    testMethodRun();
    }
}

public void testMethodRun(){
    isRun=true;
    List<Scheduler__c> updateTSchedule = new List<Scheduler__c>();
    List<user> updateTUser = new List<user>();
    List<RRB_Queue_Matrix__c> updateTRRMatrix = new List<RRB_Queue_Matrix__c>();
    List<Lead> updateLeads = new List<lead>();
    //Changed by Richard - B - 266662- Starts
    List<ErrorLogHandler.batchErrorLogWrapper> ExceptionList = new List<ErrorLogHandler.batchErrorLogWrapper>();
    boolean IsPrepareExceptionEmail = false;
    Integer TotalLeads= 0;
    Integer SuccesfullLeads= 0;
    Apex_Job_Master__c ThisJobDetail = new Apex_Job_Master__c ( Name='RoundRobinScheduler '+ System.now(), Start_Time__c = System.now());
    
    //Changed by Richard - B - 266662- Ends

    try
    {
    
    //Instant Roundrobin-code
     List<RecordType> preRecordID=[select id from RecordType where Name='Prequal' and SObjectType='Lead' limit 1];
    List<RecordType> heRecordID=[select id from RecordType where Name='Home Equity' and SObjectType='Lead' limit 1];
    EmailTemplate emailTemplate=[Select id from emailtemplate where name='WTL MSA Advice 1' limit 1];
    ID PreRecID=null;
    for(RecordType pr:preRecordID)
    {
        preRecID=pr.id;
    }
    ID heRecID=null;
    for(RecordType hr:heRecordID)
    {
        heRecID=hr.id;
    }    
    Messaging.SingleEmailMessage emailLead = new Messaging.SingleEmailMessage();
    //Instant  Round robin code end
    
    List<Scheduler__c> TSchedule = [SELECT Count__c,Current_User_ID__c,Current_User_Name__c,Id,Last_Assigned__c,Lead_Limit__c,Name,Next_User_Id__c,Next_User_Name__c,OOO__c,Queue_Name__c,User_Proficiency_Level__c FROM Scheduler__c];
    Map<String,Map<Decimal,Map<String,Scheduler__c>>> mapScheduler = new Map<String,Map<Decimal,Map<String,Scheduler__c>>>();
    List<ID> listSchedulerUserID = new List<ID>();
    
        For(Scheduler__c sh:TSchedule){
            listSchedulerUserID.add(sh.Current_User_ID__c);
        }

    List<user> TUser = [Select id,name,Last_assigned__c,OOO__c,Lead_limit__c,Count__c,Unlimited_Leads__c, UserRole.Name, FederationIdentifier, email FROM User WHERE id in:listSchedulerUserID];
    Map<String,User> mapTUser = new Map<String,User>();
        For(User u : TUser)   
            mapTUser.put(u.Name,u);     
  
    System.debug('***************mapTUser'+mapTUser);                             

    List<RRB_Queue_Matrix__c> TRRMatrix = [SELECT Current_queue_proficiency_level__c,Name,Next_assigned_user__c,Round_robin_status__c,Round_robin_time__c FROM RRB_Queue_Matrix__c where Round_robin_status__c != 'N'];
    Map<String,RRB_Queue_Matrix__c> MapTRRMatrix = new Map<String,RRB_Queue_Matrix__c>();
    List<String> listQueueName = new List<String>();

        For(RRB_Queue_Matrix__c q : TRRMatrix){
         listQueueName.add(q.Name);
         MapTRRMatrix.put(q.Name,q);
        }
    System.debug('***************MapTRRMatrix'+MapTRRMatrix);
    System.debug('***************listQueueName'+listQueueName);

    List<Lead> TLeads1 = [SELECT Id,Name,OwnerId,Owner.Name,Is_assigned_already__c,CreatedDate  From Lead WHERE Is_assigned_already__c = false and Owner.Name in:listQueueName order by CreatedDate];
    System.debug('***************TLeads1'+TLeads1);
    
    List<Lead> TLeads = new List<Lead>();
    
    //Filter out leads which are not ready to be assigned based on waiting time.
    integer joblimit = 0; 
    for(lead l : Tleads1){
    if (joblimit <= 100){
     if (MapTRRMatrix.get(l.Owner.Name).Round_robin_status__c =='y'){
      TLeads.add(l);
      joblimit += 1;
      }
     else if (MapTRRMatrix.get(l.Owner.Name).Round_robin_status__c =='w' && (l.CreatedDate + ((MapTRRMatrix.get(l.Owner.Name).Round_robin_time__c/60)/24))<= datetime.now() ) 
      {
      System.debug('***************entered W');
      TLeads.add(l);
      joblimit += 1;
      }
     }
     else
      break;
    }
    
    System.debug('***************TLeads'+TLeads);


    Boolean LVarLeadLimitReached = FALSE;// Define and Set Local Variable for Lead Limit Reached 
    Boolean LVarAssigned = FALSE; // Lead Assigned Flag

    //RRMatrix Fields
    String LVarLastQueueName = null;
    Time LVarQWaitTime = null;
    Decimal LVarQLevel = null;

    //Assigning map of Scheduler
    Map<Decimal,Map<String,Scheduler__c>> PrfoyMap ;
    Map<String,Scheduler__c> ScheduleMap ;

    for(Scheduler__c TSche: [SELECT Queue_Name__r.Name,Count__c,Current_User_ID__c,Current_User_Name__c,Id,Last_Assigned__c,Lead_Limit__c,Name,Next_User_Id__c,Next_User_Name__c,OOO__c,Queue_Name__c,User_Proficiency_Level__c FROM Scheduler__c]){                          

        if(mapScheduler.containsKey(TSche.Queue_Name__r.Name)){
            PrfoyMap = mapScheduler.get(TSche.Queue_Name__r.Name);
                if(PrfoyMap.containsKey(TSche.User_Proficiency_Level__c)){
                    if(!PrfoyMap.get(TSche.User_Proficiency_Level__c).containsKey(TSche.Name)){
                                PrfoyMap.get(TSche.User_Proficiency_Level__c).put(TSche.Name,TSche);
                    }
                }
                else{
                    ScheduleMap = new Map<String,Scheduler__c>();
                    ScheduleMap.put(TSche.Name,TSche);
                    PrfoyMap.put(TSche.User_Proficiency_Level__c,ScheduleMap);
                }
        }
        else{
            PrfoyMap = new Map<Decimal,Map<String,Scheduler__c>>();
            ScheduleMap = new Map<String,Scheduler__c>();
            ScheduleMap.put(TSche.Name,TSche);
            PrfoyMap.put(TSche.User_Proficiency_Level__c,ScheduleMap);
            mapScheduler.put(TSche.Queue_Name__r.Name,PrfoyMap);
        }
    }
    
    System.debug('***************mapScheduler'+mapScheduler);


    TotalLeads=TLeads.size();
    //Parse through leads that have not yet been processed for Round Robin
    For(Lead L:TLeads){
        
        try{
        System.debug('***************Parse through leads that have not yet been processed for Round Robin'+l.Name+' - '+l.Owner.Name);

        // Save Current Queue Information
        if(l.Owner.Name != LVarLastQueueName)
            LVarLastQueueName = l.Owner.Name;
        
        LVarQLevel = MapTRRMatrix.get(LVarLastQueueName).Current_queue_proficiency_level__c;
        List<Decimal> QueueProficiencies = new List<Decimal>();
        if(mapScheduler.containsKey(LVarLastQueueName))
            QueueProficiencies.addAll(mapScheduler.get(LVarLastQueueName).keyset());
        else // No scheduler records found for the Queue
            {
            //Changes for B- 266662 Starts
            ExceptionList.add( new ErrorLogHandler.batchErrorLogWrapper ( '','RoundRobinSheduler',LVarLastQueueName+': No scheduler records found for the Queue','Business'))  ;
            //Changes for B- 266662 Ends
            continue;
            }
        QueueProficiencies.sort();
        integer CurrentIndex;
        for(Integer i = 0; i<QueueProficiencies.size();i++){
            if(QueueProficiencies[i] == LVarQLevel){
                CurrentIndex = i;
                break; 
            }
        }
        
        System.debug('***************CurrentIndex'+CurrentIndex); 
        System.debug('***************QueueProficiencies'+QueueProficiencies);
        System.debug('***************Next_assigned_user__c'+MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c);

        // Added for OOO
        System.debug('***************Added for OOO');
        List<Scheduler__c> listschedulerOOO = new List<Scheduler__c>();
        SchedulerWrapper[] listSchedWrapperOOO = new List<SchedulerWrapper>();

        for(Integer i = 0; i<CurrentIndex;i++)
            listschedulerOOO.addAll(mapScheduler.get(LVarLastQueueName).get(QueueProficiencies[i]).values());

        System.debug('***************listschedulerOOO'+listschedulerOOO); 
      
        for(Scheduler__c s : listschedulerOOO)
            listSchedWrapperOOO.add(new SchedulerWrapper(s));

        listSchedWrapperOOO.sort();

    System.debug('***************listSchedWrapperOOO'+listSchedWrapperOOO);
       
        for(SchedulerWrapper sw :listSchedWrapperOOO){
            if(mapTUser.get(sw.Sched.Name).OOO__c == false && (mapTUser.get(sw.Sched.Name).count__c < mapTUser.get(sw.Sched.Name).Lead_limit__c || mapTUser.get(sw.Sched.Name).Unlimited_Leads__c == true)){
                System.debug('***************if user is not ooo'+sw.Sched.Name);
                MapTRRMatrix.get(LVarLastQueueName).Current_queue_proficiency_level__c = sw.Sched.User_Proficiency_Level__c;
                MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c = sw.Sched.Name;
                break;
            } 
        }

        // Added for OOO  
        System.debug('***************LVarLastQueueName'+LVarLastQueueName);

        Double TimeMin;
        Double waitTime;
        if((MapTRRMatrix.get(LVarLastQueueName).Round_robin_status__c == 'W')){
            TimeMin = MapTRRMatrix.get(LVarLastQueueName).Round_robin_time__c;
            waitTime = (TimeMin/60)/24;
        }

        // Verify if lead is ready to be assigned (Time + WaitTime >= Current DateTime)
        if(MapTRRMatrix.get(LVarLastQueueName).Round_robin_status__c == 'W' && (l.CreatedDate + waitTime) >= datetime.now()){
            continue;// Go to next Lead
        }
        LVarAssigned = FALSE;
     
        // Assign Lead
        while(!LVarAssigned){
     
            // When no more people available skip lead
            if(MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c == '' || MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c == null){
                LVarAssigned = True;
                System.debug('***************When no more people available skip lead');
                //Changes for B- 266662 Starts
                ExceptionList.add( new ErrorLogHandler.batchErrorLogWrapper ( L.Id,'RoundRobinSheduler',LVarLastQueueName+': When no more LO\'s available to assign in the Queue- All Lead Limit Reached','Business'))   ;
               //Changes for B- 266662 Ends
                Continue;
            }
         
            // Determine if Current User is OOO
            Boolean NextUserFound = false; 
            String OOOUser = MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c; 
            While(!NextUserFound){
                if(mapTUser.get(MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c).OOO__c == true ){
                    System.debug('***************Determine if Current User is OOO');
          
         
                    // Update TRRMatrix with Next Userid
                    MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c =  mapScheduler.get(MapTRRMatrix.get(LVarLastQueueName).Name).get(MapTRRMatrix.get(LVarLastQueueName).Current_queue_proficiency_level__c).get(MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c).Next_User_Name__c;

                    if(mapTUser.get(MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c).OOO__c == False){
                        NextUserFound = true;
                        continue;
                    } 
         
                    // Add to qlevel when last user
                    if(MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c == OOOUser){
                        CurrentIndex +=1;
                        if(CurrentIndex < QueueProficiencies.size())
                        MapTRRMatrix.get(LVarLastQueueName).Current_queue_proficiency_level__c = QueueProficiencies[CurrentIndex];

                        else{//reached end of Proficiency level
                            LVarAssigned = True;
                            NextUserFound = true;
                            //MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c = '';// need to comment this out.
                            
                            ExceptionList.add( new ErrorLogHandler.batchErrorLogWrapper ( L.Id,'RoundRobinSheduler',LVarLastQueueName+': All other LO\'s in the Queue are OOO','Business'))    ;
                            continue;
                        }
          
                        //sort next proficiency user based on id  
                        List<Scheduler__c> listsh = mapScheduler.get(MapTRRMatrix.get(LVarLastQueueName).Name).get(MapTRRMatrix.get(LVarLastQueueName).Current_queue_proficiency_level__c).values();
                        SchedulerWrapper[] SchedList = new List<SchedulerWrapper>();

                        for(Scheduler__c s : listsh)
                        SchedList.add(new SchedulerWrapper(s));

                        SchedList.sort();
                        MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c = SchedList[0].Sched.Name;
                        OOOUser = MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c; 
                    }
                    System.debug('***************AfterMapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c'+MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c);
                    continue;
                }
                else
                    NextUserFound = true;
            }
         
            if(LVarAssigned == True)
                continue;
            // Reset LeadLimit Flag
            LVarLeadLimitReached = FALSE;
         
         
         
            // Verify if the just assigned user reached the limit 
         
            if((mapTUser.get(MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c).Unlimited_Leads__c == true)){
                LVarLeadLimitReached = FALSE;
            } 
            else if((mapTUser.get(MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c).Count__c >= mapTUser.get(MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c).Lead_limit__c ))
                LVarLeadLimitReached = TRUE;
         
            System.debug('***************Verify if the just assigned user reached the limit Or User is OOO'+LVarLeadLimitReached);

          
            // Update TSchedule when daily limit reached
            if(LVarLeadLimitReached){
                System.debug('***************Update TSchedule when daily limit reached');
                // Save Current User to Local Variable
                String LVarPrevUser = MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c;
                System.debug('***************Save Current User to Local Variable'+LVarPrevUser);
      
                // Update TRRMatrix with Next Userid
                MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c =  mapScheduler.get(MapTRRMatrix.get(LVarLastQueueName).Name).get(MapTRRMatrix.get(LVarLastQueueName).Current_queue_proficiency_level__c).get(MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c).Next_User_Name__c;
                System.debug('***************Update TRRMatrix with Next Userid'+ MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c);
       
                // Add to qlevel when last user
                if(MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c == LVarPrevUser){
                    System.debug('***************Add to qlevel when last user');
                    mapScheduler.get(MapTRRMatrix.get(LVarLastQueueName).Name).get(MapTRRMatrix.get(LVarLastQueueName).Current_queue_proficiency_level__c).get(MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c).Next_User_Name__c = '';
      
                    CurrentIndex +=1;
                    if(CurrentIndex < QueueProficiencies.size()){
                        MapTRRMatrix.get(LVarLastQueueName).Current_queue_proficiency_level__c = QueueProficiencies[CurrentIndex];
                        system.debug('***************Current_queue_proficiency_level__c'+MapTRRMatrix.get(LVarLastQueueName).Current_queue_proficiency_level__c);      
                        system.debug('***************checking next proficiency value'+mapScheduler.get(MapTRRMatrix.get(LVarLastQueueName).Name).get(MapTRRMatrix.get(LVarLastQueueName).Current_queue_proficiency_level__c)) ;     
                    }
                    else{//reached end of Proficiency level
                        LVarAssigned = True;
                        MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c = '';
                        //Changes for B- 266662 Starts
                        ExceptionList.add( new ErrorLogHandler.batchErrorLogWrapper ( L.Id,'RoundRobinSheduler',LVarLastQueueName+': All other LO\'s in the Queue have reached their Lead Limit','Business'))  ;
                        //Changes for B- 266662 Ends
                        continue;
                    }
                    //sort next proficiency user based on id
      
                    List<Scheduler__c> listsh = mapScheduler.get(MapTRRMatrix.get(LVarLastQueueName).Name).get(MapTRRMatrix.get(LVarLastQueueName).Current_queue_proficiency_level__c).values();
                    SchedulerWrapper[] SchedList = new List<SchedulerWrapper>();

                    for(Scheduler__c s : listsh)
                    SchedList.add(new SchedulerWrapper(s));

                    SchedList.sort();
                    MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c = SchedList[0].Sched.Name;
                }
                // Else still more people to assign
                else{
                    System.debug('***************Else still more people to assign');
                    // Blank out Next User
                    mapScheduler.get(MapTRRMatrix.get(LVarLastQueueName).Name).get(MapTRRMatrix.get(LVarLastQueueName).Current_queue_proficiency_level__c).get(LVarPrevUser).Next_User_Name__c = '';
                    System.debug('***************Blank out Next User'+mapScheduler.get(MapTRRMatrix.get(LVarLastQueueName).Name).get(MapTRRMatrix.get(LVarLastQueueName).Current_queue_proficiency_level__c).get(LVarPrevUser));
      
                    For(Scheduler__c sh : mapScheduler.get(MapTRRMatrix.get(LVarLastQueueName).Name).get(MapTRRMatrix.get(LVarLastQueueName).Current_queue_proficiency_level__c).values()){
                        if(sh.Next_User_Name__c == LVarPrevUser){
                            mapScheduler.get(MapTRRMatrix.get(LVarLastQueueName).Name).get(MapTRRMatrix.get(LVarLastQueueName).Current_queue_proficiency_level__c).get(sh.Current_User_Name__c).Next_User_Name__c = MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c;
                            System.debug('***************mapScheduler.get(MapTRRMatrix.get(LVarLastQueueName).Name).get(MapTRRMatrix.get(LVarLastQueueName).Current_queue_proficiency_level__c).get(sh.Current_User_Name__c).Next_User_Name__c'+mapScheduler.get(MapTRRMatrix.get(LVarLastQueueName).Name).get(MapTRRMatrix.get(LVarLastQueueName).Current_queue_proficiency_level__c).get(sh.Current_User_Name__c).Next_User_Name__c);
                            break;
                        }
             
                    }
                }
            LVarAssigned = FALSE;
            }
            else{
                 
                // Update Lead Owner to TRRMatrix User
                l.ownerid = mapTUser.get(MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c).id;
                l.Is_assigned_already__c = true;
                //Instant Round robin code -begins
                if(rrState==true)
                {
                    l.Lead_Owner_Queue__c = ''; // Added by Sunil for B-407395
                    for(User u:TUser)
                    {
                      if(u.id==l.ownerid)
                      {
                        DateTime dtInstant = l.CreatedDate;
                        
                        if(l.CreatedDate==Datetime.now() || l.CreatedDate==null || Datetime.now()<dtInstant.addSeconds(10))
                        {
                            emailLead.setToAddresses(new String[]{u.email});
                            emailLead.setSubject('New Lead is Assigned to you: '+string.valueOf(l.name));    
                            String eString=URL.getSalesforceBaseUrl().toExternalForm()+'/'+string.valueOf(l.id);                    
                            String messageBody = '<html><body>Hi, You have been assigned a new Lead: '+string.valueOf(l.name)+' <a href="'+eString+'">Click Here to View Lead in Salesforce</a> </body>  </html>';    
                            emailLead.setHtmlBody(messageBody);    
                            emailLead.setReplyTo('jvimalprasath@gmail.com');   
                            emailLead.setSenderDisplayName('jvimalprasath@gmail.com'); 
                            List<Messaging.SendEmailResult> results = Messaging.sendEmail(new Messaging.Email[] { emailLead }); 
                        }
                        l.Lead_Owner_Role_RR__c=u.UserRole.Name;
                        if(l.Lead_Owner_Role_RR__c.contains('Home Equity'))
                        {
                            l.RecordTypeid=heRecID;
                        }
                        else
                        {
                            l.RecordTypeid=preRecID;
                        }
                        l.Lead_Owner_EID__c=u.FederationIdentifier;
                        
                       }
                    }
                }             // Instant round robin code ends
                updateLeads.add(l);
                System.debug('***************Update Lead Owner to TRRMatrix User'+l.ownerid);
     
                // Update TUser with Date and Count
                mapTUser.get(MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c).Last_assigned__c = datetime.now();
                mapTUser.get(MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c).Count__c += 1;
                System.debug('***************Update TUser with Date and Count'+mapTUser.get(MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c).Count__c);
     
                // Update TRRMatrix with Next Userid
                System.debug('***************QueueName'+mapScheduler.get(MapTRRMatrix.get(LVarLastQueueName).Name));
                System.debug('***************QueueProficiency'+mapScheduler.get(MapTRRMatrix.get(LVarLastQueueName).Name).get(MapTRRMatrix.get(LVarLastQueueName).Current_queue_proficiency_level__c));
                System.debug('***************NextUser'+mapScheduler.get(MapTRRMatrix.get(LVarLastQueueName).Name).get(MapTRRMatrix.get(LVarLastQueueName).Current_queue_proficiency_level__c).get(MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c).Next_User_Name__c);
                MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c =  mapScheduler.get(MapTRRMatrix.get(LVarLastQueueName).Name).get(MapTRRMatrix.get(LVarLastQueueName).Current_queue_proficiency_level__c).get(MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c).Next_User_Name__c;
                System.debug('***************Update TRRMatrix with Next Userid'+ MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c);
      
                // Update TScheduler with Date and Count 
                mapScheduler.get(MapTRRMatrix.get(LVarLastQueueName).Name).get(MapTRRMatrix.get(LVarLastQueueName).Current_queue_proficiency_level__c).get(MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c).Count__c += 1;
                mapScheduler.get(MapTRRMatrix.get(LVarLastQueueName).Name).get(MapTRRMatrix.get(LVarLastQueueName).Current_queue_proficiency_level__c).get(MapTRRMatrix.get(LVarLastQueueName).Next_assigned_user__c).Last_Assigned__c =datetime.now();
     
                // Confirmed Lead Assigned
                LVarAssigned = TRUE;
                System.debug('***************Confirmed Lead Assigned'+LVarAssigned);
            }   
        }// end of while loop.
        }
        //Changes for B- 266662 Starts
        catch (Exception Ex)
        {
            
            ExceptionList.add( new ErrorLogHandler.batchErrorLogWrapper ( L.Id,'RoundRobinSheduler','Message: '+ Ex.getmessage()+ ' Line Number: '+ Ex.getLineNumber()+' Stack Trace: '+ ex.getStackTraceString() ))    ;
            
        }
        //Changes for B- 266662 Ends
    }//end of For Loop.
    System.debug('***************UpdatedmapScheduler'+mapScheduler);

    For(String s :mapScheduler.keyset()){
        for(Decimal d : mapScheduler.get(s).keyset()){
            for(Scheduler__c sh : mapScheduler.get(s).get(d).values()){
                updateTSchedule.add(sh);
            }
        }
    }

    for(user u :mapTUser.values())
        updateTUser.add(u);

    for(RRB_Queue_Matrix__c q :MapTRRMatrix.values())
        updateTRRMatrix.add(q);

    update updateLeads;
    update updateTRRMatrix;
    update updateTSchedule;
    update updateTUser;
    /*
    for(Lead l:updateLeads)
    {
        Messaging.SingleEmailMessage emailLead = new Messaging.SingleEmailMessage();
        emailLead.setToAddresses(new String[]{l.Instant_Lead_OwnerEmail__c});
        emailLead.setTargetObjectId(l.id);
        emailLead.setTemplateId(emailTemplate.id);
        List<Messaging.SendEmailResult> results = Messaging.sendEmail(new Messaging.Email[] { emailLead });
                    
    }
    */
    //Changes for B- 266662 Starts
    SuccesfullLeads=updateLeads.size();
    
     ThisJobDetail.End_Time__c=System.now();
    ThisJobDetail.Success_Records__c = SuccesfullLeads;
    ThisJobDetail.Total_Records__c = TotalLeads;
    insert ThisJobDetail;
    
    if(ExceptionList.size()>0)
    {
    for (ErrorLogHandler.batchErrorLogWrapper   ExceptionRec:ExceptionList)
    {
        ExceptionRec.ApexJobMasterId = ThisJobDetail.Id;
    }
    ErrorLogHandler ObjErrLogHdlr = new ErrorLogHandler ();
    ObjErrLogHdlr.batchCreateLog(ExceptionList);
    if(IsPrepareExceptionEmail)
       ObjErrLogHdlr.batchSendEmailException(ExceptionList);
    else
        ObjErrLogHdlr.batchCreateLog(ExceptionList);
    }
    
    isRun=false;
   //Changes for B- 266662 Ends
    
    }
    //Changes for B- 266662 Starts
    catch (exception ex)
    {
       
        ThisJobDetail.Error_Message__c=Ex.getmessage();
        ThisJobDetail.End_Time__c= System.now();
        insert ThisJobDetail;
         for (ErrorLogHandler.batchErrorLogWrapper   ExceptionRec: ExceptionList)
    {
        ExceptionRec.ApexJobMasterId  = ThisJobDetail.Id;
    }
     ErrorLogHandler ObjErrLogHdlr = new ErrorLogHandler ();
        ExceptionList.add( new ErrorLogHandler.batchErrorLogWrapper ( '','RoundRobinSheduler','Message: '+ Ex.getmessage()+ ' Line Number: '+ Ex.getLineNumber()+' Stack Trace: '+ ex.getStackTraceString() ))    ;
        ObjErrLogHdlr.batchSendEmailException(ExceptionList);
    
    }
    //Changes for B- 266662 Ends
    }
    
    
}