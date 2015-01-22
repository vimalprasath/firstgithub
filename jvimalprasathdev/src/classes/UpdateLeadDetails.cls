public class UpdateLeadDetails{
    public void updateAddressAndPhone(List<Lead> Lead_Details){
        for (Lead l : Lead_Details){
           if(l.Copy_Borrower_Current_Address__c == true){     
             if(l.Co_Borrowers_Address_1__c!=null || l.Co_Borrowers_Address_2__c!=null ||
                l.Co_Borrowers_City__c != null ||  l.Co_Borrowers_House__c != null || 
                l.Co_Borrowers_Country__c != null ||l.Co_Borrowers_County__c != null ||
                l.Co_Borrowers_State__c != null ||l.Co_Borrowers_Zip_Postal_Code__c != null|| l.Co_Borrowers_Apt__c != null){
                      if(l.Co_Borrowers_Address_1__c != l.Borrowers_Address_1__c ||l.Co_Borrowers_Address_2__c != l.Borrowers_Address_2__c||
                         l.Co_Borrowers_City__c != l.Borrowers_City__c ||l.Co_Borrowers_House__c != l.BorrowersHouse__c ||
                         l.Co_Borrowers_Country__c != l.Borrowers_Country__c || l.Co_Borrowers_County__c != l.Borrowers_County__c ||
                         l.Co_Borrowers_State__c != l.Borrowers_State__c || l.Co_Borrowers_Zip_Postal_Code__c != l.Borrowers_Zip_Postal_Code__c ||
                         l.Co_Borrowers_Apt__c!= l.Borrowers_Apt__c){
                                 l.Copy_Borrower_Current_Address__c = false;
                       }
             }else{
                   l.Co_Borrowers_Address_1__c = l.Borrowers_Address_1__c;    
                   l.Co_Borrowers_Address_2__c = l.Borrowers_Address_2__c;  
                   l.Co_Borrowers_House__c = l.BorrowersHouse__c;  
                   l.Co_Borrowers_Zip_Postal_Code__c = l.Borrowers_Zip_Postal_Code__c;  
                   l.Co_Borrowers_City__c = l.Borrowers_City__c;  
                   l.Co_Borrowers_State__c = l.Borrowers_State__c;  
                   l.Co_Borrowers_County__c = l.Borrowers_County__c;  
                   l.Co_Borrowers_Country__c = l.Borrowers_Country__c;     
                   l.Co_Borrowers_Apt__c = l.Borrowers_Apt__c;  
             }  
             l.Copy_Borrower_Current_Address__c = false;                  
           }  
           if(l.Copy_Borrowers_Home_Phone__c == true){    
           	// Updated for B-3472849   --- Start  
           		   l.Co_Borrowers_Home_Phone__c = l.Borrowers_Home_Phone__c;
                   l.Copy_Borrowers_Home_Phone__c = false;
           	/*  
           	 
              if (l.Co_Borrowers_Home_Phone__c!=null){
                   //if(l.Co_Borrowers_Home_Phone__c!=l.Borrowers_Home_Phone__c){
                      //l.Copy_Borrowers_Home_Phone__c = false;
                   //}
                   // Flag is cleared irrespective of the check on the Home phone field.
                   l.Copy_Borrowers_Home_Phone__c = false;
               }else{
                  if (l.Co_Borrowers_Home_Phone__c == null){
                     l.Co_Borrowers_Home_Phone__c = l.Borrowers_Home_Phone__c;
                     l.Copy_Borrowers_Home_Phone__c = false;
                  }        
               }
            */
            // Updated for B-3472849   --- End
           }  
        }   
    }
}