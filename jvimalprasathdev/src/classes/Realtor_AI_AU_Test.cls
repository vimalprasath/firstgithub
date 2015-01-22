@isTest(seeAllData = true)
Public Class Realtor_AI_AU_Test{
    Static testmethod void Realtor_AI_AU_Testmethod(){
        Realtor_contacts__c rc1= new Realtor_contacts__c();
        rc1.name='Lee';
        rc1.mailing_zip_postal_code__c='44444';
        rc1.Total_no_of_Leads__c = 0;
        rc1.No_of_Leads__c = null;
        rc1.Realtor_Id__c = null;
        insert rc1;
        
        Realtor_contacts__c rc= new Realtor_contacts__c();
        rc.name='Lee';
        rc.mailing_zip_postal_code__c='44444';
        rc.Total_no_of_Leads__c = 0;
        rc.No_of_Leads__c = null;
        rc.Realtor_Id__c = [select id from Realtor_contacts__c where name like '%Lee%' limit 1].id;
        rc.Phone__c = '1111111111';
        rc.Email__c = 'test@test.com';
        rc.Home_Phone__c = '2222222222';
        rc.Mobile_Phone__c = '3333333333';
        insert rc;
       
        Realtor_contacts__c rc2 =  [select id,Realtor_Id__c from Realtor_contacts__c where name like '%Lee%'limit 1];
        rc2.Realtor_Id__c = null;
        update rc2;
                       
        delete rc1;
        
        CO_SearchRealtorContacts_CL SRC= new CO_SearchRealtorContacts_CL();
        src.zipcode='44444';
        src.findRealtorCons();
        src.getVFContacts();
        src.zipcode='44443';
        src.findRealtorCons();
    }
  
}