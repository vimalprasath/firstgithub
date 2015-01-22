/**
 Description: Test Class for LeadDuplicateProcessing.
 Author - Richard Joseph
 Created Date- March, 2014            

 */
 @istest(seeAllData = true)
private class TestClass_LeadDuplicateProcessing {

    static testMethod void LeadDuplicateProcessingTest() {
    
    List<Lead> TestInsertLeadList = new List<lead>();
           
           
        Lead TestLead = new Lead();    
        TestLead.channel__c = 'Centralized Retail';  
        TestLead.Channel_Sources__c = 'web';
        TestLead.Channel_Values__c = 'Google';
        TestLead.FirstName = 'First';
        TestLead.LastName = 'Last Test';
        TestLead.Email = 'TestEmail@Email.com';
       // TestLead.Co_Borrowers_First_Name__c = 'xyz';
       // TestLead.Co_Borrowers_Last_Name__c = 'xyz';
       // TestLead.Co_Borrowers_Email__c = 'xyz@xyz.com';
        TestLead.Applicant_Type__c = 'Individual';
        TestLead.Borrowers_Current_Residence__c = 'own';
        TestLead.Property_State__c = 'TX';
        TestLead.Loan_Type__c = 'HE';
        TestLead.Occupancy_Code__c = 'Owner Occupied';
        TestLead.Requested_Loan_Amount__c = 80000;
        TestLead.Loan_Purpose__c = 'Purchase';
        TestLead.Status = 'New - Not Opened';
        TestLead.Property_State__c = 'TX';   
        TestLead.Company = 'ABC Corp';
       
        TestInsertLeadList.add( TestLead);       
        TestInsertLeadList.add( TestLead.clone());  
        TestInsertLeadList.add( TestLead.clone());
        
        Lead CoBorrowerTestLead=TestLead.clone();
        CoBorrowerTestLead.Co_Borrowers_First_Name__c = 'CO First';
       CoBorrowerTestLead.Co_Borrowers_Last_Name__c = 'Co Last';
       CoBorrowerTestLead.Co_Borrowers_Email__c = 'First.last@CO.com';
       
       Lead BorrowerTestLead=CoBorrowerTestLead.clone();
       BorrowerTestLead.FirstName = 'BR First';
        BorrowerTestLead.LastName = ' BR Last Test';
        BorrowerTestLead.Email = 'First.last@BR.com';
        
        Lead FreshTestlead =TestLead.clone();
        FreshTestlead.FirstName = 'FR First';
        FreshTestlead.LastName = ' FR Last Test';
        FreshTestlead.Email = 'First.last@FR.com';
        TestInsertLeadList.add( FreshTestlead);  
        
        
        Test.startTest();
        
        Insert TestInsertLeadList;
        
        TestInsertLeadList.Clear();
        
        
        insert CoBorrowerTestLead;
        insert BorrowerTestLead;
        insert FreshTestlead.clone();
        /*TestInsertLeadList.add( CoBorrowerTestLead);
        TestInsertLeadList.add( BorrowerTestLead);
        TestInsertLeadList.add( FreshTestlead.clone());
        
        Insert TestInsertLeadList;*/
        
        Test.StopTest();
        

    }
}