@IsTest
Public Class CO_LeadTrgg_TestClass{
    
    Static TestMethod Void Leadmastertrgg_Method1(){
           
           //Changes made by Vimal for the story B-653680 starts here
            Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
       
            User u = new User(alias = 'testuser', email='testuser@abc.com',
                               emailencodingkey='UTF-8', lastname='test',firstname='user',
                               languagelocalekey='en_US',
                               localesidkey='en_US', profileid = p.Id, 
                               timezonesidkey='America/Los_Angeles',
                               username='testuser@abc.com',isactive=true);    
                               
           insert u;  
           //User u = [select user.id from user where user.profile.name like 'System Administrator' and isactive = true limit 1];
           //Group q =[Select Id,name,type from group where type='Queue' and name like 'campaigns' limit 1 ];
           
          // id leadid = q.id; 
          
          //Changes made by Vimal for the story B-653680 Ends here
 System.runAs(u) {
         // The following code runs as user 'u' 
         System.debug('Current User: ' + UserInfo.getUserName());
         System.debug('Current Profile: ' + UserInfo.getProfileId()); 
                  }
        Lead new_ld = new Lead();
        new_ld.Status='New - Not Opened';
        new_ld.firstname='AK';
        new_ld.ownerid= u.id;
        new_ld.Lastname='Rathore';
        new_ld.Applicant_Type__c='Married Couple';
        new_ld.Channel__c='Home Equity';
        new_ld.Channel_Sources__c='Third Parties';
        new_ld.Channel_Values__c='Realtors';
        new_ld.Borrowers_Country__c='Hong Kong';
        new_ld.Borrowers_State__c='Tx';
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
        new_ld.Empower_Lead_ID__c='abcd167';
        new_ld.Phone='(033) 246-3970';
        new_ld.Borrowers_Apt__c='Testa';
        new_ld.VFUpdate__c = 'No';
        new_ld.Copy_Borrower_Current_Address_to_Subject__c = true;
        new_ld.Is_Sofi_Lead__c = false;
        new_ld.My_Lead__c = false ; 
        new_ld.My_Lead_to_Sofi__c = true;
        new_ld.Pre_HLR_Status__c = 'No Attempt';
        insert new_ld; 
               
        Lead updatelead2 = new Lead(id=new_ld.id,Transfer_to_HLR__c = true);
        update updatelead2;  
      
              
    }
    Static TestMethod Void EmailTrackingtrgg_Method1(){
        Lead new_ld = new Lead();
        new_ld.Status='Active Attempt 1';
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
        new_ld.Empower_Lead_ID__c='abcd167';
        new_ld.Phone='(033) 246-3970';
        new_ld.Borrowers_Apt__c='Testa';
        new_ld.Loan_Purpose__c='Purchase';        
        insert new_ld; 
        
        Lead new_ld11 = new Lead();
        new_ld11.Status='New';        
        new_ld11.FirstName='ROSY';
        new_ld11.LastName='DANIAL'; 
        new_ld11.Company='XXXX';    
        new_ld11.Borrowers_Home_Phone__c='(033) 246-3970';
        new_ld11.Property_State__c='CA';
        //new_ld.Loan_Purpose__c='Purchase';
        new_ld.Email='ak1@qgmail.com';
        insert new_ld11;
        
       
        //Changes made by Vimal for the story B-653680 starts here
            Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
       
            User u = new User(alias = 'testuser', email='testuser@abc.com',
                               emailencodingkey='UTF-8', lastname='test',firstname='user',
                               languagelocalekey='en_US',
                               localesidkey='en_US', profileid = p.Id, 
                               timezonesidkey='America/Los_Angeles',
                               username='testuser@abc.com',isactive=true); 
            insert u;
            System.runAs(u) {   
            	System.debug('Current User: ' + UserInfo.getUserName());
       			System.debug('Current Profile: ' + UserInfo.getProfileId()); 
            }            
           //Changes made by Vimal for the story B-653680 Ends here    
        Recordtype R1 = [select id from recordtype where name = 'Business Account' AND SobjectType = 'Account'];   
        Account A = new Account( name = 'Test Account',Ownerid = u.id,recordtypeid=r1.id); 
        insert A;
            
        Opportunity O = new Opportunity();
O.name = 'ABC';
O.CloseDate = date.today();
O.StageName = 'Prospecting';
O.Annual_Homeowner_s_Association_Dues__c = 5555;
O.Annual_Homeowner_s_Insurance__c = 5555;
O.Annual_Real_Estate_Taxes__c = 4444;
O.Applicant_Type__c = 'Individual';
O.Channel__c = 'Centralized Retail';
O.Channel_Sources__c = 'Bank';
O.Channel_Values__c = 'RB Portal';
O.Value_of_Home__c = 23424;
O.Requested_Loan_Amount__c = 42424;
O.Loan_Purpose__c = 'Purchase';
O.Property_Address_1__c = 'ABC';
O.Property_Address_2__c = 'ABC';
O.Property_Apt__c = '22222';
O.Property_City__c = 'India';
O.Property_Country__c = 'India';
O.Property_County__c = 'India';
O.Property_House__c = 'India';
O.Property_State__c = 'TX';
O.Property_Type__c = '2 Unit';
O.Property_Zip_Postal_Code__c = '11111';
O.Empower_Lead_ID__c = '455461';
O.Related_Lead__c = new_ld11.id;
O.Shopping_Stage__c = 'Immediately';
O.AccountID = a.id;
insert O;
        new_ld11.Account_Name__c = a.id;
        new_ld11.Related_Opportunity__c = o.id;
        update  new_ld11;
        
        Lead upLead=new lead(id=new_ld11.id,status='Active');
        update uplead;
        
               
       
    }
    Static TestMethod Void SendEmailtoMgr_Method1(){
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        User u,u1,u2;
        List<user> lu = new List<user>();
        u2 = new User(alias = 'jsmtih1', email='jsmith@acme1.com',
                               emailencodingkey='UTF-8', lastname='Smith1',firstname='John1',
                               languagelocalekey='en_US',
                               localesidkey='en_US', profileid = p.Id, 
                               timezonesidkey='America/Los_Angeles',
                               username='jsmith@acme11.com',isactive=true);
                          lu.add(u2);
        u = new User(alias = 'jsmtih', email='jsmith@acme.com',
                               emailencodingkey='UTF-8', lastname='Smith',firstname='John',
                               languagelocalekey='en_US',
                               localesidkey='en_US', profileid = p.Id, 
                               timezonesidkey='America/Los_Angeles',
                               username='jsmith@acme.com.1',isactive=true,managerid=u2.id);
                          lu.add(u);
                          u1 = new User(alias = 'williams', email='rwilliams@acme.com',
                                   emailencodingkey='UTF-8', lastname='johnes',firstname='John',
                                   languagelocalekey='en_US',
                                   localesidkey='en_US', profileid = p.Id,
                                   timezonesidkey='America/Los_Angeles',
                                   username='rwilliams@acme.1.com',isactive=true);

                          lu.add(u1);
        insert lu;
        List<Lead> listLeads=new list<Lead>();
        system.runas(u){      
        Lead new_ld1 = new Lead();
        new_ld1.Status='New';
        new_ld1.Applicant_Type__c='individual';
        new_ld1.Channel__c='Home Equity';
        new_ld1.Channel_Sources__c='Bank';
        new_ld1.Channel_Values__c='NCFR';
        new_ld1.FirstName='ROSY';
        new_ld1.LastName='DANIAL';
        new_ld1.Borrowers_Country__c='Hong Kong';
        new_ld1.Borrowers_County__c='Maldives';
        new_ld1.Borrowers_City__c='Netherlands';
        new_ld1.Borrowers_Address_1__c='A-12 Lonley Road';
        new_ld1.Time_Zone__c='EST';
        new_ld1.Borrowers_Address_2__c='Chinna Swami Road';   
        new_ld1.Borrowers_Current_Residence__c='Own';
        new_ld1.Company='XXXX';
        new_ld1.BorrowersHouse__c='wfvhf';
        new_ld1.Loan_Approved__c=True;
        new_ld1.Borrowers_State__c='DX';
        new_ld1.Borrowers_Zip_Postal_Code__c='32412';
        new_ld1.Borrowers_Home_Phone__c='(033) 246-3970';
        new_ld1.Borrowers_Mobile_Phone__c='(033) 246-1230';
        new_ld1.Occupancy_Code__c='Second Home';
        new_ld1.Notes__c='Tomorrow is Saturday';
        new_ld1.Property_State__c='CA';
        new_ld1.Email='ak@gmail.com';
        new_ld1.Phone='(033) 246-3970';
        new_ld1.Borrowers_Apt__c='Test';        
        new_ld1.BorrowersHouse__c='ttthhh';
        new_ld1.Borrowers_State__c='ss';
        insert new_ld1;
        }
         Lead new_ld11 = new Lead();
        new_ld11.Status='New';        
        new_ld11.FirstName='ROSY';
        new_ld11.LastName='DANIAL'; 
        new_ld11.Company='XXXX';    
        new_ld11.Borrowers_Home_Phone__c='(033) 246-3970';
        new_ld11.Property_State__c='CA';
        listLeads.add(new_ld11);
        
        Lead new_ld1111 = new Lead();
        new_ld1111.Status='New';        
        new_ld1111.FirstName='ROSY1';
        new_ld1111.LastName='DANIAL1'; 
        new_ld1111.Company='XXXX';    
        new_ld1111.Borrowers_Home_Phone__c='(033) 246-3970';
        new_ld1111.Email='ak@gmail.com';
        new_ld1111.Property_State__c='CA';
        listLeads.add(new_ld1111);
        
        Lead new_ld111 = new Lead();
        new_ld111.Status='New';        
        new_ld111.FirstName='ROSY';
        new_ld111.LastName='DANIAL'; 
        new_ld111.Company='XXXX';    
        new_ld111.Borrowers_Home_Phone__c='(033) 246-3951';
        new_ld111.Property_State__c='CA';
        new_ld111.Borrowers_Country__c='Hong Kong';
        new_ld111.Borrowers_County__c='Maldives';
        new_ld111.Borrowers_City__c='Netherlands';
        new_ld111.Borrowers_Address_1__c='A-12 Lonley Road';
        new_ld111.Borrowers_Address_2__c='Chinna Swami Road';
        new_ld111.Borrowers_Zip_Postal_Code__c='32412';
        new_ld111.Borrowers_Apt__c='Test';
        new_ld111.BorrowersHouse__c='ttthhh';
        new_ld111.Borrowers_State__c='ss';
        listLeads.add(new_ld111);
        
         Lead new_ld112 = new Lead();
        new_ld112.Status='New';        
        new_ld112.FirstName='ROSY';
        new_ld112.LastName='DANIAL';
        new_ld112.Email='ak@gmail.com'; 
        new_ld112.Company='XXXX';    
        new_ld112.Borrowers_Home_Phone__c='(033) 246-3954';
        new_ld112.Property_State__c='CA';
        listLeads.add(new_ld112);
        
        Lead new_ld7 = new Lead();
        new_ld7.Status='New';        
        new_ld7.FirstName='ROSY1';
        new_ld7.LastName='DANIAL1'; 
        new_ld7.Company='XXXX';    
        new_ld7.Email='ak@gmail.com';
        new_ld7.Property_State__c='CA';
       // new_ld7.Borrowers_Home_Phone__c='(033) 246-3970';
        new_ld7.Borrowers_Country__c='Hong Kong';
        new_ld7.Borrowers_County__c='Maldives';
        new_ld7.Borrowers_City__c='Netherlands';
        new_ld7.Borrowers_Address_1__c='A-12 Lonley Road';
        new_ld7.Borrowers_Address_2__c='Chinna Swami Road';
        new_ld7.Borrowers_Zip_Postal_Code__c='32412';
        new_ld7.Borrowers_Apt__c='Test';
        new_ld7.BorrowersHouse__c='ttthhh';
        new_ld7.Borrowers_State__c='ss';
        listLeads.add(new_ld7);
                        
        insert listLeads;
    }
    Static TestMethod Void roundRobin_Method1(){
        List<user> lu = new List<user>();
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
          User thisUser = [SELECT Name,firstname,lastname,Id FROM User WHERE Id = :UserInfo.getUserId()];
          user u = new User(alias = 'jsmtih', email='jsmith@acme11.com',
        emailencodingkey='UTF-8', lastname='Smith',firstname='John',
        languagelocalekey='en_US',
        localesidkey='en_US', profileid = p.Id,
        timezonesidkey='America/Los_Angeles',
        username='jsmith@acme134.com',isactive=true);
        lu.add(u);
         user u1 = new User(alias = 'williams', email='rwilliams@acme.com',
        emailencodingkey='UTF-8', lastname='johnes',firstname='John',
        languagelocalekey='en_US',
        localesidkey='en_US', profileid = p.Id,
        timezonesidkey='America/Los_Angeles',
        username='rwilliams14556@acme.com',isactive=true);
        
        lu.add(u1);
        insert lu;
        System.runAs (u) {
        group grp= new group(Name='TestQ',Type='Queue');
        insert grp;
        QueueSobject mappingObject = new QueueSobject(QueueId =grp.id , SobjectType = 'Lead');
        insert mappingObject; 
        Groupmember Grpmember = new groupmember(GroupId=grp.id,UserOrGroupId=userinfo.getuserid());
        insert Grpmember;
        
       // Queue__c Q= new Queue__c(name='TestQ');
       // insert Q;
    //    Queue_members__c Qm = new Queue_members__c(Queue__c=Q.id,name=u1.firstname+' '+u1.lastname,user__c=u1.id);
    //    insert Qm;
      // Lead_limit__c l= new Lead_Limit__c(name=u1.firstname+' '+u1.lastname,user__c=u1.id);
       //insert l;
        
        Lead new_ld = new Lead();
        new_ld.Status='Active';
        new_ld.ownerid=u.id;
        new_ld.Applicant_Type__c='Married Couple';
        new_ld.Channel__c='Home Equity';
        new_ld.Channel_Sources__c='Third Parties';
        new_ld.Channel_Values__c='Realtors';
        new_ld.FirstName='A';
        new_ld.DNC__c = false;
        new_ld.LastName='Lewis Carol';
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
        new_ld.Empower_Lead_ID__c='abcd167';
        new_ld.Phone='(033) 246-3970';
        new_ld.Borrowers_Apt__c='Testa';        
       // new_ld.updateRRowner__c = true;
        new_ld.MSA_Holding_Assignment_Date__c =system.today()-1;
        insert new_ld;
        
        Lead ul=new Lead(id=new_ld.id,ownerid=grp.id,updateRRowner__c = true);
        update ul;
        }
    }
    
}