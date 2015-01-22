/* 
Description: This class checks if the newly inserted leads are duplicates. If leads
             are found to be duplicates,changes owner and removes them from Assignment Rules.
 Refactoring old class LeadConversionDuplicates
 Author - Richard Joseph
 Created Date- March 6th, 2014            
 User Story - B-303661 
 
 Change Log 
 >  Historic Lead Data fix B367850 - Richard Joseph - April 23rd 2014
*/

public class LeadDuplicateProcessing {



private List<Lead> IncommingLeadList; 
private map<id,Lead> ExistingLeadMap;
private list<Account> AccountList;
private id AccountRecordTypeId;
private id LeadRecordTypeId;
private list<Account> AccountsCreationList ;
Public static boolean isExecuted = false;
Public static boolean isInsertUpdate = false;
private boolean isHistoricBatch = false;
@future
public static void DuplicateProcessingFuture(set<id> LeadIdSet) {
    LeadDuplicateProcessing LDPObj= new LeadDuplicateProcessing();
    LDPObj.DuplicateProcessing(LeadIdSet);
}

//Created for Historic Lead Data fix B367850 - Richard Joseph - April 23rd 2014
public void DuplicateProcessingHistoricBatch(set<id> LeadIdSet) {
    isHistoricBatch= true;
    DuplicateProcessing(LeadIdSet);
}

public void DuplicateProcessing(set<id> LeadIdSet) 
    {
        
         isExecuted = true; 
         list<String> LeadNamesList = new list<String>();
         set<id> BorrowerAccountCreatedLeadId= new set<id>();
         set<id> CoBorrowerAccountCreatedLeadId= new set<id>();
         AccountsCreationList = new list<Account>();
         Map<id,Lead> ToUpdateLeadList = new Map<id,Lead>();
         List<Account> ToUpdateAccountList = new List<Account>();
         
         
         //Richard WIP 
         
         map <id, String> LeadBorrrowerNamesMap = new map<id,string>();
        
     //try{
            IncommingLeadList = new list<lead>([Select id,Lead_Owner_Role_RR__c,name,firstname,Phone,lastname,email,Borrowers_Home_Phone__c,Borrowers_Mobile_Phone__c,Borrowers_Work_Phone__c,Borrowers_Address_1__c,Borrowers_Address_2__c,Borrowers_Apt__c,Best_Contact_Time__c,Borrowers_City__c,Borrowers_Country__c,Borrowers_County__c,Borrowers_Current_Residence__c,Borrowers_Fax__c,BorrowersHouse__c,Language__c,Marital_Status__c,DoNotCall,Existing_Second_Mortgage__c,Borrowers_State__c,Time_Zone__c,Borrowers_Work_Phone_Extn__c,Borrowers_Zip_Postal_Code__c,Co_Borrower_Full_Name__c,Co_Borrowers_Address_1__c,Co_Borrowers_Address_2__c,Co_Borrowers_Apt__c,Co_Borrowers_City__c,Co_Borrowers_Country__c,Co_Borrowers_County__c,Co_Borrowers_Current_Residence__c,Co_Borrowers_Fax__c,Co_Borrowers_First_Name__c,Co_Borrowers_Last_Name__c,Co_Borrowers_House__c,Co_Borrowers_Email__c,Co_Borrowers_Home_Phone__c,Co_Borrowers_Mobile_Phone__c,Co_Borrowers_State__c,Co_Borrowers_Work_Phone_Extn__c,Co_Borrowers_Work_Phone__c,Co_Borrowers_Zip_Postal_Code__c,ownerid,owner.firstname,owner.lastname,recordTypeId,Account_Name__c,Co_Borrower__c,createddate,Empower_Lead_ID__c from lead where id IN:LeadIdSet ]);
       
       //List of all Borrowers and Co-Borrowers names in the newly created leads.     
           
            for(Lead IncommingLeadRec : IncommingLeadList){
             LeadNamesList.add(IncommingLeadRec.firstname + ' ' + IncommingLeadRec.lastname);
                          
             if(IncommingLeadRec.Co_Borrower_Full_Name__c != null)
              LeadNamesList.add(IncommingLeadRec.Co_Borrower_Full_Name__c);
            } 
            
          //get the Record type - for lead and Account.  
            AccountRecordTypeId= Schema.SObjectType.Account.RecordTypeInfosByName.get('Customer').RecordTypeId;
            LeadRecordTypeId = Schema.SObjectType.Lead.RecordTypeInfosByName.get('ToBeConverted').RecordTypeId;
           
           //Getting Details of Queue User. 
            User QueueUser = [Select id,name from User where name = 'Queue User' limit 1];
            
            //Changed by Vimal for the story B-628921 Starts Here
            
            Map<Id,User> userList = new Map<Id,User>([select id, userrole.name from user]);
            List<RecordType> preRecordID=[select id from RecordType where Name='Prequal' and SObjectType='Lead' limit 1];
            List<RecordType> heRecordID=[select id from RecordType where Name='Home Equity' and SObjectType='Lead' limit 1];
   
            ID PreRecID=null;
            for(RecordType pr:preRecordID)
            {
                preRecID=pr.id;
            }
            ID heRecID=null;
            for(RecordType hr:heRecordID)
            {
                heRecID=hr.id;
            }  
   
            //Changed by Vimal for the story B-628921 Ends Here
            
          //List of Leads with Record type NOT as 'ToBeConverted'
          if(isHistoricBatch)
           ExistingLeadMap = new map<id,Lead>([Select id,Lead_Owner_Role_RR__c,name,Phone,firstname,lastname,email,Borrowers_Home_Phone__c,Borrowers_Mobile_Phone__c,Borrowers_Work_Phone__c,ownerid,owner.firstname,owner.lastname,recordTypeId,Account_Name__c,Co_Borrower__c,createddate,Co_Borrower_Full_Name__c from lead where recordTypeid = :LeadRecordTypeId and name IN :LeadNamesList and owner.Isactive = True and id NOT IN:LeadIdSet /*and owner.firstname != null*/ order by createddate DESC ]);
          else
            ExistingLeadMap = new map<id,Lead>([Select id,Lead_Owner_Role_RR__c,name,Phone,firstname,lastname,email,Borrowers_Home_Phone__c,Borrowers_Mobile_Phone__c,Borrowers_Work_Phone__c,ownerid,owner.firstname,owner.lastname,recordTypeId,Account_Name__c,Co_Borrower__c,createddate,Co_Borrower_Full_Name__c from lead where recordTypeid != :LeadRecordTypeId and name IN :LeadNamesList and owner.Isactive = True and id NOT IN:LeadIdSet /*and owner.firstname != null*/ order by createddate DESC ]);
         
         //List of all Personal Accounts 
            AccountList = [Select id,firstname,lastname,ownerid,Owner.Name,PersonHomePhone,PersonMobilePhone,Work_Phone__c,PersonEmail from Account where name IN:LeadNamesList];
         
         List<Lead> ConsolidatedLeadList = IncommingLeadList.clone();
         
         if (ExistingLeadMap.size()>0)
         ConsolidatedLeadList.addall(ExistingLeadMap.Values());
            
        for(Lead IncommingLeadRec : IncommingLeadList){
                
            for(Account AccountRec: AccountList){
                //System.debug('Richard Test '+ AccountRec.firstname +' '+ IncommingLeadRec.firstname +' '+ AccountRec.lastname +' '+ IncommingLeadRec.lastname + ' '+AccountRec.PersonEmail +' '+ IncommingLeadRec.email +' '+ AccountRec.PersonHomePhone +' '+ IncommingLeadRec.Borrowers_Home_Phone__c +' '+IncommingLeadRec.Phone+' '+ IncommingLeadRec.Borrowers_Mobile_Phone__c +' '+ AccountRec.PersonMobilePhone +' '+ IncommingLeadRec.Borrowers_Mobile_Phone__c +' '+  AccountRec.Work_Phone__c + ' '+IncommingLeadRec.Borrowers_Work_Phone__c);
                if(AccountRec.firstname == IncommingLeadRec.firstname && AccountRec.lastname == IncommingLeadRec.lastname && ((IncommingLeadRec.email!= null && AccountRec.PersonEmail == IncommingLeadRec.email) || (IncommingLeadRec.Borrowers_Home_Phone__c != null && AccountRec.PersonHomePhone == IncommingLeadRec.Borrowers_Home_Phone__c) || (IncommingLeadRec.Phone != null && AccountRec.PersonHomePhone == IncommingLeadRec.Phone) || (IncommingLeadRec.Borrowers_Mobile_Phone__c != null && AccountRec.PersonMobilePhone == IncommingLeadRec.Borrowers_Mobile_Phone__c) || (IncommingLeadRec.Borrowers_Work_Phone__c != null && AccountRec.Work_Phone__c == IncommingLeadRec.Borrowers_Work_Phone__c) ))
                {
                    if(!isHistoricBatch){
                    if(AccountRec.Owner.Name != 'Queue User'){
                       IncommingLeadRec.ownerid = AccountRec.ownerid; //update Lead owner same as Account.
                       IncommingLeadRec.Lead_Owner_Queue__c = ''; // updated by sunil for bug B-439320  
                       
                       //Changed by Vimal for the story B-628921 Starts Here
                       
                       IncommingLeadRec.Lead_Owner_Role_RR__c= String.Valueof(userList.get(AccountRec.ownerid).userrole.name);
                       System.debug('***************Lead Owner Role'+IncommingLeadRec.Lead_Owner_Role_RR__c);
                       
                       if(IncommingLeadRec.Lead_Owner_Role_RR__c.contains('Home Equity'))
                        {
                            IncommingLeadRec.RecordTypeid=heRecID;
                        }
                        else
                        {
                            IncommingLeadRec.RecordTypeid=preRecID;
                        }
                        
                        //Changed by Vimal for the story B-628921 Ends Here
                        
                    }else if(AccountRec.Owner.Name == 'Queue User'){
                       //AccountRec.ownerid = IncommingLeadRec.ownerid;
                       IncommingLeadRec.ownerid = QueueUser.id;
                       IncommingLeadRec.Lead_Owner_Queue__c = ''; // Added by Sunil for B-407395
                       //updateAccount.add(a); 
                       ToUpdateAccountList.add(AccountRec);
                       }
                       
                    }
                      IncommingLeadRec.Account_Name__c = AccountRec.id; 
                      IncommingLeadRec.IsDuplicate__c=true;
                      ToUpdateLeadList.put(IncommingLeadRec.id,IncommingLeadRec) ;
                    
                    
                }
                
                if(AccountRec.firstname == IncommingLeadRec.Co_Borrowers_First_Name__c && AccountRec.lastname == IncommingLeadRec.Co_Borrowers_Last_Name__c && ((AccountRec.PersonEmail == IncommingLeadRec.Co_Borrowers_Email__c && IncommingLeadRec.Co_Borrowers_Email__c !=null) || (IncommingLeadRec.Co_Borrowers_Home_Phone__c != null && AccountRec.PersonHomePhone == IncommingLeadRec.Co_Borrowers_Home_Phone__c) || (AccountRec.PersonMobilePhone == IncommingLeadRec.Co_Borrowers_Mobile_Phone__c && IncommingLeadRec.Co_Borrowers_Mobile_Phone__c != null) || (AccountRec.Work_Phone__c == IncommingLeadRec.Co_Borrowers_Work_Phone__c && IncommingLeadRec.Co_Borrowers_Work_Phone__c != null) ))
                {
                    if(!isHistoricBatch){ 
                     if(AccountRec.OwnerId != QueueUser.id){
                       IncommingLeadRec.ownerid = AccountRec.ownerid; //update Lead owner same as Account.
                       IncommingLeadRec.Lead_Owner_Queue__c = ''; // updated by sunil for bug B-439320
                       
                       //Changed by Vimal for the story B-628921 Starts Here
                       
                       IncommingLeadRec.Lead_Owner_Role_RR__c= String.Valueof(userList.get(AccountRec.ownerid).userrole.name);
                       System.debug('***************Lead Owner Role'+IncommingLeadRec.Lead_Owner_Role_RR__c);
                       
                       if(IncommingLeadRec.Lead_Owner_Role_RR__c.contains('Home Equity'))
                        {
                            IncommingLeadRec.RecordTypeid=heRecID;
                        }
                        else
                        {
                            IncommingLeadRec.RecordTypeid=preRecID;
                        }
                        
                        //Changed by Vimal for the story B-628921 Ends  Here
                        
                     }else if(AccountRec.OwnerId == QueueUser.id){
                        IncommingLeadRec.ownerid = QueueUser.id;
                        IncommingLeadRec.Lead_Owner_Queue__c = ''; // Added by Sunil for B-407395
                       //AccountRec.ownerid = IncommingLeadRec.ownerid;
                       //updateAccount.add(a); 
                       ToUpdateAccountList.add(AccountRec);
                       }    
                    } 
                       
                        IncommingLeadRec.Co_Borrower__c = AccountRec.id;
                        IncommingLeadRec.IsDuplicate__c=true;
                        ToUpdateLeadList.put(IncommingLeadRec.id,IncommingLeadRec) ;
                }
                    
            }
            if (IncommingLeadRec.Account_Name__c != null && IncommingLeadRec.Co_Borrower__c == null && IncommingLeadRec.Co_Borrowers_First_Name__c!= null &&  IncommingLeadRec.Co_Borrowers_Last_Name__c != null && (IncommingLeadRec.Co_Borrowers_Email__c != null || IncommingLeadRec.Co_Borrowers_Home_Phone__c != null || IncommingLeadRec.Co_Borrowers_Mobile_Phone__c != null || IncommingLeadRec.Co_Borrowers_Work_Phone__c != null ))
            {
                //Create  Co-Borrower Account
                AccountsCreationList.add(CreateCoBorrowerAccount(IncommingLeadRec,IncommingLeadRec.Account_Name__r.OwnerId ));
                CoBorrowerAccountCreatedLeadId.add(IncommingLeadRec.Id);
                 
            }
            else if (IncommingLeadRec.Account_Name__c == null && IncommingLeadRec.Co_Borrower__c != null)
            {
                //Create Borrower  Account
                AccountsCreationList.add(CreateBorrowerAccount(IncommingLeadRec,IncommingLeadRec.Co_Borrower__r.OwnerId));
                BorrowerAccountCreatedLeadId.add(IncommingLeadRec.Id);
                
            }
            
            if (IncommingLeadRec.Account_Name__c == null && IncommingLeadRec.Co_Borrower__c == null)
            {
                // Check for Existing Leads 
                Boolean IsAccountCreated = false;
                for(Lead ExistingLeadRec : ConsolidatedLeadList){
                      if(IncommingLeadRec.id !=ExistingLeadRec.id && ExistingLeadRec.firstname == IncommingLeadRec.firstname && ExistingLeadRec.lastname == IncommingLeadRec.lastname &&((ExistingLeadRec.email == IncommingLeadRec.email && IncommingLeadRec.email != null) || (ExistingLeadRec.Borrowers_Home_Phone__c == IncommingLeadRec.Borrowers_Home_Phone__c && IncommingLeadRec.Borrowers_Home_Phone__c != null) ||(ExistingLeadRec.Borrowers_Mobile_Phone__c == IncommingLeadRec.Borrowers_Mobile_Phone__c && IncommingLeadRec.Borrowers_Mobile_Phone__c != null) || (ExistingLeadRec.Borrowers_Work_Phone__c == IncommingLeadRec.Borrowers_Work_Phone__c && IncommingLeadRec.Borrowers_Work_Phone__c != null)))
                    {
                        for (Account AccountRec: AccountsCreationList)
                        {
                            if(AccountRec.firstname == IncommingLeadRec.firstname && AccountRec.lastname == IncommingLeadRec.lastname && ((IncommingLeadRec.email!= null && AccountRec.PersonEmail == IncommingLeadRec.email) || (IncommingLeadRec.Borrowers_Home_Phone__c != null && AccountRec.PersonHomePhone == IncommingLeadRec.Borrowers_Home_Phone__c) || (IncommingLeadRec.Borrowers_Mobile_Phone__c != null && AccountRec.PersonMobilePhone == IncommingLeadRec.Borrowers_Mobile_Phone__c) || (IncommingLeadRec.Borrowers_Work_Phone__c != null && AccountRec.Work_Phone__c == IncommingLeadRec.Borrowers_Work_Phone__c) ))
                                {
                                    
                                    IsAccountCreated= true;
                                     if(!isHistoricBatch){
                                    if(AccountRec.OwnerId == QueueUser.id)
                               IncommingLeadRec.ownerid = QueueUser.id;
                               IncommingLeadRec.Lead_Owner_Queue__c = ''; // Added by Sunil for B-407395
                                     }
                                    break;
                                }
                            
                            
                        }
                        
                        If (!IsAccountCreated ){
                        if((ExistingLeadRec.owner.firstname == null && ExistingLeadRec.owner.lastname == null) || (ExistingLeadRec.ownerId == QueueUser.id ))
                        {
                             //acc.ownerid = queueuser.id;
                             AccountsCreationList.add(CreateBorrowerAccount(IncommingLeadRec,QueueUser.id));
                              if(!isHistoricBatch){
                             IncommingLeadRec.ownerid = QueueUser.id;
                             ExistingLeadRec.ownerid = QueueUser.id;
                             IncommingLeadRec.Lead_Owner_Queue__c = ''; // Added by Sunil for B-407395
                             ExistingLeadRec.Lead_Owner_Queue__c = ''; // Added by Sunil for B-407395
                             IncommingLeadRec.Lead_Owner_Role_RR__c= ExistingLeadRec.Lead_Owner_Role_RR__c; //Added by Vimal for B-628921
                             IncommingLeadRec.RecordTypeid=ExistingLeadRec.RecordTypeid; //Added by Vimal for B-628921
                             System.debug('***************Lead Owner Role '+IncommingLeadRec.Lead_Owner_Role_RR__c);
                              }
                        }
                           else{
                            //acc.ownerid = exL.ownerid;
                            IncommingLeadRec.ownerid = ExistingLeadRec.ownerid; //update New Lead owner as found Lead Owner.
                            IncommingLeadRec.Lead_Owner_Queue__c = ''; //Added by Vimal for B-628921
                            IncommingLeadRec.Lead_Owner_Role_RR__c= String.Valueof(userList.get(ExistingLeadRec.ownerid).userrole.name); //Added by Vimal for B-628921
                            IncommingLeadRec.RecordTypeid=ExistingLeadRec.RecordTypeid; //Added by Vimal for B-628921
                            System.debug('***************Lead Owner Role'+IncommingLeadRec.Lead_Owner_Role_RR__c);
                            //Create an Borrower Account
                            AccountsCreationList.add(CreateBorrowerAccount(IncommingLeadRec,ExistingLeadRec.ownerid));
                           } 
                           
                         
                        }
                        BorrowerAccountCreatedLeadId.add(IncommingLeadRec.Id); 
                        BorrowerAccountCreatedLeadId.add(ExistingLeadRec.Id);                        
                        ToUpdateLeadList.put(IncommingLeadRec.id,IncommingLeadRec) ;
                        ToUpdateLeadList.put(ExistingLeadRec.id,ExistingLeadRec) ;
                        
                    } 
                  
                
                
            }
        
        }
       
               
               
        }
        
    if(AccountsCreationList.size()>0)
    insert AccountsCreationList;
    
    
    if(ToUpdateLeadList.size()>0){
        List<Lead> UpdatedLeadList = new List<Lead>();
        For(Lead LeadRec: ToUpdateLeadList.Values())
        {
            
             if(BorrowerAccountCreatedLeadId.contains(LeadRec.id)  ){
                
                
                LeadRec.Account_Name__c = FindBorrowerAccount(LeadRec).id;
                //If(!ExistingLeadMap.containsKey(LeadRec.id))
                   LeadRec.IsDuplicate__c = true;
                   If (LeadRec.OwnerId == QueueUser.id && !isHistoricBatch)
                     leadRec.Is_assigned_already__c=true;
                UpdatedLeadList.add(LeadRec);
                
            }
            else if(CoBorrowerAccountCreatedLeadId.contains(LeadRec.id) ){
                LeadRec.Account_Name__c = FindCoBorrowerAccount(LeadRec).Id;
                //If(!ExistingLeadMap.containsKey(LeadRec.id))
                   LeadRec.IsDuplicate__c = true;
                   If (LeadRec.OwnerId == QueueUser.id && !isHistoricBatch)
                     leadRec.Is_assigned_already__c=true;
                UpdatedLeadList.add(LeadRec);
            }
            else if(LeadRec.Account_Name__c != null || LeadRec.Co_Borrower__c != null){
                //If(!ExistingLeadMap.containsKey(LeadRec.id))
                   LeadRec.IsDuplicate__c = true;
                   If (LeadRec.OwnerId == QueueUser.id && !isHistoricBatch)
                     leadRec.Is_assigned_already__c=true;
                UpdatedLeadList.add(LeadRec);
            }
            
            
        }
        
        if(UpdatedLeadList.size()>0)
        {
            update UpdatedLeadList; 
        }
        }
        
        if(ToUpdateAccountList.size()>0)
        update ToUpdateAccountList;
        
   /* }
    
        
     
    Catch(Exception e){
             System.debug('Error '+e);
       } */
       
    }
    
