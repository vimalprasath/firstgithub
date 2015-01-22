@isTest
private class TestClass_LeadCallCapture {

    static testMethod void leadCallCaptureTest() {
        Test.startTest();
        try{
             
            PageReference pageRef = Page.LeadCallCapture;  

             Test.setCurrentPage(pageRef);  
        
            LeadCallCapture lCallCapture = new LeadCallCapture();
            lCallCapture.getredirectPage();
            Lead L = new lead();
            L.status = 'Active';
            L.Channel__c = 'Centralized Retail';
            L.Channel_Sources__c = 'Bank';
            L.Applicant_Type__c = 'Individual';
            L.Channel_Values__c = 'RB Portal';
            L.Internal_Referral__c = 'N/A';
            L.Borrowers_Current_Residence__c =  'Own';
            L.Company = 'None';
            L.FirstName = 'John';
            L.LastName = 'Doe';
            L.Borrowers_Home_Phone__c = '(111) 222-3333';
            L.Property_State__c = 'TX';
            L.Notes_Type__c = 'Called Home, Left Message – No Contact';
            L.Loan_Purpose__c = 'Purchase';
            
            insert L;
            try{
                    Map<String, Object> mapLead = new Map<String, Object>();
                    mapLead.put(L.Id,L);
                    System.debug('Insert***************>>>'+L);
                    lCallCapture.Entry = new Flow.Interview.Call_Capture_Lead_Lookup(mapLead);
                    //System.debug('entry***************>>>'+Entry.varLeadId);
            }catch(Exception e){ System.debug('Error***************>>>'+e);}
        
            lCallCapture.getredirectPage();
         }catch(exception e) {}
         Test.stopTest();
    }
}