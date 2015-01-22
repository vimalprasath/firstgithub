@isTest
Public Class CO_ContactManagement_TestClass{
    Static testmethod void ContactManagement_testmethod(){
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
        new_ld.PostalCode = '55555';
       
        insert new_ld; 
        
        Contact con = new Contact();
        con.LastName='Kumar';
        con.Email='Ak@yahoo.com';
        con.Contact_Type__c= 'Realtor';
        con.MailingPostalCode = '33333';
        insert con; 
        
        List<Contact_Management__c> listcon = new List<Contact_Management__c>();
        Contact_Management__c conm= new Contact_Management__c(Contact__c=con.id,Lead__c=new_ld.id);
        listcon.add(conm);
        insert listcon;
        
        system.currentPageReference().getParameters().put('id',new_ld.id);
        ApexPages.StandardSetController sc = new ApexPages.standardSetController(listcon);
        CO_ContactManagement_CL cntrl= new CO_ContactManagement_CL(sc);
        cntrl.SaveConMgt();
        cntrl.Cancel();
        cntrl.ConMgt.Contact__c=con.id;
        cntrl.SaveConMgt();
        cntrl.ConMgt.Contact__c=new_ld.id;
        cntrl.SaveConMgt();
        
    }
}