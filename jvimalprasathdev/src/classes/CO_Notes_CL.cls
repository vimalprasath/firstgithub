/**
* @Created By : Leena (Wipro),   @Created Date : 10 Aug 2012
* @Last Modified By : Leena (Wipro),  @Modified Date : 11 Sep 2012
* @description : This class is used to create a new note
*                 
**/
public class CO_Notes_CL{
    public Notes__c note{set; get;}
    public id LeadId{get; set;}
    
    public CO_Notes_CL(ApexPages.StandardSetController controller){
        LeadId= system.currentPageReference().getParameters().get('id');
        note= new Notes__c();
        note.Lead__c = Leadid;
    }
    //Method to save the new Note record
    public PageReference SaveNote(){
        try{
            if(Note.Comments_List__c!=null){
            insert note;
             PageReference pr = new PageReference('/' + LeadId);  
             pr.setRedirect(true);  
             return pr;
             }
             else{
                  ApexPages.addMessage(new ApexPages.message(ApexPages.severity.FATAL,'Enter Notes Type')); 
                  return null;
             }
         }
         catch(Exception e){}
         return null;
    }
     //Method to return to lead page
    public PageReference Cancel(){
        return (new pageReference('/' +LeadId));
    }
}