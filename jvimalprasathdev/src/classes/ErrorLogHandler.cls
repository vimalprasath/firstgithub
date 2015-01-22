/* 
Description: This class checks if the newly inserted leads are duplicates. If leads
             are found to be duplicates,changes owner and removes them from Assignment Rules.
 Refactoring old class LeadConversionDuplicates
 Author - Richard Joseph
 Created Date- March 11th, 2014            
 User Story - B-266662 
*/

public class ErrorLogHandler {

public void ErrorLogHandler(){
    
    
}

public void createLog(String Source, String RecordId,String Type,String Message,String Severity){
    
    ErrorLogDetail__c ErrLogDetailObj = new ErrorLogDetail__c(Record_ID__c=RecordId,Error_Type__c=Type,Error_Source__c=Source,Error_Message__c=Message,Severity__c=Severity);

    insert  ErrLogDetailObj;
}

public void batchCreateLog(List<batchErrorLogWrapper> ErrorList){
    
    List<ErrorLogDetail__c> ErrLogDetailList = new List<ErrorLogDetail__c >();
    For(batchErrorLogWrapper ErrorRec:ErrorList)
    {
        ErrLogDetailList.add(new ErrorLogDetail__c(
        Record_ID__c=(string)ErrorRec.ErrorRecordId,
        Error_Type__c=ErrorRec.ErrorType,
        Error_Source__c=ErrorRec.ErrorSource,
        Error_Message__c=ErrorRec.ErrorMessage,        
        Apex_Job_Master__c = ErrorRec.ApexJobMasterId,
        Severity__c='Medium') );
        
        
    }
    If(ErrLogDetailList.size()>0)
    {
        Insert ErrLogDetailList;
    }
    
}

public void batchSendEmailException(List<batchErrorLogWrapper> ErrorList){
    
    List<ErrorLogDetail__c> ErrLogDetailList = new List<ErrorLogDetail__c >();
    string EmailBody =null ;
    EmailBody = 'Following exception(s) occured';
    string EmailSubject = 'Exception from Round Robin Job at ' + System.now();
    For(batchErrorLogWrapper ErrorRec:ErrorList)
    {
        ErrLogDetailList.add(new ErrorLogDetail__c(
        Record_ID__c=(string)ErrorRec.ErrorRecordId,
        Error_Type__c=ErrorRec.ErrorType,
        Error_Source__c=ErrorRec.ErrorSource,
        Error_Message__c=ErrorRec.ErrorMessage,
        Apex_Job_Master__c = ErrorRec.ApexJobMasterId ,
        Severity__c=ErrorRec.Severity) );
        
        if(ErrorRec.ErrorType =='Technical'){
        if (ErrorRec.ErrorRecordId  != null)
        EmailBody+= '\n Lead Id: ' + ErrorRec.ErrorRecordId +'- Exception: '+ErrorRec.ErrorMessage;
        else
        EmailBody+= '\n Exception: '+ErrorRec.ErrorMessage;
        }
    }
    If(ErrLogDetailList.size()>0)
    {
        Insert ErrLogDetailList;
    }
    this.SendExceptionEmail(EmailBody,EmailSubject);
    
}

public class batchErrorLogWrapper {
    
    String ErrorRecordId {get; set;}
    String ErrorSource {get; set;}
    String ErrorMessage {get; set;}
    String ErrorType {get; set;}
    String Severity {get; set;}
    public Id ApexJobMasterId {get; set;}
    public  batchErrorLogWrapper(String RecordId,String Source,string ErrorMessage){
        
        this.ErrorRecordId =RecordId;
        this.ErrorSource=Source;
        this.ErrorMessage=ErrorMessage;
        this.ErrorType = 'Technical';
        this.Severity = 'Critical';
    }
    
    public  batchErrorLogWrapper(String RecordId,String Source,string ErrorMessage,string ErrorType){
        
        this.ErrorRecordId =RecordId;
        this.ErrorSource=Source;
        this.ErrorMessage=ErrorMessage;
        this.ErrorType = ErrorType;
        this.Severity = 'Medium';
    }
    
    public  batchErrorLogWrapper(String RecordId,String Source,string ErrorMessage,string ErrorType,Id ApexJobMasterId ){
        
        this.ErrorRecordId =RecordId;
        this.ErrorSource=Source;
        this.ErrorMessage=ErrorMessage;
        this.ErrorType = ErrorType;
        this.Severity = 'Medium';
        If (ApexJobMasterId != null)
        this.ApexJobMasterId = ApexJobMasterId ;
    }
    public  batchErrorLogWrapper(String RecordId,String Source,string ErrorMessage,Id ApexJobMasterId ){
        
        this.ErrorRecordId =RecordId;
        this.ErrorSource=Source;
        this.ErrorMessage=ErrorMessage;
        this.ErrorType = 'Technical';
        this.Severity = 'Critical';
        If (ApexJobMasterId != null)
        this.ApexJobMasterId = ApexJobMasterId ;
    }
    
}

private void SendExceptionEmail(string EmailBody,string EmailSubject){
        
        
        
         Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        List<GroupMember> EmailGroup = new List<GroupMember> ([Select UserOrGroupId From GroupMember where Group.Name='Exception Email Group']);
        Set<Id> GroupMemerId = new Set<id>();
        String[] GroupMemerEmail = new String[]{};
        for (GroupMember GroupMemberRec :EmailGroup )
        {
        GroupMemerId.add(GroupMemberRec.UserOrGroupId ); 
        
        }
        
        If (GroupMemerId.size()>0)
        {
        System.debug('Richard Test' + GroupMemerId  );
        List<User> UserEmailList = New List<user> ([select id, name, email from user where IsActive = True and  ID in :GroupMemerId limit 99] );
        
        For (User UserRec:UserEmailList )
        {
            GroupMemerEmail.add(UserRec.Email);
        }
        
        }
        
        if (GroupMemerEmail.size() >0)
        {
        String[] toAddresses = GroupMemerEmail;
        mail.setToAddresses(toAddresses);
        mail.setSubject('Exception at ' + System.now());
        mail.setPlainTextBody(EmailBody);
        mail.setHtmlBody(EmailBody);        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
        
    }

}