@isTest
Public Class CO_DisplayLeadRate_TestClass{
    Static testmethod void DisplayRate_testmethod(){    
        CO_DisplayLeadRate_CL ratewatch= new CO_DisplayLeadRate_CL();
        ratewatch.findLead();
        Lead new_ld = new Lead();
        new_ld.Status='Active';
        new_ld.firstname='AK';
        new_ld.Lastname='Rathore';
        new_ld.Applicant_Type__c='Married Couple';
        new_ld.Channel__c='Home Equity';
        new_ld.Channel_Sources__c='Third Parties';
        new_ld.Channel_Values__c='Realtors';
        new_ld.Borrowers_Country__c='Hong Kong';
        new_ld.Borrowers_City__c='Netherlands';
        new_ld.Borrowers_Address_1__c='A-12 Lonley Road';
        new_ld.Time_Zone__c='CST';
        new_ld.Borrowers_Current_Residence__c='Own';
        new_ld.Company='XXXXXX';
        new_ld.Loan_Approved__c=True;
        new_ld.Borrowers_Zip_Postal_Code__c='32418';
        new_ld.Borrowers_Home_Phone__c='(033) 246-3970';
        new_ld.Occupancy_Code__c='Second Home';
        new_ld.Notes__c='Tomorrow is Saturday ok?';
        new_ld.Property_State__c='CA';
        new_ld.Email='akq@gmail.com';
        new_ld.Phone='(033) 246-3970';
        new_ld.Borrowers_Apt__c='Testa';
        new_ld.Rate_Loan_type__c = 'Conforming';
        new_ld.Loan_Term__c = '30';
        new_ld.Current_Rate__c =2;
        insert new_ld; 
        
        CO_DisplayLeadRate_CL ratewatch1= new CO_DisplayLeadRate_CL();
        ratewatch1.currentrate3=1;
        ratewatch1.findLead();
    }
}