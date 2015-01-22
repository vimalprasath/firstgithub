public with sharing class CO_RealtorManagement_CL{
    public Realtor_Contact_Management__c RelMgt{set; get;}
    public id LeadId{get; set;}
    
    public CO_RealtorManagement_CL(ApexPages.StandardSetController controller){
        LeadId= system.currentPageReference().getParameters().get('id');        
        RelMgt= new Realtor_Contact_Management__c();
        RelMgt.Lead__c = Leadid;
    }
    public PageReference SaveRelMgt(){
        try{
        if(RelMgt.Realtor_Contact__c!=null){
            insert RelMgt;
         PageReference pr = new PageReference('/' + LeadId);  
         pr.setRedirect(true);  
         return pr;
         }
         else{
              ApexPages.addMessage(new ApexPages.message(ApexPages.severity.FATAL,'Enter Realtor')); 
              return null;
         }
         }
         catch(Exception e){
         }
         return null;
    }
    public PageReference Cancel(){
        return (new pageReference('/' +LeadId));
    }
}