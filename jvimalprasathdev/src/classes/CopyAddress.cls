/*
Name: CopyAddress
Author: Chaitanya P 
Description: This Class copies Borrowers address to Property address on save
Last modified by: Leena N
*/
public class CopyAddress
{
// To copy borrower's address to Subject Address
    public void copyBorrowerAddress(List<Lead> New_Leads)
    {
            for(Lead l : New_Leads)
               {
                if(l.Copy_Borrower_Current_Address_to_Subject__c == true)
                  {
                    l.Property_Apt__c = l.Borrowers_Apt__c;
                    l.Property_House__c = l.BorrowersHouse__c;
                    l.Property_Address_1__c = l.Borrowers_Address_1__c;  
                    l.Property_Address_2__c = l.Borrowers_Address_2__c;
                    l.Property_City__c = l.Borrowers_City__c;
                    l.Property_State__c = l.Borrowers_State__c;
                    l.Property_County__c = l.Borrowers_County__c;
                    l.Property_Country__c = l.Borrowers_Country__c;
                    l.Property_Zip_Postal_Code__c = l.Borrowers_Zip_Postal_Code__c;
                    l.Copy_Borrower_Current_Address_to_Subject__c = false;
                  }              
               }    
    }
}