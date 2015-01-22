/**
 Description: Test Class for BatchClass_HistoricLeadConversionFix.
 Author - Richard Joseph
 Created Date- March, 2014            

 */
 @istest(seeAllData = true)
private class TestClass_BatchHistoricLeadFix {

    static testMethod void BatchHistoricLeadFixTest() {
    
    List<Lead> TestInsertLeadList = new List<lead>();
           
           
        Lead TestLead = new Lead();    
        TestLead.channel__c = 'Centralized Retail';  
        TestLead.Channel_Sources__c = 'web';
        TestLead.Channel_Values__c = 'Google';
        TestLead.FirstName = 'First';
        TestLead.LastName = 'Last Test';
        TestLead.Email = 'TestEmail@Email.com';
        TestLead.Co_Borrowers_First_Name__c = 'xyz';
        TestLead.Co_Borrowers_Last_Name__c = 'xyz';
        TestLead.Co_Borrowers_Email__c = 'xyz@xyz.com';
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
        
        Lead TestLead2 = TestLead.clone(); 
        TestLead2.FirstName= 'First1';
        TestInsertLeadList.add( TestLead2); 
        
      
        
        
        Test.startTest();
        
        Insert TestInsertLeadList;
        
        TestInsertLeadList.Clear();
        
        Recordtype LeadRecordType = [select id from recordtype where name = 'ToBeConverted'  and SobjectType = 'Lead'  limit 1]; 
        TestLead.RecordTypeId= LeadRecordType.id;
        TestInsertLeadList.add( TestLead); 
        TestLead2.RecordTypeId= LeadRecordType.id;
        TestInsertLeadList.add( TestLead2); 
        
        
        
        
      BatchClass_HistoricLeadConversionFix HLFObj  = new BatchClass_HistoricLeadConversionFix ();
      HLFObj.QueryStr = 'Select Id From lead Where Owner.IsActive = true  '+' AND ID = \'' +TestLead.Id +'\'';
		Database.executeBatch(HLFObj);
        
        Test.StopTest();
        

    }
}