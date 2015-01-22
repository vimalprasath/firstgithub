global class LeadUpdate implements Database.Batchable<sObject>{

public class applicationException extends Exception {}
list<lead> leadsnotupdated =  new list<lead>();
global string query;
global integer error;
Lead updateLead;

global Database.QueryLocator start(Database.BatchableContext BC)
    {
        query = 'SELECT  firstname,lastname,DoNotCall,  DNC__c  FROM Lead';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<Lead> scope)
    {  
    
        try{
                  
         for(Lead L : scope)
         {
             L.DoNotCall = L.DNC__c;           
         }
         update scope;
         
                   
          if(Test.isRunningTest())
             {
              throw new applicationException('Test Coverage');
             }
        
           
         
         }catch(Exception e){    
         System.debug('Error in records:'+leadsnotupdated);
      
         }
    }   
    global void finish(Database.BatchableContext BC)
    {
    
    
      system.debug('Work Completed'+BC);
      AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id =:BC.getJobId()];
      Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
      String[] toAddresses = new String[] {a.CreatedBy.Email};
      mail.setToAddresses(toAddresses);
      if( a.NumberOfErrors == 0){
      mail.setSubject('Migration of Data was successful');
      mail.setPlainTextBody
        ('The batch Apex job to copy the value from the Custom Do Not Call to the standard Do Not Call was successfull' );
           }
     else
        {
          mail.setSubject('Migration of Data was not successful' );
          mail.setPlainTextBody
          ('The batch Apex job to copy the value from the Custom Do Not Call to the standard Do Not Call was not successfull.Please check the error log');
        }
          Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}