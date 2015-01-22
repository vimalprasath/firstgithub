Global class WebSerLeadStatus{
    public class applicationException extends Exception {}
    Webservice Static Boolean updatelead(UpdateLoanStatus vloanLead) {
        
        try{
            Lead TmpLead;
            if(vloanLead.EmpowerID != null){
                TmpLead = [select status,Empower_Lead_ID__c,Salesforce_Lead_Number__c from Lead where Empower_Lead_ID__c =: vloanLead.EmpowerID];
            }
            if(TmpLead != null){
                TmpLead.status = vloanLead.LeadStatus;
                update TmpLead;
                return true;
            }
            else
            {
               throw new applicationException('Invalid Empower ID');
             //  return false;
              
            }   
        }catch(Exception e){
                 return false;
        }
    }


    Global class UpdateLoanStatus{
         webservice String EmpowerID;
         webservice string LeadStatus;
     }

}