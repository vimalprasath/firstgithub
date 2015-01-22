public with sharing class LeadCallCapture{      
public Flow.Interview.Call_Capture_Lead_Lookup Entry{get;set;}
/*public LeadCallCapture(ApexPages.StandardController controller) 
{
    
}*/
public PageReference getredirectPage(){
       string LeadID ;
       PageReference send = null;
       if(Entry != null){
          LeadID = Entry.varLeadId;
         }
       if((LeadID != null) && (LeadID!='')){      
          send = new PageReference('/' + LeadID);
       }else{
          send = new PageReference('/home/home.jsp');
       }
  
       send.setRedirect(true);
       return send;
   }
 }