    Private Account CreateBorrowerAccount(Lead LeadAccountRec, Id OwnerId)
    {
        Account Borrower = new Account();
                            Borrower.recordTypeId = AccountRecordTypeId;
                            Borrower.Address_1__c = LeadAccountRec.Borrowers_Address_1__c;
                            Borrower.Address_2__c = LeadAccountRec.Borrowers_Address_2__c;
                            Borrower.Apt__c = LeadAccountRec.Borrowers_Apt__c;
                            Borrower.Best_Contact_Time__c = LeadAccountRec.Best_Contact_Time__c;
                            Borrower.City__c = LeadAccountRec.Borrowers_City__c;
                            Borrower.Country__c = LeadAccountRec.Borrowers_Country__c;
                            Borrower.County__c = LeadAccountRec.Borrowers_County__c;
                            Borrower.Current_Residence_Type__c = LeadAccountRec.Borrowers_Current_Residence__c;
                            Borrower.Fax__c = LeadAccountRec.Borrowers_Fax__c;
                            Borrower.FirstName = LeadAccountRec.FirstName;
                            Borrower.House__c = LeadAccountRec.BorrowersHouse__c;
                            Borrower.Language__c = LeadAccountRec.Language__c;
                            Borrower.LastName = LeadAccountRec.LastName;
                            Borrower.Marital_Status__c = LeadAccountRec.Marital_Status__c;
                            Borrower.PersonDoNotCall = LeadAccountRec.DoNotCall;
                            Borrower.PersonEmail = LeadAccountRec.Email;
                            Borrower.PersonHasOptedOutOfEmail = LeadAccountRec.Existing_Second_Mortgage__c;
                            if (LeadAccountRec.Borrowers_Home_Phone__c == null && LeadAccountRec.Phone != null )
                                    Borrower.PersonHomePhone= LeadAccountRec.Phone;
                            else        
                            Borrower.PersonHomePhone = LeadAccountRec.Borrowers_Home_Phone__c;
                            Borrower.PersonMobilePhone = LeadAccountRec.Borrowers_Mobile_Phone__c;
                            Borrower.State__c = LeadAccountRec.Borrowers_State__c;
                            Borrower.Time_Zone__c = LeadAccountRec.Time_Zone__c;
                            Borrower.Work_Phone_Extn__c = LeadAccountRec.Borrowers_Work_Phone_Extn__c;
                            Borrower.Work_Phone__c = LeadAccountRec.Borrowers_Work_Phone__c;
                            Borrower.Zip_Postal_Code__c = LeadAccountRec.Borrowers_Zip_Postal_Code__c;
                            if (OwnerId != null)
                            Borrower.ownerid = OwnerId;
                            else
                            Borrower.ownerid = LeadAccountRec.OwnerId;
        
        return Borrower;
        
    }
    
