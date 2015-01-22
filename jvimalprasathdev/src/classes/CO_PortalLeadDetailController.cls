public with sharing class CO_PortalLeadDetailController{

     Public Customer_Portal_Lead__c CPLead2 {set;get;}
     Id CpLeadid;
     Public Boolean displayPopUp {get;set;} 
     Public Boolean showsubmitbtn{get;set;} 
     public CO_PortalLeadDetailController(ApexPages.StandardController controller){
        CPLead2 = new Customer_Portal_Lead__c(); 
        CPLeadid = ApexPages.currentPage().getParameters().get('id');   
        if(CPLeadid!=null)
            CPLead2 = [Select Comments__c,Create_Lead__c from Customer_Portal_Lead__c where id=:CPLEadid];        
     
     system.debug('++++++CPLead2.Create_Lead__c++++'+CPLead2.Create_Lead__c);
     }
     
     public void SaveNote(){
         if(CPLead2!=null)
             update CPLead2 ; 
     }
     
     Public void ClosePopUp(){
         displayPopUp = false;    
     }
     Public pagereference CreateLead(){ 
         
         if(CPLead2.Create_Lead__c != true){
             displayPopUp = true;
             CPLead2.Create_Lead__c = true;
             Update CPLead2; 
             }               
     pagereference pageref = new pagereference('/apex/CO_RBPipeline_VF');
            // pageref.setredirect(true);
             return pageref;

     }
     public void showsubmit() {
     if (CPLead2.Create_Lead__c == false) {
     showsubmitbtn = true;
     }
     }
     public pagereference backbutton () {
     pagereference pageref = new pagereference('/apex/CO_RBPipeline_VF');
     return pageref;
     }
}