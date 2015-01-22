/* 
Description: Historical Lead data fix for Duplicates and Lead Conversion - Apex Job updates.
 Author - Richard Joseph
 Created Date- March 20th, 2014            
 User Story - B-367850 


*/
global class BatchClass_HistoricLeadConversionFix implements Database.Batchable<sObject>,Database.Stateful{


   global String QueryStr = null;
    
 

   global Database.QueryLocator start(Database.BatchableContext BC){ 
       
       
    If  (QueryStr == null)
       {
        QueryStr = 'Select Id From lead Where Owner.IsActive = true AND owner.type <> \'Queue\' AND RecordType.Name = \'ToBeConverted\'';
       }
       
   
        return Database.getQueryLocator(QueryStr );
   }

   global void execute(Database.BatchableContext BC, List<sObject> ScopeList){
      
    
      try{     
           Set <id> ProcessingIdSet = new Set<Id> ();
           list <Lead> toUpdateLeadList = new list<Lead>();
           list<Account> toUpdateAccountList = new List<Account>();
           list <Opportunity> toUpdateOpportunityList = new List<Opportunity>(); 
           
           For (Sobject SobjectRec:ScopeList )
           {
            
            ProcessingIdSet.Add(SobjectRec.Id);
            
           }
//            
           
           if (ProcessingIdSet.Size() > 0)
           {
            
                LeadDuplicateProcessing LDPObj =new LeadDuplicateProcessing();
                LDPObj.DuplicateProcessingHistoricBatch(ProcessingIdSet); 
                
                 List<Lead> LeadList = new List<Lead>([Select Account_Name__c,ANNUAL_HOME_OWNER_S_ASSOCIATION_DUES__C,ANNUAL_HOMEOWNER_S_INSURANCE__C,ANNUAL_REAL_ESTATE_TAXES__C,APPLICANT_TYPE__C,BEST_CONTACT_TIME__C,BORROWERS_ADDRESS_1__C,BORROWERS_ADDRESS_2__C,BORROWERS_APT__C,BORROWERS_CITY__C,BORROWERS_COUNTRY__C,BORROWERS_COUNTY__C,BORROWERS_CURRENT_RESIDENCE__C,BORROWERS_FAX__C,BORROWERS_HOME_PHONE__C,BORROWERS_MOBILE_PHONE__C,BORROWERS_STATE__C,BORROWERS_WORK_PHONE__C,BORROWERS_WORK_PHONE_EXTN__C,BORROWERS_ZIP_POSTAL_CODE__C,BORROWERSHOUSE__C,CHANNEL__C,CHANNEL_SOURCES__C,CHANNEL_VALUES__C,CIF__C,CLOSING_DATE__C,Co_Borrower__c,CO_BORROWERS_ADDRESS_1__C,CO_BORROWERS_ADDRESS_2__C,CO_BORROWERS_APT__C,CO_BORROWERS_CITY__C,CO_BORROWERS_COUNTRY__C,CO_BORROWERS_COUNTY__C,CO_BORROWERS_CURRENT_RESIDENCE__C,CO_BORROWERS_EMAIL__C,CO_BORROWERS_FAX__C,CO_BORROWERS_FIRST_NAME__C,CO_BORROWERS_HOME_PHONE__C,CO_BORROWERS_HOUSE__C,CO_BORROWERS_LAST_NAME__C,CO_BORROWERS_MOBILE_PHONE__C,CO_BORROWERS_STATE__C,CO_BORROWERS_TITLE__C,CO_BORROWERS_WORK_PHONE__C,CO_BORROWERS_WORK_PHONE_EXTN__C,CO_BORROWERS_ZIP_POSTAL_CODE__C,CONVERTEDACCOUNTID,DONOTCALL,EMAIL,EMPOWER_LEAD_ID__C,FIRSTNAME,HASOPTEDOUTOFEMAIL,HLR_LEAD_ID__C,HOW_WOULD_YOU_DESCRIBE_YOUR_CREDIT__C,ID,LANGUAGE__C,LASTNAME,LOAN_PURPOSE__C,LOAN_TERM__C,LOAN_TYPE__C,MARITAL_STATUS__C,OCCUPANCY_CODE__C,ownerID,PRODUCT_PREFERENCES__C,PROPERTY_ADDRESS_1__C,PROPERTY_ADDRESS_2__C,PROPERTY_APT__C,PROPERTY_CITY__C,PROPERTY_COUNTRY__C,PROPERTY_COUNTY__C,PROPERTY_HOUSE__C,PROPERTY_STATE__C,PROPERTY_TYPE__C,PROPERTY_ZIP_POSTAL_CODE__C,RATING,REQUESTED_LOAN_AMOUNT__C,RecordTypeID,Related_Opportunity__c,SHOPPING_STAGE__C,STATUS,TARGET_OPPORTUNITY_NAME__C,TIME_ZONE__C,TITLE,TRANSFER_TO_HLR__C,VALUE_OF_HOME__C from Lead where Id in :ProcessingIdSet  ] );
                
                For(Lead LeadRec: LeadList)
                            {
                if(LeadRec.Related_Opportunity__c == null)
                {
                    Lead toUpdateLeadRec = new Lead();
                    if(LeadRec.Account_Name__c == null)
                    {
                        if(LeadRec.Co_Borrowers_Last_Name__c != null && Leadrec.Co_Borrower__c == null)
                        {
                            
                           // toUpdateLeadRec =(Lead) OBJCNVTR.SmartEngine.Convert(LeadRec, 'Borrower_Details,Co_Borrower_Details,Property_details',true);
                            toUpdateLeadList.add(toUpdateLeadRec);
                            toUpdateAccountList.add(new Account (Id=toUpdateLeadRec.Account_Name__c, OwnerId=toUpdateLeadRec.OwnerId));
                            toUpdateAccountList.add(new Account (Id=toUpdateLeadRec.Co_Borrower__c, OwnerId=toUpdateLeadRec.OwnerId));
                            toUpdateOpportunityList.add(new Opportunity(Id=toUpdateLeadRec.Related_Opportunity__c, OwnerId=toUpdateLeadRec.OwnerId));
                            
                        }
                        else if(LeadRec.Co_Borrowers_Last_Name__c == null )
                        {
                            //toUpdateLeadRec =(Lead) OBJCNVTR.SmartEngine.Convert(LeadRec, 'Borrower_Details,Property_details',true);
                            toUpdateLeadList.add(toUpdateLeadRec);
                            toUpdateAccountList.add(new Account (Id=toUpdateLeadRec.Account_Name__c, OwnerId=toUpdateLeadRec.OwnerId));
                            toUpdateOpportunityList.add(new Opportunity(Id=toUpdateLeadRec.Related_Opportunity__c, OwnerId=toUpdateLeadRec.OwnerId));
                            
                        }
                        
                    }
                    else
                    {
                        
                        if(LeadRec.Co_Borrowers_Last_Name__c != null && Leadrec.Co_Borrower__c == null)
                        {
                            //toUpdateLeadRec =(Lead) OBJCNVTR.SmartEngine.Convert(LeadRec, 'Co_Borrower_Details,Property_details',true);
                            toUpdateLeadList.add(toUpdateLeadRec);
                            toUpdateAccountList.add(new Account (Id=toUpdateLeadRec.Co_Borrower__c, OwnerId=toUpdateLeadRec.OwnerId));
                            toUpdateOpportunityList.add(new Opportunity(Id=toUpdateLeadRec.Related_Opportunity__c, OwnerId=toUpdateLeadRec.OwnerId));
                        }
                        else if(LeadRec.Co_Borrowers_Last_Name__c == null )
                        {
                           // toUpdateLeadRec =(Lead) OBJCNVTR.SmartEngine.Convert(LeadRec, 'Property_details',true);
                            toUpdateLeadList.add(toUpdateLeadRec);
                            toUpdateOpportunityList.add(new Opportunity(Id=toUpdateLeadRec.Related_Opportunity__c, OwnerId=toUpdateLeadRec.OwnerId));
                        }
                        
                    }
                }
                
            }
            
           }
           
           if(toUpdateLeadList.size()>0)        
            Update toUpdateLeadList;
            if(toUpdateAccountList.size() > 0)
            Update toUpdateAccountList;
            if(toUpdateOpportunityList.size() > 0)
            Update toUpdateOpportunityList;
      }
      catch(Exception ex)
      {
        
        ErrorLogHandler ErrObj = new ErrorLogHandler();
        ErrObj.createLog('HistoricLeadConversionFix','', '','Message: '+ Ex.getmessage()+ ' Line Number: '+ Ex.getLineNumber()+' Stack Trace: '+ ex.getStackTraceString()  ,'' );
        
      }
       
   }

   global void finish(Database.BatchableContext BC){
    
 //Changes for 344624 by Richard Starts here
 //String ToEmailAddress= Label.MDW_Report_Email_Address;  
 //String[] ToEmailAddress= String.Valueof(Label.MDW_Report_Email_Address).Split(';');  
    
    Boolean JobSuccess = true;
AsyncApexJob a = [Select Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email,ExtendedStatus  from AsyncApexJob where Id =:BC.getJobId()];
 
        String ToEmailAddress= a.CreatedBy.Email;

String emailMessage='';   
       Messaging.SingleEmailMessage JobMail = new Messaging.SingleEmailMessage();
       
       String[] toJobAddresses = new String[] {ToEmailAddress};
       JobMail .setToAddresses(toJobAddresses );
       JobMail .setSubject('Historic Lead Conversion ' + a.Status);
       if(a.NumberOfErrors >0){
        JobSuccess = false;
           ErrorLogHandler ErrObj = new ErrorLogHandler();
           ErrObj.createLog('HistoricLeadConversionFix','', '',a.ExtendedStatus ,'' );
       
           emailMessage=a.TotalJobItems + ' batch(s) of lead. With error batch(s) as '+ a.NumberOfErrors ;
       }else{
           emailMessage=a.TotalJobItems + ' batch(s) of Lead was successfull.' ;
       }        
       JobMail .setPlainTextBody(emailMessage);

   
 

Messaging.SendEmailResult [] ResultFailed = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {JobMail });


   
   }

}
/*
To Test Execute

BatchClass_HistoricLeadConversionFix MDWObj  = new BatchClass_HistoricLeadConversionFix ();
Database.executeBatch(MDWObj, 20);
*/