/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class UpdateLeadDetails_Test {

    static testMethod void myUnitTest() {
        
        
        Lead l = new lead();
        l.Channel__c = 'Centralized Retail';
        l.Channel_Sources__c = 'Bank';
        l.Channel_Values__c = 'RB Portal';
        l.FirstName='test';
        l.LastName= 'Lead' ;
        l.Email='test@test.com';
        l.Borrowers_Current_Residence__c='Own';
        l.Company='NA';
        l.Property_State__c='CA';
        l.Loan_Type__c='Conventional';
        l.Occupancy_Code__c='Owner Occupied';
        l.Property_Type__c='SFR Detached';
        l.Value_of_Home__c=300000;
        l.loan_Purpose__c='Purchase';
        l.Requested_Loan_Amount__c=100000;
        l.Department__c ='South-Central';
        //l.ownerid = q.id;
        l.Is_assigned_already__c = false;
        l.Copy_Borrower_Current_Address__c = true;
        l.Co_Borrowers_First_Name__c ='test';
        l.Co_Borrowers_Last_Name__c = 'test';
        l.Co_Borrowers_Address_1__c = 'test';
        l.Borrowers_Address_1__c = 'nottest';
        l.Copy_Borrowers_Home_Phone__c = true;
        l.Co_Borrowers_Home_Phone__c = '(999) 999-9999';
        insert l;
        
        
        Lead l2 = new lead();
        l2.Channel__c = 'Centralized Retail';
        l2.Channel_Sources__c = 'Bank';
        l2.Channel_Values__c = 'RB Portal';
        l2.FirstName='test2';
        l2.LastName= 'Lead2' ;
        l2.Email='test@test2.com';
        l2.Borrowers_Current_Residence__c='Own';
        l2.Company='NA';
        l2.Property_State__c='CA';
        l2.Loan_Type__c='Conventional';
        l2.Occupancy_Code__c='Owner Occupied';
        l2.Property_Type__c='SFR Detached';
        l2.Value_of_Home__c=300000;
        l2.loan_Purpose__c='Purchase';
        l2.Requested_Loan_Amount__c=100000;
        l2.Department__c ='South-Central';
        //l.ownerid = q.id;
        l2.Is_assigned_already__c = false;
        l2.Copy_Borrower_Current_Address__c = true;
        l2.Co_Borrowers_First_Name__c ='test';
        l2.Co_Borrowers_Last_Name__c = 'test';
        l2.Co_Borrowers_Address_1__c = null;
        l2.Borrowers_Address_1__c = 'nottest';
        l2.Copy_Borrowers_Home_Phone__c = true;
        l2.Co_Borrowers_Home_Phone__c = null;
        l2.Co_Borrowers_Email__c = 'test@test.com';
        insert l2;
        
        List<lead> listLeads = [select id,Copy_Borrower_Current_Address__c,Co_Borrowers_Address_1__c,Copy_Borrowers_Home_Phone__c,Co_Borrowers_Home_Phone__c
        from lead where id =: l.id OR id =: l2.id];
        
        UpdateLeadDetails ULD = new UpdateLeadDetails();
        ULD.updateAddressAndPhone(listLeads);    
        
        
    }
}