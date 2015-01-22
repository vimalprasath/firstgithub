/* 
Description: Need a report that is the same as today's MDW report when Lead Conversion launches.
 Author - Richard Joseph
 Created Date- March 20th, 2014            
 User Story - B-316184 


*/
global class BatchClass_MDWReportGeneration implements Database.Batchable<sObject>,Database.Stateful{


   global String QueryStr = null;
    
   global blob mailCSVContent = null;

   global Database.QueryLocator start(Database.BatchableContext BC){
       
       
    If  (QueryStr == null)
       {
        List<MDW_Report_Fields__c> MDWFieldsList= [Select id, Name,Field_API_Name__c from MDW_Report_Fields__c ];
     String FieldName = null;
   If(MDWFieldsList.size()>0){
    QueryStr = 'Select id ';
    
    for (MDW_Report_Fields__c MDWFieldRec: MDWFieldsList){
        
        FieldName= MDWFieldRec.Field_API_Name__c;
        
            if (FieldName.contains('Related_Opportunity__r'))
            {
            
            If( FieldName.contains('.'))
            {
                FieldName=FieldName.replaceAll('\\.', ':');
                String[] RelatedFields = FieldName.split(':',5);
            
             If (RelatedFields[0] != null && RelatedFields[1] != null )
             {
                 QueryStr = QueryStr +' , '+ RelatedFields[1] ;
             }
             
            }
            
            
            }
    } 
     
     /*Updated Query for User Story B-461181 [added field Owner.EmployeeNumber] By Sunil   */
      
     QueryStr = QueryStr + ' , Related_Lead__c,Owner.Name,CreatedBy.Name,LastModifiedby.Name, Owner.EmployeeNumber From Opportunity ';
     
     String Criteria= Label.MDW_Report_Criteria;
     
     If (Criteria != null)
          QueryStr =QueryStr  +Criteria;
      
      If (test.isRunningTest())
          QueryStr =QueryStr  + ' Limit 10';    
     
     //WHERE LastModifiedDate >= LAST_N_DAYS:7
     //
   }
   
       }
       
   
        return Database.getQueryLocator(QueryStr );
   }

   global void execute(Database.BatchableContext BC, List<sObject> ScopeList){
      
    
        // try {
            MDWReportGenerator MDWObj = new MDWReportGenerator();
            String ResportContent= MDWObj.ReportGenerator(ScopeList);
            If (mailCSVContent == null)  
                    
             mailCSVContent = Blob.valueOf(MDWObj.ReportHeaderGenerator());
             
            If (ResportContent != null && mailCSVContent != null)
             mailCSVContent = Blob.valueOf(mailCSVContent.toString() + ResportContent );
//            
            
        /*} catch (Exception e) {
            system.debug('Exception Occured '+e);
        } */
   }

   global void finish(Database.BatchableContext BC){
   	
 //Changes for 344624 by Richard Starts here
 //String ToEmailAddress= Label.MDW_Report_Email_Address;  
 String[] ToEmailAddress= String.Valueof(Label.MDW_Report_Email_Address).Split(';');	
   	
   	Boolean JobSuccess = true;
AsyncApexJob a = [Select Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email,ExtendedStatus  from AsyncApexJob where Id =:BC.getJobId()];
If (ToEmailAddress == null)
			ToEmailAddress.add(a.CreatedBy.Email);
		//ToEmailAddress= a.CreatedBy.Email;

String emailMessage='';   
       Messaging.SingleEmailMessage JobMail = new Messaging.SingleEmailMessage();
       
       //String[] toJobAddresses = new String[] {ToEmailAddress};
       JobMail .setToAddresses(ToEmailAddress );
       JobMail .setSubject('MDW Report Generation ' + a.Status);
       if(a.NumberOfErrors >0){
       	JobSuccess = false;
           ErrorLogHandler ErrObj = new ErrorLogHandler();
           ErrObj.createLog('BatchClass_MDWReportGeneration','', '',a.ExtendedStatus ,'' );
       
           emailMessage=a.TotalJobItems + ' batch(s) of Opportunity. With error batch(s) as '+ a.NumberOfErrors ;
       }else{
           emailMessage=a.TotalJobItems + ' batch(s) of Opportunity was successfull.' ;
       }        
       JobMail .setPlainTextBody(emailMessage);




 
 //Label.MDW_Report_Email_Address;     
 
Messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment();

string csvname= 'MDW Report '+System.Today()+'.csv';
If(Label.MDW_Report_Name != null)
	csvname = String.valueof(Label.MDW_Report_Name).replace('YYYYMMDD', Datetime.now().format('YYYYMMdd')) + '.csv';

csvAttc.setFileName(csvname);
csvAttc.setBody(mailCSVContent );
Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();
//String[] toAddresses = new list<string> {ToEmailAddress};
String[] toAddresses = ToEmailAddress;
String subject ='MDW Report '+ Datetime.now().format('YYYY MM dd');
email.setSubject(subject);
email.setToAddresses( toAddresses );
email.setPlainTextBody('MDW Report for '+ Datetime.now().format('YYYY MM dd')+ ' is attached');  
if (mailCSVContent != null)
email.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttc});

If (JobSuccess)
Messaging.SendEmailResult [] ResultSucess = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email });
else
Messaging.SendEmailResult [] ResultFailed = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email,JobMail });


   
   }

}
/*
To Test Execute

BatchClass_MDWReportGeneration MDWObj  = new BatchClass_MDWReportGeneration ();
Database.executeBatch(Obj);
*/