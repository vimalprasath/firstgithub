@isTest(SeeAllData=true)

public class TestTriggerUpdateAddressAndPhoneNumber {
/*

 static testMethod void insertTestLeads() {
 
 // INSERTING A NEW RECORD.
    Lead l=new Lead();
    l.Status='New';
    l.Language__c='English';
    l.Applicant_Type__c = 'Individual';
    l.FirstName = 'TestTrigger';
    l.LastName = 'Yarlagadda';
    l.Time_Zone__c = 'EST';
    l.Borrowers_Current_Residence__c = 'Own';
    l.Company = 'N/A';
    l.Occupancy_Code__c = 'Owner Occupied';
    l.Notes__c = 'Test Notes';
    l.Borrowers_Home_Phone__c = '(504) 213-5698';
    l.BorrowersHouse__c = '8274';
    l.Borrowers_Apt__c = '17-12-45';
    l.Borrowers_Address_1__c = '7933';
    l.Borrowers_Address_2__c = 'Preston Road';
    l.Borrowers_Zip_Postal_Code__c = '75024';
    l.Borrowers_City__c = 'Plano';
    l.Borrowers_State__c = 'TX';
    l.Property_State__c = 'te';  // added by wipro technologies - Yunus H
    l.Borrowers_County__c = 'Collin';
    l.Borrowers_Country__c = 'USA';
    l.Copy_Borrowers_Home_Phone__c = true;
    l.Copy_Borrower_Current_Address__c = true;
     test.starttest();
        insert l;
   test.stoptest();   
   
   //Checking if Borrower and Co- borrowers address is same    
    Lead testLead = [select id,Borrowers_Home_Phone__c,BorrowersHouse__c,Borrowers_Apt__c,Borrowers_Address_1__c,Borrowers_Address_2__c,
                     Borrowers_Zip_Postal_Code__c,Borrowers_City__c,Borrowers_State__c,Borrowers_County__c,Borrowers_Country__c,
                     Co_Borrowers_Home_Phone__c,Co_Borrowers_House__c,Co_Borrowers_Apt__c,Co_Borrowers_Address_1__c,Co_Borrowers_Address_2__c,
                     Co_Borrowers_Zip_Postal_Code__c,Co_Borrowers_City__c,Co_Borrowers_State__c,Co_Borrowers_County__c,Co_Borrowers_Country__c
                     from Lead where FirstName = 'TestTrigger'and LastName = 'Yarlagadda' ];
    
    System.assertEquals(testLead.Borrowers_Home_Phone__c, testLead.Co_Borrowers_Home_Phone__c);
    System.assertEquals(testLead.BorrowersHouse__c, testLead.Co_Borrowers_House__c);
    System.assertEquals(testLead.Borrowers_Apt__c, testLead.Co_Borrowers_Apt__c);
    System.assertEquals(testLead.Borrowers_Address_1__c, testLead.Co_Borrowers_Address_1__c);
    System.assertEquals(testLead.Borrowers_Address_2__c, testLead.Co_Borrowers_Address_2__c);
    System.assertEquals(testLead.Borrowers_Zip_Postal_Code__c, testLead.Co_Borrowers_Zip_Postal_Code__c);
    System.assertEquals(testLead.Borrowers_City__c, testLead.Co_Borrowers_City__c);
    System.assertEquals(testLead.Borrowers_State__c, testLead.Co_Borrowers_State__c);
    System.assertEquals(testLead.Borrowers_County__c, testLead.Co_Borrowers_County__c);
    System.assertEquals(testLead.Borrowers_Country__c, testLead.Co_Borrowers_Country__c);
    
     //Checking the conditions in trigger loops
    Lead testLead3= [select Co_Borrowers_Home_Phone__c,Co_Borrowers_House__c, Co_Borrowers_Apt__c,Co_Borrowers_Address_1__c ,
                     Co_Borrowers_Address_2__c,Co_Borrowers_Zip_Postal_Code__c,Co_Borrowers_City__c,Co_Borrowers_State__c,
                     Co_Borrowers_County__c,Co_Borrowers_Country__c  from Lead where FirstName = 'TestTrigger'and LastName = 'Yarlagadda'];
    
    testLead3.Co_Borrowers_Home_Phone__c = null;
    testLead3.Co_Borrowers_House__c = null;
    testLead3.Co_Borrowers_Apt__c = null;
    testLead3.Co_Borrowers_Address_1__c = null;
    testLead3.Co_Borrowers_Address_2__c = null;
    testLead3.Co_Borrowers_Zip_Postal_Code__c =null;
    testLead3.Co_Borrowers_City__c = null;
    testLead3.Co_Borrowers_State__c = null;
    testLead3.Co_Borrowers_County__c = null;
    testLead3.Co_Borrowers_Country__c = null;    
    
    update testLead3;
    
     Lead testLead4 = [select Copy_Borrowers_Home_Phone__c,Copy_Borrower_Current_Address__c
                      from Lead where FirstName = 'TestTrigger'and LastName = 'Yarlagadda'];
                      
    System.assertEquals(testLead4.Copy_Borrowers_Home_Phone__c, False);
    System.assertEquals(testLead4.Copy_Borrower_Current_Address__c, False);            
    
     //Checking the conditions in trigger loops
     Lead testLead5= [select Co_Borrowers_Home_Phone__c,Co_Borrowers_House__c, Co_Borrowers_Apt__c,Co_Borrowers_Address_1__c ,
                     Co_Borrowers_Address_2__c,Co_Borrowers_Zip_Postal_Code__c,Co_Borrowers_City__c,Co_Borrowers_State__c,
                     Co_Borrowers_County__c,Co_Borrowers_Country__c  from Lead where FirstName = 'TestTrigger'and LastName = 'Yarlagadda'];
    
    testLead5.Co_Borrowers_Home_Phone__c ='(504) 213-5698';
    testLead5.Co_Borrowers_House__c = '8274';
    testLead5.Co_Borrowers_Apt__c = '17-12-45';
    testLead5.Co_Borrowers_Address_1__c = '7933';
    testLead5.Co_Borrowers_Address_2__c = 'Preston Road';
    testLead5.Co_Borrowers_Zip_Postal_Code__c = '75024';
    testLead5.Co_Borrowers_City__c = 'Plano';
    testLead5.Co_Borrowers_State__c = 'TX';
    testLead5.Co_Borrowers_County__c = 'Collin';
    testLead5.Co_Borrowers_Country__c = 'USA';    
    
    update testLead5;         
    
     Lead testLead6 = [select Copy_Borrowers_Home_Phone__c,Copy_Borrower_Current_Address__c
                      from Lead where FirstName = 'TestTrigger'and LastName = 'Yarlagadda'];
                      
    System.assertEquals(testLead6.Copy_Borrowers_Home_Phone__c, False);
    System.assertEquals(testLead6.Copy_Borrower_Current_Address__c, False);         
    
    Lead testLead1= [select Co_Borrowers_Home_Phone__c,Co_Borrowers_House__c 
                     from Lead where FirstName = 'TestTrigger'and LastName = 'Yarlagadda'];
    
    testLead1.Co_Borrowers_Home_Phone__c = '(765) 213-6239';
    testLead1.Co_Borrowers_House__c = '18600';
    
    update testLead1;
    
    //Checking the conditions in trigger loops
    Lead testLead2 = [select Co_Borrowers_Home_Phone__c,Co_Borrowers_House__c,Borrowers_Home_Phone__c,
                       BorrowersHouse__c,Copy_Borrowers_Home_Phone__c,Copy_Borrower_Current_Address__c
                      from Lead where FirstName = 'TestTrigger'and LastName = 'Yarlagadda'];
                      
    System.assertEquals(testLead2.Copy_Borrowers_Home_Phone__c, False);
    System.assertEquals(testLead2.Copy_Borrower_Current_Address__c, False);
    System.assertEquals(testLead2.Co_Borrowers_Home_Phone__c, '(765) 213-6239');
    System.assertEquals(testLead2.Co_Borrowers_House__c, '18600');
    System.assertEquals(testLead2.Borrowers_Home_Phone__c, '(504) 213-5698');
    System.assertEquals(testLead2.BorrowersHouse__c, '8274');               
   }
  */     
}