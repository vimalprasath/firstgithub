/*
Name: CO_ContactManagement_CL
Author: Leena N
Description: This Class is used to create a new Contact(Contact Management) to Lead
Last modified by: Leena N
*/
public class CO_ContactManagement_CL{
    public Contact_Management__c ConMgt{set; get;}
    public id LeadId{get; set;}
    
    public CO_ContactManagement_CL(ApexPages.StandardSetController controller){
        LeadId= system.currentPageReference().getParameters().get('id');        
        ConMgt= new Contact_Management__c();
        ConMgt.Lead__c = Leadid;
    }
    //Method to save the new Contact management record
    public PageReference SaveConMgt(){
        try{
        if(ConMgt.Contact__c!=null){
            insert ConMgt;
         PageReference pr = new PageReference('/' + LeadId);  
         pr.setRedirect(true);  
         return pr;
         }
         else{
              ApexPages.addMessage(new ApexPages.message(ApexPages.severity.FATAL,'Enter Contact')); 
              return null;
         }
         }
         catch(Exception e){
         }
         return null;
    }
    //Method to return to lead page
    public PageReference Cancel(){
        return (new pageReference('/' +LeadId));
    }
}