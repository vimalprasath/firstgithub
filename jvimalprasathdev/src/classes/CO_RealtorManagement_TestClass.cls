@isTest
Public Class CO_RealtorManagement_TestClass{
    Static testmethod void RealtorContactTRG_testmethod(){
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
        insert new_ld; 
        
        Contact con = new Contact();
        con.LastName='Kumar';
        con.Email='Ak@yahoo.com';
        con.contact_type__c='Realtor';
        con.mailingpostalcode='33333';
        
        insert con; 
        
        List<Contact_Management__c> listcon = new List<Contact_Management__c>();
        Contact_Management__c conm= new Contact_Management__c(Contact__c=con.id,Lead__c=new_ld.id);
        listcon.add(conm);
        insert listcon;
        
        Contact con1 = new Contact(id=con.id);
        con1.contact_type__c='Realtor';
        con1.mailingpostalcode='33333';
        update con1;
        
        Contact con2 = new Contact();
        con2.LastName='Sas';
        con2.contact_type__c='RB';
        con2.mailingpostalcode='33333';
        insert con2;
        
        List<Contact_Management__c> listcon1 = new List<Contact_Management__c>();
        Contact_Management__c conm1= new Contact_Management__c(Contact__c=con2.id,Lead__c=new_ld.id);
        listcon1.add(conm1);
        insert listcon1;
        
        Realtor_contacts__c rc= new Realtor_contacts__c();
        rc.name='Lee';
        rc.mailing_zip_postal_code__c='44444';
        rc.contact__c=con2.id;
        insert rc;
        
        Contact con3 = new Contact(id=con2.id);
        con3.email='lee@lee.com';
        con3.contact_type__c='Realtor';
        update con3;
        
        Contact con4 = new Contact(id=con2.id);
        con4.Contact_type__c='New';
        update con4;    
        
       /* lead l1 = [select id from lead limit 1];
        id leadid = l1.id;
        Contact_Management__c test;
       // test.contact__c=con3.id;
        test.lead__c=leadid;
        insert test;*/
        
                  
    }
    Static testmethod void RealtorContactMgmt_testmethod(){
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
        insert new_ld;
        
        Realtor_contacts__c rc= new Realtor_contacts__c();
        rc.name='Lee';
        rc.mailing_zip_postal_code__c='44444';
        insert rc;
        
        List<Realtor_Contact_Management__c> listcon = new List<Realtor_Contact_Management__c>();
        Realtor_Contact_Management__c conm= new Realtor_Contact_Management__c(Realtor_Contact__c=rc.id,Lead__c=new_ld.id);
        listcon.add(conm);
        insert listcon;
        
        system.currentPageReference().getParameters().put('id',new_ld.id);
        ApexPages.StandardSetController sc = new ApexPages.standardSetController(listcon);
        CO_RealtorManagement_CL cntrl= new CO_RealtorManagement_CL(sc);
        cntrl.SaveRelMgt();
        cntrl.Cancel();
        cntrl.RelMgt.Realtor_Contact__c=rc.id;
        cntrl.SaveRelMgt();
        cntrl.RelMgt.Realtor_Contact__c=new_ld.id;
        cntrl.SaveRelMgt();
        
        delete listcon;
    }
    Static testmethod void RealtorContactSearch_testmethod(){
        Realtor_contacts__c rc= new Realtor_contacts__c();
        rc.name='Lee';
        rc.mailing_zip_postal_code__c='44444';
        insert rc;
        
        CO_SearchRealtorContacts_CL SRC= new CO_SearchRealtorContacts_CL();
        src.zipcode='44444';
        src.findRealtorCons();
        src.getVFContacts();
        src.zipcode='44443';
        src.findRealtorCons();
    }
}