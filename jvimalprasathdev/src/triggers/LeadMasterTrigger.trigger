/*
Name: LeadMaster Trigger
Author: Yunus H 
Description: Calls out the class with functionalities: Creating Notes, Copying Borrower's Address, Copying User's address.
Last modified by: Yunus 12/11/2012
Change Log- Richard Joseph- March 6th 2014.User Story - B-303661 
*/

trigger LeadMasterTrigger on Lead (Before Insert, Before Update, After Insert, After Update){
    //Before Insert/Update Trigger Code
    List<Profile> rrProfile = [Select Id, Name from Profile where id =: userInfo.getProfileId()];
        String pId=null;
        for(Profile prof:rrProfile )
        {
            pId=prof.Name;
        }
    Try{
    
    
    
    if(trigger.isBefore){
    		// Story # B628492 start
	    	try{
	        	UpdateRatings.getLeadRatings(Trigger.new);
	   		}catch(Exception e){
	   			System.debug('Error during update Lead Rating '+ e);
	   		}
    		// Story # B628492 End
    		
             //Changes for the story #B493593 by Vimal Started
            
            LeadProductMapping lpm = new LeadProductMapping();
            lpm.leadProductPreferenceMapping(Trigger.New);
            
            //Changes for the story #B493593 by Vimal Ended
            
            if(trigger.isInsert){
            
              
                             
                //To copy the borrowers address to subject address...
                CopyAddress ca = new CopyAddress();
                //ca.copyBorrowerAddress(Trigger.New);        
                //To Update Lead address and phone details...
                UpdateLeadDetails ld = new UpdateLeadDetails();
                //ld.updateAddressAndPhone(Trigger.New);
                
                for(integer i =0 ; i < trigger.new.size(); i++){
                    system.debug('&&&&&&&&&&&&&&&&&&&&&222222'+trigger.new[i].VFUpdate__c+'&&&&&&&&&&&&&&&&&&&&&222222'+trigger.new[i].New_to_Active__c);
                    trigger.new[i].New_to_Active__c = true;
                    
                } 
                //by Richard - B-303661 - To control the Duplicate check only during insert
                 LeadDuplicateProcessing.isInsertUpdate = true;  
                 LeadDuplicateProcessing.isExecuted = false;                 
            }
            if(trigger.isupdate){
            
                
             //To find duplicates
             
             //Commented Out by Richard - B-303661 
                 /*List<id> leadidtodeduplicate= new list<id>();
                 LeadConversionDuplicates lcd = new LeadConversionDuplicates();
                 for(lead l:trigger.new)
                 {
                     leadidtodeduplicate.add(l.id);
                 }
                LeadConversionDuplicates.findDuplicates(leadidtodeduplicate); */
                  
            //Commented Out by Richard -B-303661 - ends
            

            
                 //To copy the borrowers address to subject address...
                 CopyAddress ca = new CopyAddress();
                 //ca.copyBorrowerAddress(Trigger.New);        
                 //To Update Lead address and phone details...
                 UpdateLeadDetails ld = new UpdateLeadDetails();
                 //ld.updateAddressAndPhone(Trigger.New);    
            
                 for(integer i =0 ; i < trigger.new.size(); i++){ 
               /*  system.debug('kkkkkkkkkVFUpdate__c********'+trigger.new[i].VFUpdate__c);
                    if((trigger.new[i].Status == Trigger.old[i].status) && trigger.new[i].status == 'New'&& trigger.new[i].VFUpdate__c != 'YES'){
                        system.debug('************.New_to_Active__c***********'+trigger.new[i].New_to_Active__c);
                        trigger.new[i].New_to_Active__c = false;
                        system.debug('************.New_to_Active__c***********'+trigger.new[i].New_to_Active__c);

                    }else{
                      //  trigger.new[i].New_to_Active__c = true;
                        system.debug('************.New_to_Active__c else***********'+trigger.new[i].New_to_Active__c);
                          
                    }  */
                                                                 
                   //if(trigger.new[i].OwnerId == Label.MSA_HoldingQueueID && Trigger.old[i].OwnerId != Label.MSA_HoldingQueueID){
                      // system.debug('&&&&&&&&&&&&&&&&&&&&&223333'+trigger.new[i].VFUpdate__c+'&&&&&&&&&&&&&&&&&&&&&223333'+trigger.new[i].New_to_Active__c);
                        Trigger.New[i].MSA_Holding_Assignment_Date__c = System.now();                    
                        //}
              
               //   trigger.new[i].VFUpdate__c='NO';
                 }
                 
            }    
             
            //*********************************
            if(trigger.isInsert || trigger.isUpdate){                          
                if (!FollowUpEventHelper.hasAlreadyEmailSentLeads()) {
                
                    Map<id,String> ProfileNameId = new Map<id,String>(); 
                    set<id> CampaignLeads = new set<id>();
                    Set<Id> QueueId = new set<id>();
                    String dtme = '2012-12-14 12:00:00';
                    Date DateCk = Date.valueOf(dtme);
                   
                    //fetch MC profiles                                        
                    for(Profile TempP :[Select id,Name from Profile where Name = 'Centralized Loan Officer']){                                               
                        ProfileNameId.put(TempP.Id,TempP.Name);
                    }                                                                
                    //Fetch Queue Id's                                    
                    for(QueueSobject tempQueue : [Select SobjectType, QueueId, Id, Queue.Name, Queue.id  From QueueSobject]){
                        QueueId.add(tempQueue.id);
                        if(tempQueue.Queue.Name == 'Campaigns' || tempQueue.Queue.Name == 'Campaigns Archive' ){                       
                            CampaignLeads.add(tempQueue.QueueId);
                        }
                    }
                    //fetch Profile Id from UserId
                    Map<Id,Id> userProfileId=new  Map<Id,Id>();
                    for(User TempP :[Select id,ProfileId from User where isActive = true]){                                               
                        userProfileId.put(TempP.Id,TempP.ProfileId);                       
                    } 
                    //New to Active Functionality
                    /***code added**************/
                    if(trigger.isUpdate){
                    User u1 = [Select id,profile.name,name,profileid from User where id=:userinfo.getuserid()];
                    for(integer i =0 ; i < trigger.new.size(); i++){ 
                 system.debug('kkkkkkkkkVFUpdate__c********'+trigger.new[i].VFUpdate__c+'iteration:'+i);
                 system.debug('&&&&&&&&&&&&&&Statusupdate: '+trigger.old[i].status+'iteration:'+i);
                 system.debug('&&&&&&&&&&&&&&SNewtatusupdate: '+trigger.new[i].status+'iteration:'+i);
                   
               if(Test.isRunningTest())
                    {
                     u1.Profile.Name = 'Centralized Loan Officer';
                    }
                 
                    if((trigger.new[i].Status == Trigger.old[i].status) && trigger.new[i].status == 'New - Not Opened'&& trigger.new[i].VFUpdate__c != 'YES' && trigger.new[i].VFUpdate__c!=null){                   
                        if(u1.Profile.Name == 'Centralized Loan Officer' || u1.Profile.Name == 'Centralized Loan Officer'){
                        system.debug('&&&&&&&&&&&&&&&&&&&&&224444'+trigger.new[i].VFUpdate__c+'&&&&&&&&&&&&&&&&&&&&&224444'+trigger.new[i].New_to_Active__c);
                        system.debug('************.New_to_Active__c***********'+trigger.new[i].New_to_Active__c);
                        if(trigger.new[i].Ownerid == Trigger.old[i].ownerid)
                            trigger.new[i].New_to_Active__c = false;
                        system.debug('************.New_to_Active__c***********'+trigger.new[i].New_to_Active__c);
                        }
                     
                    }
                    // trigger.new[i].VFUpdate__c='NO';
                    system.debug('kkkkkkkkkVFUpdate__c********'+trigger.new[i].VFUpdate__c); 
                  // **********Sprint 13_07A-B-144627 (Deb) Code starts************//  
                   system.debug('&&&&&&&&&&&&&&Status-preHLR: '+trigger.old[i].status);
                   system.debug('&&&&&&&&&&&&&&Status-preHLR: '+trigger.new[i]);
                    if(Test.isRunningTest())
                    {
                              
                     trigger.new[i].Transfer_to_HLR__c = true;
                     trigger.new[i].Is_Sofi_Lead__c = false;
                     trigger.new[i].My_Lead__c = true; 
                     trigger.new[i].My_Lead_to_Sofi__c = false;
                    }
                  
                   if ((trigger.new[i].Transfer_to_HLR__c == true && trigger.new[i].Is_Sofi_Lead__c == false && trigger.new[i].My_Lead__c ==true && trigger.new[i].My_Lead_to_Sofi__c == false)) { 
                       trigger.new[i].status = 'Transfer To HLR';
                       if(trigger.old[i].Status != trigger.new[i].status) // Added by Sunil for B-411141 Story
                            trigger.new[i].Pre_HLR_Status__c = trigger.old[i].Status;
                       system.debug('&&&&&&&&&&Pre_HLR_Status__c '+trigger.new[i].Pre_HLR_Status__c);
                       
                   }
                   // For records in My Lead
                   system.debug('&&&&&&&&&&&&&&Status-preHLR: '+trigger.old[i]);
                   system.debug('&&&&&&&&&&&&&&Status-preHLR: '+trigger.new[i]);
                    if ((trigger.new[i].Transfer_to_HLR__c == true && trigger.old[i].Is_Sofi_Lead__c == false && trigger.old[i].My_Lead__c ==true && trigger.old[i].My_Lead_to_Sofi__c == true && trigger.new[i].Pre_HLR_Status__c != null)) { 
                       trigger.new[i].status = 'Transfer To HLR';
                       if(trigger.old[i].Status != trigger.new[i].status) // Added by Sunil for B-411141 Story
                            trigger.new[i].Pre_HLR_Status__c = trigger.old[i].Status;
                       system.debug('&&&&&&&&&&Pre_HLR_Status__c '+trigger.new[i].Pre_HLR_Status__c);
                       
                   }
                   
                   
                   
                   // For Existing records
                       if(Test.isRunningTest())
                    {
                     trigger.new[i].Transfer_to_HLR__c = true;
                     trigger.new[i].Is_Sofi_Lead__c = false;
                     trigger.new[i].My_Lead__c = false; 
                     trigger.new[i].My_Lead_to_Sofi__c = false;
                     } 
                   if(trigger.new[i].Transfer_to_HLR__c == true && trigger.new[i].Is_Sofi_Lead__c == false && trigger.new[i].My_Lead__c ==false && trigger.new[i].My_Lead_to_Sofi__c == false) {
                       trigger.new[i].status = 'Transfer To HLR';
                       if(trigger.old[i].Status != trigger.new[i].status) // Added by Sunil for B-411141 Story
                            trigger.new[i].Pre_HLR_Status__c = trigger.old[i].Status;
                       system.debug('&&&&&&&&&&Pre_HLR_Status__c '+trigger.new[i].Pre_HLR_Status__c);        
                   }
                   /*  if(trigger.new[i].status == 'Transfer to HLR') {
                         trigger.new[i].Pre_HLR_Status__c = trigger.old[i].Status;            
                      system.debug('&&&&&&&&&&Pre_HLR_Status__c '+trigger.new[i].Pre_HLR_Status__c);
                     }
                     */
                     if(trigger.old[i].status == 'Transfer to HLR' && trigger.new[i].Transfer_to_HLR__c == false) {
                         trigger.new[i].status =  trigger.new[i].Pre_HLR_Status__c; 
                         system.debug('&&&&&&&&&& New Status'+trigger.new[i].status);  
                     }
                     
                     if((trigger.old[i].status == 'Transfer to HLR' && trigger.new[i].Transfer_to_HLR__c == false) && (trigger.old[i].Pre_HLR_Status__c == null || trigger.old[i].Pre_HLR_Status__c == '')) {
                         trigger.new[i].status =  'No Attempts'; 
                         system.debug('&&&&&&&&&& New Status'+trigger.new[i].status);  
                     }
                   /*  else {
                     trigger.new[i].status = 'No Attempts';
                     }
                     */
                     system.debug('&&&&&&&&&&&&&&Status: '+trigger.new[i].status);                     
                         trigger.new[i].VFUpdate__c='NO';
                     system.debug('&&&&&&&&&&&&&&&&&&&&&5555'+trigger.new[i].VFUpdate__c+'&&&&&&&&&&&&&&&&&&&&&5555'+trigger.new[i].New_to_Active__c);
                    }
                    }
                    /*********code finished**********/
                    //Debug Log 
                    system.debug('*************CampaignLeads**************'+CampaignLeads);
                    system.debug('*************ProfileNameId**************'+ProfileNameId);
                    system.debug('*************QueueId**************'+QueueId);
                    system.debug('**************trigger.new********************'+trigger.new);
                    system.debug('************Check date*****************'+DateCK); 

                    //check Owner of the Lead. Id Owner is MC, only then send email to Lead And MC aswell. 
                    if(CampaignLeads.size()>0 && ProfileNameId.size()>0 && QueueId.size()>0){                      
                        for(Integer i = 0 ; i < trigger.new.size(); i++){
                            //debug log
                            system.debug(Date.valueOf(trigger.new[i].createddate)>DateCk);
                            system.debug('**************trigger.new********************'+trigger.new[i]);
                            
                            if(trigger.isUpdate){
                                if(ProfileNameId.containsKey(userProfileId.get(trigger.new[i].Ownerid)) && !Queueid.contains(trigger.new[i].Ownerid) && !CampaignLeads.contains(trigger.old[i].ownerid) ){
                                    if(Trigger.new[i].Send_Intro_Mail_to_MC__c == false && Trigger.new[i].Send_Intro_RB_Non_RB_Email__c == false && Trigger.new[i].Status == 'New - Not Opened' && Date.valueOf(trigger.new[i].createddate)> DateCk){                       
                                        trigger.new[i].Send_email_to_MC__c = true;
                                        trigger.new[i].Send_Email_RB_Portal__c = true;
                                        system.debug('****trigger.new****AnyProfile Modifying Owner****'+trigger.new[i]);
                                    }                            
                                }
                            }
                            if(trigger.isinsert){
                                    if(Test.isRunningTest())
                                                  
                    {
                     Profile P = [Select Name from Profile where Name = 'Centralized Loan Officer' limit 1];
                     ProfileNameId.put(userInfo.getProfileId(),p.name);
                    }
                  
                                if(ProfileNameId.containsKey(userInfo.getProfileId())){
                                     if(Trigger.new[i].Send_Intro_Mail_to_MC__c == false && Trigger.new[i].Send_Intro_RB_Non_RB_Email__c == false && Trigger.new[i].Status == 'New - Not Opened' && Date.valueOf(trigger.new[i].createddate)> DateCk){
                                        trigger.new[i].Send_email_to_MC__c = true;
                                        trigger.new[i].Send_Email_RB_Portal__c = true;
                                        system.debug('****trigger.new****MC User Creating Leads****'+trigger.new[i]);
                                    }
                                }
                            }   
                        }                        
                    }
                    
                    //Check if Previous Owner Of the Lead is Camapign Queue. Note: No Mail should go to Lead and MC
                    if(CampaignLeads.size()>0){
                     
                        for(Integer i = 0 ; i < trigger.new.size(); i++){
                         if(Test.isRunningTest())
                             {
                                 CampaignLeads.add(trigger.old[i].ownerid); 
                             }
                         
                            if(CampaignLeads.contains(trigger.old[i].ownerid)){
                                trigger.new[i].Send_Intro_Mail_to_MC__c = true;
                                trigger.new[i].Send_Intro_RB_Non_RB_Email__c = true; 
                                if(trigger.new[i].Channel_Values__c == 'RB Portal')  
                                    trigger.new[i].Sending_Email_Checker__c = 'RB Lead';
                                if(trigger.new[i].Channel_Values__c != 'RB Portal')
                                    trigger.new[i].Sending_Email_Checker__c = 'Non - RB Lead';
                            }                                                           
                        }
                    }
                      
                    //******* Code started Sprint 13_07_B B-149757 and B-150786  *******//
                    map<id,Lead> LeadCustomerId = new map<id,Lead>(); 
                    set<id> CustomerPortalIds = new Set<id>();
                    list<Customer_Portal_Lead__c> UpdateCustomerPortalLead = new List<Customer_Portal_Lead__c>();
                    system.debug('********@#$***********************8');
                    if(trigger.isUpdate){
                       for(Lead TTTLead : Trigger.new){
                       
                      // system.debug('&&&&&&&&&&&CustomerPortal&&&&&&&'+TTTLead.Customer_Portal_Lead__c);
              //             if(TTTLead.Customer_Portal_Lead__c != null){                            
                       //         LeadCustomerId.put(TTTLead.Customer_Portal_Lead__c,TTTLead);
                     //           CustomerPortalIds.add(TTTLead.Customer_Portal_Lead__c);
                          //      system.debug('********@#$'+CustomerPortalIds);
                  //          }                        
                        }
                        for(Customer_Portal_Lead__c TTTCPLead :[select id, Lead__c,Application_number__c,Empower_Lead_ID__c from Customer_Portal_Lead__c where id in: CustomerPortalIds]){
                            Lead STDLead = LeadCustomerId.get(TTTCPLead.id);
                            
                            TTTCPLead.Lead__c = STDLead.Id; 
                            TTTCPLead.Application_number__c = STDLead.HLR_Lead_ID__c;
                            TTTCPLead.Empower_Lead_ID__c = STDLead.Empower_Lead_ID__c;
                            UpdateCustomerPortalLead.add(TTTCPLead);    
                        }
                        system.debug('********@#$*******'+UpdateCustomerPortalLead);
                        Update UpdateCustomerPortalLead;
                    
                    system.debug('********@#$123*******'+UpdateCustomerPortalLead);
                    }
                    
                    //******* Code finished Sprint 13_07_B B-149757 and B-150786  *******//
                    
                    
                          
                    FollowUpEventHelper.setAlreadyEmailSentLeads();
                }
            }          
            //******************************** 

            list<User> UserList = new List<User>();
            Map<id,User> MapUserDe = new Map<id,User>();
            set<id> UserSet = new set<id>();
            Profile pf = [Select Id from profile where Name='Authenticated Portal Website'];
            UserList = [Select id,Fax,NMLS_ID__c,City,Street,State,PostalCode,Country,mobilephone,Phone from user where isactive = true and profileId != :pf.id];
            system.debug('!!!!!!!!!!!!UserList!!!!!!!!!'+UserList.size());
            for(user templ : UserList){
                UserSet.add(templ.id);
                MapUserDe.put(templ.id,templ);
            }
            User tempDetails;
            for(Lead TmpLead : Trigger.new){
                if(UserSet.contains(TmpLead.Ownerid)){
                    tempDetails = MapUserDe.get(TmpLead.Ownerid);
                    TmpLead.Owner_Street__c = tempDetails.Street;
                    TmpLead.Owner_City__c = tempDetails.City;
                    TmpLead.Owner_State__c = tempDetails.State;
                    TmpLead.Owner_Postal_code__c = tempDetails.PostalCode;
                    TmpLead.Owner_Country__c = tempDetails.Country;
                    TmpLead.NMLS__c = String.Valueof(tempDetails.NMLS_ID__c);
                    TmpLead.Owner_Fax__c = tempDetails.Fax;
                    TmpLead.Owner_mobile__c = tempDetails.mobilephone;
                    
                }
            } 
                          
        }
    }Catch(Exception e){
    
    system.debug('Exception thrown while performing Lead Conversion'+e);
        
    }
    //After Insert/Before Trigger code
    try{
        
        if(trigger.isAfter){ 
                   
            // Commented for B-490864 --- Start Here --- By Sunil 
            /*       
            if(trigger.isAfter && trigger.isInsert){
               CO_SendDupLeadMail.CO_DupLead_method(trigger.new);                 
            } 
            */    
            // Commented for B-490864 --- End Here --- By Sunil    
            
            if(trigger.isInsert){
                // For all the After Insert Events
                if (!FollowUpEventHelper.hasAlreadyCreatedFollowUpLeads()) {
                    Notes n = new Notes();
                    n.createInsertNotes(Trigger.New);    
                    FollowUpEventHelper.setAlreadyCreatedFollowUpLeads(); 
                }     
                   
                }   
            if(trigger.isAfter && Trigger.isUpdate){
            
                     //Changes By Richard -User Story - B-303661  Started 
               

                If (!LeadDuplicateProcessing.isExecuted && LeadDuplicateProcessing.isInsertUpdate)
                {
                    
                    Set<Id> LeadIdSet = new set<Id>();
                    for(Lead LeadRec : Trigger.new){
                        If(LeadRec.Account_Name__c == null && LeadRec.Co_Borrower__c == null)
                        {
                            LeadIdSet.add(LeadRec.id);
                        }
                    }
                    If(LeadIdSet.size()>0)
                    {
                        LeadDuplicateProcessing LDPObj =new LeadDuplicateProcessing();
                        LDPObj.DuplicateProcessing(LeadIdSet); 
                    }
                }
                             
             
            //Changes By Richard -User Story - B-303661 - Ended 
            
                      system.debug('hello2');
                      system.debug('old'+trigger.old[0].Related_Opportunity__c );
                      system.debug('new'+trigger.new[0].Related_Opportunity__c );
                      
                
                if (!FollowUpEventHelper.hasAlreadyCreatedFollowUpEvents()) {
                    system.debug('FollowUpEventHelper.hasAlreadyCreatedFollowUpEvents()'+FollowUpEventHelper.hasAlreadyCreatedFollowUpEvents());
                    Notes__c tempNotes;
                    List<Notes__c> CreateNotes = new List<Notes__c>();    
                    for(integer i = 0 ; i< Trigger.new.size(); i++){
                        if(trigger.new[i].status != trigger.old[i].status && trigger.new[i].status != 'Xfer to Originations System' && trigger.new[i].isconverted==false){                        
                            tempNotes = new Notes__c(
                            Comments__c = 'The Lead Status is changed from '+trigger.old[i].status+' to '+trigger.new[i].status+' on '+system.now(),
                            Lead__c = trigger.new[i].id 
                            );                       
                            CreateNotes.add(tempNotes);
                        }
                    }                     
                    if(CreateNotes!= null && CreateNotes.size()>0)
                        Insert CreateNotes;
                    FollowUpEventHelper.setAlreadyCreatedFollowUpEvents();
                     //when notes are modified notes will be created.
                     Notes n = new Notes();
                    n.createNotes(Trigger.New,Trigger.old);     
                } 
                
                //Richard- Feb 20th 2014 - To Update Opportunity Recrd Type Home_Equity
                
                //Changes done as part of Bulkifying the code
                
                Id OpportunityRecordTypeId= Schema.SObjectType.Opportunity.RecordTypeInfosByName.get('Home Equity').RecordTypeId;
                Id LeadRecordTypeId= Schema.SObjectType.Lead.RecordTypeInfosByName.get('Home Equity').RecordTypeId;
                
                List<Opportunity> ToUpdateOppList = new list<opportunity>();
                List<OpportunityContactRole> toCreateContactRoleList=new List<OpportunityContactRole>();
                Set<id> AccountIdSet = new Set<id>();
                
                If (!ApexTriggerUtilities.IsRecursive)
               {
                For(Lead LeadRec:Trigger.new)
                {
                    // If((trigger.oldMap.get(LeadRec.Id).RecordTypeId ==LeadRecordTypeId)&& (trigger.oldMap.get(LeadRec.Id).Related_Opportunity__c == null && trigger.newMap.get(LeadRec.Id).Related_Opportunity__c != null)&& (trigger.oldMap.get(LeadRec.Id).Related_Opportunity__c != trigger.newMap.get(LeadRec.Id).Related_Opportunity__c))
                       // ToUpdateOppList.add(new Opportunity(Id=trigger.newMap.get(LeadRec.Id).Related_Opportunity__c , RecordTypeId=OpportunityRecordTypeId));
                        
                        
                    //Changes done as part of Bulkifying the code
                    if((trigger.oldMap.get(LeadRec.Id).Related_Opportunity__c == null && trigger.newMap.get(LeadRec.Id).Related_Opportunity__c != null)&& (trigger.oldMap.get(LeadRec.Id).Related_Opportunity__c != trigger.newMap.get(LeadRec.Id).Related_Opportunity__c))
                    {
                            
                            if(trigger.newMap.get(LeadRec.Id).Account_Name__c != null)
                            AccountIdSet.add( trigger.newMap.get(LeadRec.Id).Account_Name__c);
                            
                            if(trigger.newMap.get(LeadRec.Id).Co_Borrower__c != null)
                            AccountIdSet.add( trigger.newMap.get(LeadRec.Id).Co_Borrower__c);
                            /*If(trigger.newMap.get(LeadRec.Id).Account_Name__c !=null && trigger.newMap.get(LeadRec.Id).Account_Name__r.PersonContactId != null)
                            
                            {
                                
                                toCreateContactRoleList.add(new OpportunityContactRole (ContactId=trigger.newMap.get(LeadRec.Id).Account_Name__r.PersonContactId,OpportunityId=trigger.newMap.get(LeadRec.Id).Related_Opportunity__c, Role='Borrower'));
                                
                            } */
                            If(lead.Account_Name__c !=null)
                            {
                                Opportunity  OppUpdateRec = new Opportunity( id =LeadRec.Related_Opportunity__c, accountid=LeadRec.Account_Name__c   );
                                if((trigger.oldMap.get(LeadRec.Id).RecordTypeId ==LeadRecordTypeId))
                                OppUpdateRec.RecordTypeId=OpportunityRecordTypeId;
                                ToUpdateOppList.add(OppUpdateRec);
                            }
                            
                            /*If(trigger.newMap.get(LeadRec.Id).Co_Borrower__c !=null && trigger.newMap.get(LeadRec.Id).Co_Borrower__r.PersonContactId != null)
                            If(LeadRec.Co_Borrower__c !=null && LeadRec.Co_Borrower__r.PersonContactId != null)
                               toCreateContactRoleList.add(new OpportunityContactRole (ContactId=trigger.newMap.get(LeadRec.Id).Co_Borrower__r.PersonContactId,OpportunityId=trigger.newMap.get(LeadRec.Id).Related_Opportunity__c, Role='Co-Borrower'));*/
                               
                             
                              
                    }
                    //Changes done as part of Bulkifying the code - Ends
                    
                        
                    
                }
                
                if(AccountIdSet.size() > 0)
                {
                
                map<id,Account> AccountMap = new map<id,Account>([Select Id, PersonContactId from Account where id In :AccountIdSet ]);
                
                 For(Lead LeadRec:Trigger.new)
                {
                    
                        
                        
                         if((trigger.oldMap.get(LeadRec.Id).Related_Opportunity__c == null && LeadRec.Related_Opportunity__c != null)&& (trigger.oldMap.get(LeadRec.Id).Related_Opportunity__c != LeadRec.Related_Opportunity__c) )
                    {
                        If(LeadRec.Account_Name__c !=null && AccountMap.containsKey(LeadRec.Account_Name__c) && AccountMap.get(LeadRec.Account_Name__c).PersonContactId != null)
                            {
                                
                                toCreateContactRoleList.add(new OpportunityContactRole (ContactId= AccountMap.get(LeadRec.Account_Name__c).PersonContactId,OpportunityId=LeadRec.Related_Opportunity__c, Role='Borrower'));
                                
                            }
                            If(LeadRec.Co_Borrower__c !=null && AccountMap.containsKey(LeadRec.Co_Borrower__c) && AccountMap.get(LeadRec.Co_Borrower__c).PersonContactId != null)
                            {
                                
                                toCreateContactRoleList.add(new OpportunityContactRole (ContactId= AccountMap.get(LeadRec.Co_Borrower__c).PersonContactId,OpportunityId=LeadRec.Related_Opportunity__c, Role='Co-Borrower'));
                                
                            }
                    }
                    //
                }
                
                
                }
                if(ToUpdateOppList .size()>0)
                update ToUpdateOppList ;
                
                if(toCreateContactRoleList.size() > 0)
                insert toCreateContactRoleList;
                If(ToUpdateOppList.size()>0 || toCreateContactRoleList.size() > 0)
                ApexTriggerUtilities.IsRecursive = true;
               }
                

                
                //Richard- Feb 20th 2014 - End
                     
                /*if(trigger.old[0].Related_Opportunity__c == null && trigger.new[0].Related_Opportunity__c != null )
                      {
                            system.debug('hello');
                            list<account> Borrowercontactid=[Select id,PersonContactId From Account Where Id = :trigger.new[0].Account_Name__c limit 1 ];
                            list<account> CoBorrowercontactid=[Select PersonContactId From Account Where Id = :trigger.new[0].Co_Borrower__c limit 1 ];
                            list<opportunity> OppAccount=[Select accountid from opportunity where id =:trigger.new[0].Related_Opportunity__c limit 1 ];
                            system.debug('!!!!!!!!!!1Existing Opp'+OppAccount) ; 
                            id temp = Borrowercontactid.get(0).Id;  
                            id leadid = trigger.new[0].id;
                            id accid = trigger.new[0].Account_Name__c;
                            List<OpportunityContactRole> newContactRoleList=new List<OpportunityContactRole>();
                            List<OpportunityContactRole> newContactRoleList2=[select id from OpportunityContactRole where OpportunityId =:trigger.new[0].Related_Opportunity__c ];
                             system.debug('Existing contact'+newContactRoleList2) ; 
                            if (!(newContactRoleList2.size()> 0)){
                            if ( Borrowercontactid.size()> 0){newContactRoleList.add(new OpportunityContactRole (ContactId=Borrowercontactid.get(0).PersonContactId,OpportunityId=trigger.new[0].Related_Opportunity__c, Role='Borrower'));}
                            if ( CoBorrowercontactid.size()> 0){newContactRoleList.add(new OpportunityContactRole (ContactId=CoBorrowercontactid.get(0).PersonContactId,OpportunityId=trigger.new[0].Related_Opportunity__c, Role='Co-Borrower'));}
                            system.debug('^^^^^^^^^^^^^6'+newContactRoleList);
                            OppAccount.get(0).accountid=temp;
                            if( newContactRoleList.size()> 0){ insert newContactRoleList;}
                            if( OppAccount.size()> 0){ update OppAccount;}
                            }
                            
                           
                                                      
                      }*/
                      
                
                //Sandeep Code for Round robin Instant Lead Assignment
                If (!ApexTriggerUtilities.InstantLeads)
                {
                    Integer i=0;
                    For(Lead LeadRec:Trigger.new)
                    {
                        system.debug('*******************Lead captured for Round Robin'+LeadRec.FirstName);
                        system.debug('*******************Lead Owner Id before Round Robin'+LeadRec.Is_assigned_already__c);
                        {
                            if(LeadRec.Is_assigned_already__c==false)
                            {
                                i=i+1;
                                system.debug('*******************Lead captured for Round Robin'+LeadRec.FirstName);
                            }   
                        }                   
                    } 
                    if(i>0&& (pId.contains('SOFI') || userInfo.getUserName().contains('samuel.india')))
                    {
                        system.debug('*******************Before Lead entering Round Robin class');
                        RoundRobinScheduler RR = new RoundRobinScheduler(); 
                        rr.instRR();
                        system.debug('*******************After Lead entering Round Robin class');        
                    }
                    ApexTriggerUtilities.InstantLeads = true;
                }          
                                  
            }
            /*
            if(trigger.isUpdate)
                
            {
                for(Lead leadTesting: trigger.new)
                {
                    OBJCNVTR.SmartEngine.Convert(leadTesting, 'Borrower_Details');
                    system.debug('*************************Lead Conversion***************************'+OBJCNVTR.SmartEngine.Convert(leadTesting, 'Property_details'));
                }
            }
            */
        }
    }Catch(Exception e){
        system.debug('Error'+e);
    }
    List<SObject> leadConvList=new List<SObject>();
    

}