    Private Account CreateCoBorrowerAccount(Lead LeadAccountRec,Id OwnerId)
    {
        Account CoBorrower = new Account();
        
                         
                        CoBorrower.recordTypeId = AccountRecordTypeId;
                        CoBorrower.Address_1__c = LeadAccountRec.Co_Borrowers_Address_1__c;
                        CoBorrower.Address_2__c = LeadAccountRec.Co_Borrowers_Address_2__c;
                        CoBorrower.Apt__c = LeadAccountRec.Co_Borrowers_Apt__c;
                        CoBorrower.Best_Contact_Time__c = LeadAccountRec.Best_Contact_Time__c;
                        CoBorrower.City__c = LeadAccountRec.Co_Borrowers_City__c;
                        CoBorrower.Country__c = LeadAccountRec.Co_Borrowers_Country__c;
                        CoBorrower.County__c = LeadAccountRec.Co_Borrowers_County__c;
                        CoBorrower.Current_Residence_Type__c = LeadAccountRec.Co_Borrowers_Current_Residence__c;
                        CoBorrower.Fax__c = LeadAccountRec.Co_Borrowers_Fax__c;
                        CoBorrower.FirstName = LeadAccountRec.Co_Borrowers_First_Name__c;
                        CoBorrower.House__c = LeadAccountRec.Co_Borrowers_House__c;
                        CoBorrower.Language__c = LeadAccountRec.Language__c;
                        CoBorrower.LastName = LeadAccountRec.Co_Borrowers_Last_Name__c;
                        CoBorrower.PersonDoNotCall = LeadAccountRec.DoNotCall;
                        CoBorrower.PersonEmail = LeadAccountRec.Co_Borrowers_Email__c;
                        CoBorrower.PersonHomePhone = LeadAccountRec.Co_Borrowers_Home_Phone__c;
                        CoBorrower.PersonMobilePhone = LeadAccountRec.Co_Borrowers_Mobile_Phone__c;
                        CoBorrower.State__c = LeadAccountRec.Co_Borrowers_State__c;
                        CoBorrower.Time_Zone__c = LeadAccountRec.Time_Zone__c;
                        CoBorrower.Work_Phone_Extn__c = LeadAccountRec.Co_Borrowers_Work_Phone_Extn__c;
                        CoBorrower.Work_Phone__c = LeadAccountRec.Co_Borrowers_Work_Phone__c;
                        CoBorrower.Zip_Postal_Code__c = LeadAccountRec.Co_Borrowers_Zip_Postal_Code__c;
                        if (OwnerId != null)
                            CoBorrower.ownerid = OwnerId;
                            else
                            CoBorrower.ownerid = LeadAccountRec.OwnerId;
        
        
        return CoBorrower;
    }
    
