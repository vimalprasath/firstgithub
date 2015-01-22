@istest
public class LeadConversionDuplicates_Test{

public static testmethod void test_LeadConversionDuplicates(){

        id i=[select Id from RecordType where Name Like: 'Prequal' and SobjectType = 'Lead' limit 1].Id;

        Lead TestLead = new Lead();    
        TestLead.channel__c = 'Centralized Retail';  
        TestLead.Channel_Sources__c = 'web';
        TestLead.Channel_Values__c = 'Google';
        TestLead.FirstName = 'ABCD';
        TestLead.LastName = 'ABCD';
        TestLead.Email = 'test@test.com';
       // TestLead.Co_Borrowers_First_Name__c = 'xyz';
       // TestLead.Co_Borrowers_Last_Name__c = 'xyz';
       // TestLead.Co_Borrowers_Email__c = 'xyz@xyz.com';
        TestLead.Applicant_Type__c = 'Individual';
        TestLead.Borrowers_Current_Residence__c = 'own';
        TestLead.Property_State__c = 'TX';
        TestLead.Loan_Type__c = 'HE';
        TestLead.Occupancy_Code__c = 'Owner Occupied';
        TestLead.Requested_Loan_Amount__c = 12345;
        TestLead.Loan_Purpose__c = 'Purchase';
        TestLead.Status = 'New - Not Opened';
        TestLead.Property_State__c = 'TX';   
        TestLead.Company = 'ABCD';
        TestLead.RecordTypeId = i;//[select Id from RecordType where Name Like: 'Prequal' and SobjectType = 'Lead' limit 1].Id;
        insert TestLead;
        
        Lead TestLead1 = new Lead();    
        TestLead1.channel__c = 'Centralized Retail';  
        TestLead1.Channel_Sources__c = 'web';
        TestLead1.Channel_Values__c = 'Google';
        TestLead1.FirstName = 'ABCD';
        TestLead1.LastName = 'ABCD';
        TestLead1.Email = 'test@test.com';
        TestLead1.Applicant_Type__c = 'Individual';
        TestLead1.Borrowers_Current_Residence__c = 'own';
        TestLead1.Property_State__c = 'TX';
        TestLead1.Loan_Type__c = 'HE';
        TestLead1.Occupancy_Code__c = 'Owner Occupied';
        TestLead1.Requested_Loan_Amount__c = 12345;
        TestLead1.Loan_Purpose__c = 'Purchase';
        TestLead1.Status = 'New - Not Opened';
        TestLead1.Property_State__c = 'TX';   
        TestLead1.Company = 'ABCD';
        TestLead1.RecordTypeId = i;//[select Id from RecordType where Name Like: 'Prequal' and SobjectType = 'Lead' limit 1].Id;
        insert TestLead1;
        
        
        Lead TestLead2 = new Lead();    
        TestLead2.channel__c = 'Centralized Retail';  
        TestLead2.Channel_Sources__c = 'web';
        TestLead2.Channel_Values__c = 'Google';
        TestLead2.FirstName = 'ABCD';
        TestLead2.LastName = 'ABCD';
        TestLead2.Email = 'test@test.com';
        TestLead2.Co_Borrowers_First_Name__c = 'xyz';
        TestLead2.Co_Borrowers_Last_Name__c = 'xyz';
        TestLead2.Co_Borrowers_Email__c = 'xyz@xyz.com';
        TestLead2.Applicant_Type__c = 'Individual';
        TestLead2.Borrowers_Current_Residence__c = 'own';
        TestLead2.Property_State__c = 'TX';
        TestLead2.Loan_Type__c = 'HE';
        TestLead2.Occupancy_Code__c = 'Owner Occupied';
        TestLead2.Requested_Loan_Amount__c = 12345;
        TestLead2.Loan_Purpose__c = 'Purchase';
        TestLead2.Status = 'New - Not Opened';
        TestLead2.Property_State__c = 'TX';   
        TestLead2.Company = 'ABCD';
        TestLead2.RecordTypeId = i;//[select Id from RecordType where Name Like: 'Prequal' and SobjectType = 'Lead' limit 1].Id;
        insert TestLead2;
        
        
        Lead TestLead3 = new Lead();    
        TestLead3.channel__c = 'Centralized Retail';  
        TestLead3.Channel_Sources__c = 'web';
        TestLead3.Channel_Values__c = 'Google';
        TestLead3.FirstName = 'ABCDABCD';
        TestLead3.LastName = 'ABCDABCD';
        TestLead3.Email = 'test@test.com';
        TestLead3.Co_Borrowers_First_Name__c = 'xyz';
        TestLead3.Co_Borrowers_Last_Name__c = 'xyz';
        TestLead3.Co_Borrowers_Email__c = 'xyz@xyz.com';
        TestLead3.Applicant_Type__c = 'Individual';
        TestLead3.Borrowers_Current_Residence__c = 'own';
        TestLead3.Property_State__c = 'TX';
        TestLead3.Loan_Type__c = 'HE';
        TestLead3.Occupancy_Code__c = 'Owner Occupied';
        TestLead3.Requested_Loan_Amount__c = 12345;
        TestLead3.Loan_Purpose__c = 'Purchase';
        TestLead3.Status = 'New - Not Opened';
        TestLead3.Property_State__c = 'TX';   
        TestLead3.Company = 'ABCD';
        TestLead3.RecordTypeId = i;//[select Id from RecordType where Name Like: 'Prequal' and SobjectType = 'Lead' limit 1].Id;
        insert TestLead3;
        /*
        Lead TestLead4 = new Lead();    
        TestLead4.channel__c = 'Centralized Retail';  
        TestLead4.Channel_Sources__c = 'web';
        TestLead4.Channel_Values__c = 'Google';
        TestLead4.FirstName = 'ABCDABCD';
        TestLead4.LastName = 'ABCDABCD';
        TestLead4.Email = 'test@test.com';
        TestLead4.Co_Borrowers_First_Name__c = 'xyz';
        TestLead4.Co_Borrowers_Last_Name__c = 'xyz';
        TestLead4.Co_Borrowers_Email__c = 'xyz@xyz.com';
        TestLead4.Applicant_Type__c = 'Individual';
        TestLead4.Borrowers_Current_Residence__c = 'own';
        TestLead4.Property_State__c = 'TX';
        TestLead4.Loan_Type__c = 'HE';
        TestLead4.Occupancy_Code__c = 'Owner Occupied';
        TestLead4.Requested_Loan_Amount__c = 12345;
        TestLead4.Loan_Purpose__c = 'Purchase';
        TestLead4.Status = 'New - Not Opened';
        TestLead4.Property_State__c = 'TX';   
        TestLead4.Company = 'ABCD';
        TestLead4.RecordTypeId = i;//[select Id from RecordType where Name Like: 'Prequal' and SobjectType = 'Lead' limit 1].Id;
        insert TestLead4;
        */
}
}