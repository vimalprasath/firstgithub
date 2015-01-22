public with sharing class mySofiLeadListViewController {

    public List<SelectOption> UserListGS {get; set;} 
    public List<SelectOption> statusoptions {get; set;} 
    public List<SelectOption> loanpurposeoptions {get; set;} 
    public List<SelectOption> sourceoptions {get; set;}  
    public boolean hide{get;set;}
    Public boolean searchflag{get;set;}
    Public boolean searchflag1{get;set;}
    Public boolean listflag{get;set;}
    public String TName {get; set;}
    public String TPropertyS {get; set;}
    public String Tsource {get; set;}
    public String SelectedU {get; set;}
    public lead filterlead {get; set;}
    public String Selectedstatus {get; set;}
    public String Selectedloanpurpose {get; set;}
    public String Selectedsource {get; set;}
    public date todate {get; set;}
    public date fromdate {get; set;}
    public String searchType{get; set;}
    public String inputstr{get; set;}
    public boolean errormessage{get;set;}
    public boolean errorname{get;set;}
    public Boolean myFlag{get; set;}
    private String sortExp = 'Status';
    public string sortFullExp;
    public Integer size{get;set;}
    public String ListViewURLID {get;set;}
    private String sortDirection = 'DESC';
    public String pagesize {get;set;}
    public Integer noOfRecords{get;set;}
    public List<lead> led = new List<Lead>();
    List<User> UserList = new List<User>();       
    List<Lead> leads;
    set<Id> leadqueue = new Set<Id>();
    set<Id> inboundqueue = new Set<Id>();
    public string s{get; set;}  
    public List<Lead> filteredLead2{get;set;}
    private integer counter=0;  //keeps track of the offset
    private integer list_size=25; //sets the page size or number of rows
    public integer total_size; //used to show user the total size of the list
    public String sortExpression
       {
         get
         {
            return sortExp;
         }
         set
         {
           //if the column is clicked on then switch between Ascending and Descending modes
           if (value == sortExp)
             sortDirection = (sortDirection == 'ASC')? 'DESC' : 'ASC';
           else
             sortDirection = 'ASC';
           sortExp = value;
         }
       }
         public String getSortDirection()
         {
         //if not column is selected 
         if (sortExpression == null || sortExpression == '')
         return 'ASC';
         else
         return sortDirection;
         }

         public void setSortDirection(String value)
         {  
             sortDirection = value;
         }
/*********Added for pagination  */
   public PageReference Beginning() { //user clicked beginning
      counter = 0;
     if(searchflag == true)                  
       colmnsorting1();
      return null;
   }
 
   public PageReference Previous() { //user clicked previous button
      counter -= list_size;
    if(searchflag == true)                  
       colmnsorting1();
      return null;
   }
 
   public PageReference Next() { //user clicked next button
      counter += list_size;
      if(searchflag == true)                  
       colmnsorting1();
      return null;
   }
 
   public PageReference End() { //user clicked end
      counter = total_size - math.mod(total_size, list_size);
      if(searchflag == true)                  
       colmnsorting1();
      return null;
   }
 
   public Boolean getDisablePrevious() { 
      //this will disable the previous and beginning buttons
      system.debug('*******Previous'+counter);
      if (counter>0) return false; else return true;
   }
 
   public Boolean getDisableNext() { //this will disable the next button
      system.debug('*******Next'+(counter + list_size)+'*TS*'+total_size);
      if (counter + list_size < total_size) return false; else return true;
   }
   
   public Boolean getDisableEnd() { //this will disable the end button
      system.debug('*******Next'+(counter + list_size)+'*TS*'+total_size);
      if (total_size >= 2000) return true;
      if (counter + list_size < total_size) return false; else return true;
   }
/*********/ 
    public mysofiLeadListViewController(){ 
        errormessage= false;
        errorname = false;
        myFlag = false;
        inputstr = 'First Last';
        hide=True;
        searchflag = false;
        listflag = true;
        List<QueueSobject> lstQueues = [SELECT Id,queue.Name, QueueId FROM QueueSobject WHERE SobjectType = 'Lead'];
        for (QueueSobject queueSobject : lstQueues) {
        inboundqueue.add(queueSobject.QueueId );
        }
        
        UserList =  getRoleSubordinateUsers(UserInfo.getUserId());
        UserList.sort(); 
        
        //new
        UserListGS = new List<SelectOption>();
        statusoptions = new List<SelectOption>(); 
        loanpurposeoptions = new List<SelectOption>(); 
        sourceoptions = new List<SelectOption>(); 
        
                                
        UserListGS.add(new SelectOption('None','None'));
        for(user temp1 : UserList){
            UserListGS.add(new SelectOption(temp1.id,temp1.name));         
        }
        
        
        Schema.DescribeFieldResult fieldResult = Lead.status.getDescribe();
        List<Schema.PicklistEntry> lestatus = fieldResult.getPicklistValues();
        statusoptions.add(new SelectOption('None','None'));
        for(Schema.PicklistEntry f : lestatus){
            statusoptions.add(new SelectOption(f.getLabel(), f.getValue()));
        }
        Schema.DescribeFieldResult fieldLoanPurpose = Lead.loan_purpose__c.getDescribe();
        List<Schema.PicklistEntry> leLop = fieldLoanPurpose.getPicklistValues();
        loanpurposeoptions.add(new SelectOption('None','None'));
        for(Schema.PicklistEntry f : leLop){
            loanpurposeoptions.add(new SelectOption(f.getLabel(), f.getValue()));
        }
        Schema.DescribeFieldResult fieldsource = Lead.Channel_Sources__c.getDescribe();
        List<Schema.PicklistEntry> lesource = fieldsource.getPicklistValues();
        sourceoptions.add(new SelectOption('None','None'));
        for(Schema.PicklistEntry f : lesource){
            sourceoptions.add(new SelectOption(f.getLabel(), f.getValue()));
        }
      String q = 'SELECT Name FROM Lead LIMIT 1';
        ApexPages.StandardSetController ACC = new ApexPages.StandardSetController(Database.getQueryLocator(q));
        List<SelectOption> ListViews = ACC.getListViewOptions();
        for(SelectOption w : ListViews ){
        if(w.getLabel()=='My Sofi Leads'){
                ListViewURLID = w.getValue().left(15);
            }
        }
         System.debug('*********My Lead ID'+ListViewURLID);
    }
        
   public void Onload() { 
    try {
    set<Id> leadholdingqueue = new Set<Id>();
    List<QueueSobject> lstQueues = [SELECT Id,queue.Name, QueueId FROM QueueSobject WHERE SobjectType = 'Lead' and (queue.Name Like :'Direct_Inbound' OR queue.Name Like :'Lead Holding'  OR queue.Name Like :'Government Queue')]; 
        for (QueueSobject queueSobject : lstQueues) {
        leadholdingqueue.add(queueSobject.QueueId );
        }
    list<Lead> leadlist1 = new List<Lead>();      
    List<Lead> led =[select id,name,OwnerId,owner.name,status,mobilephone,Source__c,Property_State__c,Channel_Sources__c,Borrowers_State__c,Loan_Type__c,Loan_Purpose__c,Loan_Term__c,email,Empower_Lead_ID__c, createddate, Is_Sofi_Lead__c, My_Lead__c, My_Lead_to_Sofi__c,Transfer_to_hlr__c from Lead where OwnerId not in :leadholdingqueue and isConverted=false and Transfer_To_HLR__c = false and empower_lead_id__c like 'D%' order by LastModifiedDate desc LIMIT 500];     

        for(integer i=0; i<led.size(); i++){
            if(Led[i].Empower_Lead_ID__c != null) {
                if(Led[i].Empower_Lead_ID__c.contains('D')) {
                    Led[i].My_Lead_to_Sofi__c = true;
                    leadlist1.add(led[i]);
                  //  update led[i];
                }          
                myFlag = false;
            }
        }
            update leadlist1;
            }
            catch (exception e) {
            
            }
            
    }
    
    public static List<User> getRoleSubordinateUsers(Id userId) {     
        // get requested user's role
        Id roleId = [select UserRoleId from User where Id = :userId].UserRoleId;
        // get all of the roles underneath the user
        Set<Id> allSubRoleIds = getAllSubRoleIds(new Set<ID>{roleId});
        // get all of the ids for the users in those roles
        List<User> UsersL = [Select Id, Name From User where UserRoleId IN :allSubRoleIds and IsActive = true];
        // return the ids as a set so you can do what you want with them
        return UsersL; 
    }
    
    private static Set<ID> getAllSubRoleIds(Set<ID> roleIds) {
        Set<ID> currentRoleIds = new Set<ID>();     
        // get all of the roles underneath the passed roles
        for(UserRole userRole :[select Id from UserRole where ParentRoleId 
          IN :roleIds AND ParentRoleID != null])
        currentRoleIds.add(userRole.Id);    
        // go fetch some more rolls!
        if(currentRoleIds.size() > 0)
          currentRoleIds.addAll(getAllSubRoleIds(currentRoleIds));
        return currentRoleIds; 
    }
    
    
   public void goLeads(){
      // leads.clear();
   errormessage = false;
   errorname = false;
   hide=false;
   searchflag1 = true;
   searchflag = false;
   counter = 0;
   total_size = 0;

       set<Id> Allqueues = new Set<Id>();
       List<QueueSobject> lstQueues = [SELECT Id,queue.Name, QueueId FROM QueueSobject WHERE SobjectType = 'Lead'];
        for (QueueSobject queueSobject : lstQueues) {
        Allqueues.add(queueSobject.QueueId );
        }
       //actualLeads = new List<LeadWrapper>();
       filteredLead2 = new List<Lead>(); 
       string sname=Tname+'%';
       string querystring;
       querystring='select id,name,owner.name,status,mobilephone,Source__c,Property_State__c,Channel_Sources__c,Borrowers_State__c,Loan_Type__c,Loan_Purpose__c,Loan_Term__c,email,Empower_Lead_ID__c, createddate,My_Lead_to_Sofi__c from Lead where OwnerId not in :Allqueues and empower_Lead_ID__c like \'D%\' ';
       
             
       if(Tname!=null && Tname!=''){
           querystring +=' and name like :sname ';
       }
       if(selectedstatus!='None'){
           if(Tname!=null)
               querystring +=' and ';   
           querystring +='status=:selectedstatus'; 
       }      
       if(selectedloanpurpose!='None'){
           if(Tname!=null || selectedstatus!='None')
               querystring +=' and ';
           querystring +='Loan_purpose__c=:selectedloanpurpose';
       }
       if(selectedsource!='None'){
           if(Tname!=null || selectedstatus!='None' || selectedloanpurpose!='None')
               querystring +=' and ';
           querystring +='channel_sources__c=:selectedsource';
       }
       if(SelectedU!='None'){
           if(Tname!=null || selectedstatus!='None' || selectedsource!='None' || selectedloanpurpose!='None' || TPropertyS!=null)
               querystring +=' and ';
           querystring +='ownerid=:SelectedU';
       }    
       //querystring +=' order by status, createddate desc LIMIT 500';
       filteredLead2=Database.query(querystring);
       //leads1 = [select id,name,owner.name,status,mobilephone,Source__c,Property_State__c,Channel_Sources__c,Borrowers_State__c,Loan_Type__c,Loan_Purpose__c,Loan_Term__c,email, createddate from Lead where (name Like :sname or status=:Selectedstatus or (Borrowers_State__c!=null and Borrowers_State__c =:TPropertyS) or (Loan_purpose__c!=null and Loan_purpose__c =:selectedloanpurpose) or channel_sources__c =: selectedsource or ownerid=:SelectedU) and isConverted=false order by status, createddate desc LIMIT 50000];
       if(filteredLead2 !=null && filteredLead2.size()>0){
           //LeadWrappermethod(leads1);
            searchflag1 = true;
            
           }
      
       
       
   }
      
    
   
   public void colmnsorting1(){
   sortFullExp = sortExpression  + ' ' + sortDirection;                  
   searchflag1 = true; 
   searchflag = false; 
   errormessage = false;
   errorname = false;
   set<Id> Allqueues = new Set<Id>();
       List<QueueSobject> lstQueues = [SELECT Id,queue.Name, QueueId FROM QueueSobject WHERE SobjectType = 'Lead'];
        for (QueueSobject queueSobject : lstQueues) {
        Allqueues.add(queueSobject.QueueId );
        }
       //actualLeads = new List<LeadWrapper>();
       filteredLead2 = new List<Lead>(); 
       string sname=Tname+'%';
       string querystring;
       querystring='select id,name,owner.name,status,mobilephone,Source__c,Property_State__c,Channel_Sources__c,Borrowers_State__c,Loan_Type__c,Loan_Purpose__c,Loan_Term__c,email,Empower_Lead_ID__c, createddate,My_Lead_to_Sofi__c from Lead where OwnerId not in :Allqueues and empower_Lead_ID__c like \'D%\'';
       
             
       if(Tname!=null && Tname!=''){
           querystring +=' and name like :sname ';
       }
       if(selectedstatus!='None'){
           if(Tname!=null)
               querystring +=' and ';   
           querystring +='status=:selectedstatus'; 
       }      
       if(selectedloanpurpose!='None'){
           if(Tname!=null || selectedstatus!='None')
               querystring +=' and ';
           querystring +='Loan_purpose__c=:selectedloanpurpose';
       }
       if(selectedsource!='None'){
           if(Tname!=null || selectedstatus!='None' || selectedloanpurpose!='None')
               querystring +=' and ';
           querystring +='channel_sources__c=:selectedsource';
       }
       if(SelectedU!='None'){
           if(Tname!=null || selectedstatus!='None' || selectedsource!='None' || selectedloanpurpose!='None' || TPropertyS!=null)
               querystring +=' and ';
           querystring +='ownerid=:SelectedU';
       }    
       querystring +=' Order by ' +sortFullExp+' Nulls last';
       filteredLead2=Database.query(querystring);
            
     }
      
    public void refresh(){
       
        searchflag = false;
        searchflag1 = false;
        hide=true;
        selectedstatus='None';
        selectedloanpurpose='None';
        user temp = [select id,name from user where id =: UserInfo.getuserid() limit 1];
        selectedU=temp.name;
        selectedsource='None';
        Tname=null;
        TpropertyS=null;
        inputstr=null;
    }
}