    Private Account FindBorrowerAccount(Lead IncommingLeadRec )
    {
        For (Account AccountRec: AccountsCreationList)
        {
                if(AccountRec.firstname == IncommingLeadRec.firstname && AccountRec.lastname == IncommingLeadRec.lastname && ((IncommingLeadRec.email!= null && AccountRec.PersonEmail == IncommingLeadRec.email) || (IncommingLeadRec.Borrowers_Home_Phone__c != null && AccountRec.PersonHomePhone == IncommingLeadRec.Borrowers_Home_Phone__c) || (IncommingLeadRec.Borrowers_Mobile_Phone__c != null && AccountRec.PersonMobilePhone == IncommingLeadRec.Borrowers_Mobile_Phone__c) || (IncommingLeadRec.Borrowers_Work_Phone__c != null && AccountRec.Work_Phone__c == IncommingLeadRec.Borrowers_Work_Phone__c) ))
                {
                     
                      return AccountRec;
                      
                    
                }
            
            
        }
        return null;
        
    }
    
    Private Account FindCoBorrowerAccount(Lead IncommingLeadRec )
    {
        For (Account AccountRec: AccountsCreationList)
        {
                if(AccountRec.firstname == IncommingLeadRec.Co_Borrowers_First_Name__c && AccountRec.lastname == IncommingLeadRec.Co_Borrowers_Last_Name__c && ((AccountRec.PersonEmail == IncommingLeadRec.Co_Borrowers_Email__c && IncommingLeadRec.Co_Borrowers_Email__c !=null) || (IncommingLeadRec.Co_Borrowers_Home_Phone__c != null && AccountRec.PersonHomePhone == IncommingLeadRec.Co_Borrowers_Home_Phone__c) || (AccountRec.PersonMobilePhone == IncommingLeadRec.Co_Borrowers_Mobile_Phone__c && IncommingLeadRec.Co_Borrowers_Mobile_Phone__c != null) || (AccountRec.Work_Phone__c == IncommingLeadRec.Co_Borrowers_Work_Phone__c && IncommingLeadRec.Co_Borrowers_Work_Phone__c != null) ))
                {
                     
                      return AccountRec;
                      
                    
                }
            
            
        }
        return null;
        
    }
}