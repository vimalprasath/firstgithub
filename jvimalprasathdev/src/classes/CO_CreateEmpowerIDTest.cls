@isTest
public class CO_CreateEmpowerIDTest{

testMethod static void testCO_CreateEmpowerID(){


User lookupRMUser = [select Id from User where id = :userinfo.getUserId()limit 1];
Lead L = new lead();
L.status = 'Active';
L.Channel__c = 'Centralized Retail';
L.Channel_Sources__c = 'Bank';
L.Applicant_Type__c = 'Individual';
L.Channel_Values__c = 'RB Portal';
L.Internal_Referral__c = 'MC Referral';
L.Borrowers_Current_Residence__c =  'Own';
L.Company = 'None';
L.FirstName = 'John';
L.LastName = 'Doe';
L.Borrowers_Home_Phone__c = '(111) 222-3333';
L.Internal_Referral_Name__c = lookupRMUser.id;
L.Property_State__c = 'TX';
L.Notes_Type__c = 'Called Home, Left Message – No Contact';
L.Loan_Purpose__c = 'Purchase';

insert L;

String Dnumber = CO_CreateEmpowerID.show(L.id);

Lead L1 = new lead();
L1.status = 'Active';
L1.Channel__c = 'Centralized Retail';
L1.Channel_Sources__c = 'Bank';
L1.Applicant_Type__c = 'Individual';
L1.Channel_Values__c = 'RB Portal';
L1.Internal_Referral__c = 'MC Referral';
L1.Borrowers_Current_Residence__c =  'Own';
L1.Company = 'None';
L1.FirstName = 'John';
L1.LastName = 'Doe';
L1.Borrowers_Home_Phone__c = '(111) 222-3333';
L1.Internal_Referral_Name__c = lookupRMUser.id;
L1.Property_State__c = 'TX';
L1.Notes_Type__c = 'Called Home, Left Message – No Contact';

insert L1;

String D1number = CO_CreateEmpowerID.show(L1.id);
                        }
}