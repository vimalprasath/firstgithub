@isTest
public class Notes_Test{
Static Testmethod Void test_Notes()
 { 
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
    new_ld.Notes__c='Tesdsd';
    new_ld.Notes_Type__c='Tesdsd';
    insert new_ld;
   
   Lead l= new Lead(id=new_ld.id);
    l.notes__c='sfdgwty';
    l.Notes_Type__c='Tesdsdgdfh';
    update l;
   
   
    Lead new_ld1 = new Lead();
    new_ld1.Status='New';
    new_ld1.Applicant_Type__c='individual';
    new_ld1.Channel__c='Home Equity';
    new_ld1.Channel_Sources__c='Bank';
    new_ld1.Channel_Values__c='NCFR';
    new_ld1.FirstName='ROSY';
    new_ld1.LastName='DANIAL';
    new_ld1.Borrowers_Country__c='Hong Kong';
    new_ld1.Borrowers_City__c='Netherlands';
    new_ld1.Borrowers_Address_1__c='A-12 Lonley Road';
    new_ld1.Time_Zone__c='EST';
    new_ld1.Borrowers_Current_Residence__c='Own';
    new_ld1.Company='XXXX';
    new_ld1.Loan_Approved__c=True;
    new_ld1.Borrowers_Zip_Postal_Code__c='32412';
    new_ld1.Borrowers_Home_Phone__c='(033) 246-3970';
    new_ld1.Occupancy_Code__c='Second Home';
    new_ld1.Notes__c='Tomorrow is Saturday';
    new_ld1.Property_State__c='CA';
    new_ld1.Email='ak@gmail.com';
    new_ld1.Phone='(033) 246-3970';
    new_ld1.Borrowers_Apt__c='Test';
    new_ld1.Notes__c='Tesdsda';
    new_ld1.Notes_Type__c='Tesdsda';
    insert new_ld1;
     
     list<lead> l1=new list<lead>();
     l1.add(new_ld1);
     list<lead> l2=new list<lead>();
     l2.add(new_ld);
    
    Lead ld = new Lead();
    ld=[Select id from lead where Lastname='Rathore'or LastName='DANIAL' limit 1];
    ld.notes__c='ppp';
    ld.notes_type__c='ooo';
    update ld;
     
     Notes a= new Notes();
     a.createNotes(l1,l2);
    
    Notes__c note1 = new Notes__c();
    note1.Lead__c=ld.Id;
    note1.Comments__c='This is a dummy comment';
    insert note1;
    
    Notes__c note2 = new Notes__c();
    note2.Lead__c=ld.Id;
    note2.Comments__c='This is a dummy comment';
    note2.Comments_List__c='dummy note type';
    insert note2;
    
    
    
 }
}