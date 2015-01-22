@IsTest 
 public class CopyAddress_Test {
 
 
  static testmethod void CopyAddress_TestMethod() {
      lead l=new lead();
      l.FirstName= 'asda';
      l.LastName = 'asdad';
      l.Company = 'asda';
      l.email='test@test.com';
      l.Copy_Borrower_Current_Address_to_Subject__c = true;
      l.Borrowers_Apt__c = 'ADSA';
      l.BorrowersHouse__c = 'ASDAD';
      l.Borrowers_Address_1__c = 'aSDAD';
      l.Borrowers_Address_2__c = 'ADASD';
      l.Borrowers_City__c = 'ADSA';
      l.Borrowers_State__c = 'aa';
      l.Borrowers_Country__c = 'adasda';
      l.Borrowers_County__c = 'adsa';
      l.Property_State__c = 'AD';
      l.Borrowers_Zip_Postal_Code__c = '45646';
      insert l;
  }
  static testmethod void CopyAddress_TestMethod1() {
      lead l=new lead();
      l.FirstName= 'asda';
      l.LastName = 'asdad';
      l.Company = 'asda';
      l.email='test@test.com';
      l.Copy_Borrower_Current_Address_to_Subject__c = true;
      l.Property_Apt__c = 'ADSA';
      l.Property_House__c = 'ADSA';
      l.Property_Address_1__c = 'ADSA';  
      l.Property_Address_2__c = 'ADSA';
      l.Property_City__c = 'ADSA';
      l.Property_State__c = 'AD';
      l.Property_County__c = 'ADSA';
      l.Property_Country__c = 'ADSA';
      l.Property_Zip_Postal_Code__c = '45544';
      l.Copy_Borrower_Current_Address_to_Subject__c = false;  
      insert l;    
  }
}