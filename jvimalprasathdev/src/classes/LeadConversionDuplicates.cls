/*
Name: LeadConversionDuplicates
Author:  Piyush
Description: This class checks if the newly inserted leads are duplicates. If leads
             are found to be duplicates,changes owner and removes them from Assignment Rules.
             
Last modified by: 
*/
public class LeadConversionDuplicates{

static public void findDuplicates(List<id> Leadid)
    {
        
     try{
       
        Boolean flag = false;
        Boolean firstDuplicateFound = false;
        list<lead> updateLeads = new list<lead>();
        
        List<lead> New_leads = new list<lead>([Select id,name,firstname,lastname,email,Borrowers_Home_Phone__c,Borrowers_Mobile_Phone__c,Borrowers_Work_Phone__c,Borrowers_Address_1__c,Borrowers_Address_2__c,Borrowers_Apt__c,Best_Contact_Time__c,Borrowers_City__c,Borrowers_Country__c,Borrowers_County__c,Borrowers_Current_Residence__c,Borrowers_Fax__c,BorrowersHouse__c,Language__c,Marital_Status__c,DoNotCall,Existing_Second_Mortgage__c,Borrowers_State__c,Time_Zone__c,Borrowers_Work_Phone_Extn__c,Borrowers_Zip_Postal_Code__c,Co_Borrower_Full_Name__c,Co_Borrowers_Address_1__c,Co_Borrowers_Address_2__c,Co_Borrowers_Apt__c,Co_Borrowers_City__c,Co_Borrowers_Country__c,Co_Borrowers_County__c,Co_Borrowers_Current_Residence__c,Co_Borrowers_Fax__c,Co_Borrowers_First_Name__c,Co_Borrowers_Last_Name__c,Co_Borrowers_House__c,Co_Borrowers_Email__c,Co_Borrowers_Home_Phone__c,Co_Borrowers_Mobile_Phone__c,Co_Borrowers_State__c,Co_Borrowers_Work_Phone_Extn__c,Co_Borrowers_Work_Phone__c,Co_Borrowers_Zip_Postal_Code__c,ownerid,owner.firstname,owner.lastname,recordTypeId,Account_Name__c,Co_Borrower__c,createddate,Empower_Lead_ID__c from lead where id IN:leadid ]); 
        
        
        // Queue User
        User QueueUser = [Select id,name from User where name = 'Queue User' limit 1];
        system.debug('******QueueUser'+QueueUser);

            
       //List of all Borrowers and Co-Borrowers names,email and phone in the newly created leads.     
            list<String> newLeadNames = new list<String>();
            list<String> newLeadid = new list<String>();
            list<String> newLeadPhone = new list<String>();
            for(Lead l : New_Leads){
             newLeadNames.add(l.firstname + ' ' + l.lastname);
             newLeadid.add(l.id);
             if(l.Co_Borrower_Full_Name__c != null)
              newLeadNames.add(l.Co_Borrower_Full_Name__c);
            } 
            system.debug('******ListleadsNames' +newLeadNames);
            
            
        
        //get the lead Record type - 'ToBeConverted'.
            Recordtype LeadRecordType = [select id from recordtype where name = 'ToBeConverted'  and SobjectType = 'Lead'  limit 1]; 
            Recordtype CustomerRecordType = [select id from recordtype where name = 'Customer' AND SobjectType = 'Account' limit 1]; 
             
        
        //List of Leads with Record type NOT as 'ToBeConverted'
            List<Lead> ListLeads = [Select id,name,firstname,lastname,email,Borrowers_Home_Phone__c,Borrowers_Mobile_Phone__c,Borrowers_Work_Phone__c,ownerid,owner.firstname,owner.lastname,recordTypeId,Account_Name__c,Co_Borrower__c,createddate,Co_Borrower_Full_Name__c from lead where recordTypeid != :LeadRecordType.id and name IN :newLeadNames and id NOT IN:newLeadid /*and owner.firstname != null*/ order by createddate ];
            system.debug('******Listleads' +ListLeads);
        

        
        //List of all Personal Accounts 
            list<Account> accList = [Select id,firstname,lastname,ownerid,PersonHomePhone,PersonMobilePhone,Work_Phone__c,PersonEmail from Account where name IN:newLeadNames];
            system.debug('******ListAccounts' +accList);
       
       //List of Accounts to update
          list<Account> updateAccount = new List<Account>();     
            
        
        //check for the duplicates  
          
            for(Lead l : New_Leads){
            
            
            
             String LeadName = l.firstname +' '+l.lastname;
             flag = false;
               
               //check for Borrower details in existing Accounts
               for(Account a: accList){
               system.debug('******firstname'+a.firstname+' '+l.firstname+' '+(a.firstname == l.firstname));
               system.debug('******lastname'+a.lastname+' '+l.lastname+' '+(a.lastname == l.lastname));
               system.debug('******email'+a.PersonEmail+' '+l.email+' '+(a.PersonEmail == l.email));
               if(a.firstname == l.firstname && a.lastname == l.lastname && ((l.email!= null && a.PersonEmail == l.email) || (l.Borrowers_Home_Phone__c != null && a.PersonHomePhone == l.Borrowers_Home_Phone__c) || (l.Borrowers_Mobile_Phone__c != null && a.PersonMobilePhone == l.Borrowers_Mobile_Phone__c) || (l.Borrowers_Work_Phone__c != null && a.Work_Phone__c == l.Borrowers_Work_Phone__c) )){
                      //duplicate found
                      flag = true;
                      
                      if(a.ownerid != queueuser.id)
                       l.ownerid = a.ownerid; //update Lead owner same as Account.
                      if(a.ownerid == queueuser.id){
                       a.ownerid = l.ownerid;
                       updateAccount.add(a);
                       }
                       
                      l.Account_Name__c = a.id; //update Lead Account Name ID.
                      
                      
                     
                      
                      //search for Co-Borrower details in Accounts
                      
                      if(l.Co_Borrowers_First_Name__c != null){
                      boolean coborrowerFound = false;
                      for(Account Ca: acclist){
                          if(Ca.firstname == l.Co_Borrowers_First_Name__c && ca.lastname == l.Co_Borrowers_Last_Name__c && ((ca.PersonEmail == l.Co_Borrowers_Email__c && l.Co_Borrowers_Email__c !=null) || (l.Co_Borrowers_Home_Phone__c != null && ca.PersonHomePhone == l.Co_Borrowers_Home_Phone__c) || (ca.PersonMobilePhone == l.Co_Borrowers_Mobile_Phone__c && l.Co_Borrowers_Mobile_Phone__c != null) || (ca.Work_Phone__c == l.Co_Borrowers_Work_Phone__c && l.Co_Borrowers_Work_Phone__c != null) )){
                          
                           //Match found
                           l.Co_Borrower__c = ca.id; //Update Lead Co-Borrower Account Name with Customer ID.
                           coborrowerFound = true;
                           break;     
                          }
                      }
                      //No Match found 
                      if(coborrowerFound == false){
                      //create SFDC Personal Account with Co-Borrower details and Account Owner as Lead Owner.
                        Account acc = new Account();
                        acc.ownerid = l.ownerid;
                        acc.recordTypeId = CustomerRecordType.id;
                        acc.Address_1__c = l.Co_Borrowers_Address_1__c;
                        acc.Address_2__c = l.Co_Borrowers_Address_2__c;
                        acc.Apt__c = l.Co_Borrowers_Apt__c;
                        acc.Best_Contact_Time__c = l.Best_Contact_Time__c;
                        acc.City__c = l.Co_Borrowers_City__c;
                        acc.Country__c = l.Co_Borrowers_Country__c;
                        acc.County__c = l.Co_Borrowers_County__c;
                        acc.Current_Residence_Type__c = l.Co_Borrowers_Current_Residence__c;
                        acc.Fax__c = l.Co_Borrowers_Fax__c;
                        acc.FirstName = l.Co_Borrowers_First_Name__c;
                        acc.House__c = l.Co_Borrowers_House__c;
                        acc.Language__c = l.Language__c;
                        acc.LastName = l.Co_Borrowers_Last_Name__c;
                        acc.PersonDoNotCall = l.DoNotCall;
                        acc.PersonEmail = l.Co_Borrowers_Email__c;
                        acc.PersonHomePhone = l.Co_Borrowers_Home_Phone__c;
                        acc.PersonMobilePhone = l.Co_Borrowers_Mobile_Phone__c;
                        acc.State__c = l.Co_Borrowers_State__c;
                        acc.Time_Zone__c = l.Time_Zone__c;
                        acc.Work_Phone_Extn__c = l.Co_Borrowers_Work_Phone_Extn__c;
                        acc.Work_Phone__c = l.Co_Borrowers_Work_Phone__c;
                        acc.Zip_Postal_Code__c = l.Co_Borrowers_Zip_Postal_Code__c;
                        
                        insert acc;
                      //update Lead Co-Borrower Account name with newly created Account.
                        l.Co_Borrower__c = acc.id;
                      }
                     }//end of Co-Borrower details
                     
                     break;
                     
                    }//end of Borrower details
                    }//end of for loop of Accounts for Borrower
                    
                    

              //else check for Co-Borrower details in existing Accounts 
               if(flag == false){
                for(Account a: accList){
                if(a.firstname == l.Co_Borrowers_First_Name__c && a.lastname == l.Co_Borrowers_Last_Name__c && ((a.PersonEmail == l.Co_Borrowers_Email__c && l.Co_Borrowers_Email__c != null) || (a.PersonHomePhone == l.Co_Borrowers_Home_Phone__c && l.Co_Borrowers_Home_Phone__c != null) || (a.PersonMobilePhone == l.Co_Borrowers_Mobile_Phone__c && l.Co_Borrowers_Mobile_Phone__c != null) || (a.Work_Phone__c == l.Co_Borrowers_Work_Phone__c && l.Co_Borrowers_Home_Phone__c != null) )){

                       //duplicate found 
                       flag = true;
                       l.ownerid = a.ownerid; //Update Lead Owner as Co-Borrower Account owner.
                       l.Co_Borrower__c = a.id; //Update Lead Co-Borrower Account Name with Customer ID.
                      
                       
                       //create SFDC Personal Account with Borrower details and Account owner as Co-Borrower Account Owner.
                        Account acc = new Account();
                        acc.ownerid = a.ownerid;
                        acc.recordTypeId = CustomerRecordType.id;
                        acc.Address_1__c = l.Borrowers_Address_1__c;
                        acc.Address_2__c = l.Borrowers_Address_2__c;
                        acc.Apt__c = l.Borrowers_Apt__c;
                        acc.Best_Contact_Time__c = l.Best_Contact_Time__c;
                        acc.City__c = l.Borrowers_City__c;
                        acc.Country__c = l.Borrowers_Country__c;
                        acc.County__c = l.Borrowers_County__c;
                        acc.Current_Residence_Type__c = l.Borrowers_Current_Residence__c;
                        acc.Fax__c = l.Borrowers_Fax__c;
                        acc.FirstName = l.FirstName;
                        acc.House__c = l.BorrowersHouse__c;
                        acc.Language__c = l.Language__c;
                        acc.LastName = l.LastName;
                        acc.Marital_Status__c = l.Marital_Status__c;
                        acc.PersonDoNotCall = l.DoNotCall;
                        acc.PersonEmail = l.Email;
                        acc.PersonHasOptedOutOfEmail = l.Existing_Second_Mortgage__c;
                        acc.PersonHomePhone = l.Borrowers_Home_Phone__c;
                        acc.PersonMobilePhone = l.Co_Borrowers_Mobile_Phone__c;
                        acc.State__c = l.Borrowers_State__c;
                        acc.Time_Zone__c = l.Time_Zone__c;
                        acc.Work_Phone_Extn__c = l.Borrowers_Work_Phone_Extn__c;
                        acc.Work_Phone__c = l.Borrowers_Work_Phone__c;
                        acc.Zip_Postal_Code__c = l.Borrowers_Zip_Postal_Code__c;
                        
                        insert acc;
                       //update Lead Account Name as newly created Account. 
                        l.Account_Name__c = acc.id;
                        break;

                   }
                   }//end of for loop of Accounts.
                   }//end of search for Co-Borrower details.
                   
                    
                    
                   
                   //else check for Borrower details in NON-'ToBeConverted' leads.
                   
                  if(flag == false){
                   for(Lead exL : ListLeads){
                      if(exL.firstname == l.firstname && exL.lastname == l.lastname &&((exL.email == l.email && l.email != null) || (exL.Borrowers_Home_Phone__c == l.Borrowers_Home_Phone__c && l.Borrowers_Home_Phone__c != null) ||(exL.Borrowers_Mobile_Phone__c == l.Borrowers_Mobile_Phone__c && l.Borrowers_Mobile_Phone__c != null) || (exL.Borrowers_Work_Phone__c == l.Borrowers_Work_Phone__c && l.Borrowers_Work_Phone__c != null))){
                           //duplicate found 
                           
                           
                           
                         //create Account for only first duplictae
                         if(firstDuplicateFound == false){  
                          firstDuplicateFound = true;
                        
                         
                        
                        //create SFDC Personal Account with Borrower details and Account owner as found Lead Owner.
                            Account acc = new Account();
                           if(exL.owner.firstname == null && exL.owner.lastname == null)
                             acc.ownerid = queueuser.id;
                           else{
                            acc.ownerid = exL.ownerid;
                            l.ownerid = exL.ownerid; //update New Lead(l) owner as found Lead Owner.
                           } 
                            acc.recordTypeId = CustomerRecordType.id;
                            acc.Address_1__c = l.Borrowers_Address_1__c;
                            acc.Address_2__c = l.Borrowers_Address_2__c;
                            acc.Apt__c = l.Borrowers_Apt__c;
                            acc.Best_Contact_Time__c = l.Best_Contact_Time__c;
                            acc.City__c = l.Borrowers_City__c;
                            acc.Country__c = l.Borrowers_Country__c;
                            acc.County__c = l.Borrowers_County__c;
                            acc.Current_Residence_Type__c = l.Borrowers_Current_Residence__c;
                            acc.Fax__c = l.Borrowers_Fax__c;
                            acc.FirstName = l.FirstName;
                            acc.House__c = l.BorrowersHouse__c;
                            acc.Language__c = l.Language__c;
                            acc.LastName = l.LastName;
                            acc.Marital_Status__c = l.Marital_Status__c;
                            acc.PersonDoNotCall = l.DoNotCall;
                            acc.PersonEmail = l.Email;
                            acc.PersonHasOptedOutOfEmail = l.Existing_Second_Mortgage__c;
                            acc.PersonHomePhone = l.Borrowers_Home_Phone__c;
                            acc.PersonMobilePhone = l.Co_Borrowers_Mobile_Phone__c;
                            acc.State__c = l.Borrowers_State__c;
                            acc.Time_Zone__c = l.Time_Zone__c;
                            acc.Work_Phone_Extn__c = l.Borrowers_Work_Phone_Extn__c;
                            acc.Work_Phone__c = l.Borrowers_Work_Phone__c;
                            acc.Zip_Postal_Code__c = l.Borrowers_Zip_Postal_Code__c;
                            
                            insert acc;

                           //update Found Lead Account Name ID as newly created Account
                             exL.Account_Name__c = acc.id;
                             
                            
                          //update New Lead Account Name ID as newly created Account
                            l.Account_Name__c = acc.id;
                            }
                            
                            //add all duplicate leads to the update list
                             updateLeads.add(exL);
                            
               
               }
               }//end of for loop for existing leads
                
               }//end of flag.
               
              
               }//end of for loop for triggered leads
               
               update updateAccount;
               update updateLeads;
               
               
               
    }
    Catch(Exception e){
             System.debug('Error '+e);
       }
    }
}