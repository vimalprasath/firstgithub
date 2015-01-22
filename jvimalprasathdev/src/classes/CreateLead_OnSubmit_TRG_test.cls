@istest

  Class CreateLead_OnSubmit_TRG_test
{
  Static testmethod void CreateLead_OnSubmit_Test()
      {
     //Changes made by Vimal for the story B-653680 starts here
     Profile p= [ Select id from Profile where name = 'System Administrator'];  
     User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];//Added by vimal
    System.runAs(thisuser){  
    UserRole r= new UserRole(name='System Administrator',CaseAccessForAccountOwner='Edit', OpportunityAccessForAccountOwner='Edit');
    insert r;
     
     User u2 = new User( email='test-user1@fakeemail.com',  profileid = p.id, userroleid=r.id,UserName='test-use1r@fakeemail.com',
      alias='tuser2', CommunityNickName='tuser3',TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='ISO-8859-1',
      LanguageLocaleKey='en_US', FirstName = 'Test1', LastName = 'User1',isactive=true );
     insert u2;
    //   User u2=[select id from user where userroleid != Null and isactive = true limit 1];
      
       Region__c reg = new Region__c(Name='Test Region');
    insert reg;
     Region__c reg1 = new Region__c(Name='Test Region1');
    insert reg1;
    
    District__c des = new District__c(name='Test district',Region__c=reg.id);
    insert des;
    District__c des1 = new District__c(name='Test district1',Region__c=reg.id);
    insert des1;
    District__c des2 = new District__c(name='Test district2',Region__c=reg.id);
    insert des2;
    District__c des3 = new District__c(name='Test district3',Region__c=reg.id);
    insert des3;
    
    Branch__c bran = new Branch__c(name='Test branch',District__c=des.id,Branch_Number__c='1010');
    insert bran;
     Branch__c bran1 = new Branch__c(name='Test branch1',District__c=des.id,Branch_Number__c='1000');
    insert bran1;
     Branch__c bran2 = new Branch__c(name='Test branch2',District__c=des1.id,Branch_Number__c='1001');
    insert bran2;
     Branch__c bran3 = new Branch__c(name='Test branch3',District__c=des1.id,Branch_Number__c='1002');
    insert bran3;
    Branch__c bran4 = new Branch__c(name='Test branch4',District__c=des2.id,Branch_Number__c='1003');
    insert bran4;
    
     Recordtype R1 = [select id from recordtype where name = 'Business Account' AND SobjectType = 'Account'];   
     Account A1 = new Account( name = 'Test Account',Ownerid = u2.id,recordtypeid=r1.id); 
     insert A1;
    
    List<Contact> ContactList = new List<Contact>(); 
    
    Contact C2 = new Contact( AccountID = A1.id, FirstName = 'TestMohana', LastName = 'UserMohana',email = 'test@test.com' ); 
    insert C2;
    
  
    ID ProfileID = [ Select id from Profile where name = 'Authenticated Portal Website'].id;
   
     User user2 = new User( email='test1@test.com', contactid = c2.id, profileid = ProfileID, UserName='test1@test.com', alias='tuser2', CommunityNickName='tuser2',TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='ISO-8859-1',LanguageLocaleKey='en_US', FirstName = 'MohanaTest', LastName = 'User' ); 
    insert user2; 

  //    system.runas(user2) {
       list<Customer_Portal_Lead__c> CPLeadList = new list<Customer_Portal_Lead__c>();
      
       Customer_Portal_Lead__c CPLead = new Customer_Portal_Lead__c();
       CPLead.First_Name__c= 'Test name';
       CPLead.Last_Name__c = 'Test name1';
       CPLead.Preferred_Contact_Method__c = 'Home Phone';
       CPLead.Borrowers_Home_Phone__c = '(111) 222-3333';
        CPLead.property_located__c = 'TX';
        CPLead.property_state__c = 'TX';
        CPLead.Create_Lead__c = true;
        CPLeadList.add(cplead);
        
       Customer_Portal_Lead__c CPLead1 = new Customer_Portal_Lead__c();
       CPLead1.First_Name__c= 'Test name';
       CPLead1.Last_Name__c = 'Test name1';
       CPLead1.Preferred_Contact_Method__c = 'Home Phone';
       CPLead1.Borrowers_Home_Phone__c = '(111) 222-3333';
       CPLead1.Loan_Purpose__c = 'Refinance';
       CPLead1.Property_Use__c = 'Primary';
       CPLead1.Property_Type__c = 'Hi-Rise Condominium';
       CPLead1.Preferred_Contact_Method__c = 'Mobile Phone';
        CPLead1.property_located__c = 'TX';
        CPLead1.property_state__c = 'TX';
        CPLead1.Create_Lead__c = true;
        CPLeadList.add(cplead1);
        
       Customer_Portal_Lead__c CPLead2 = new Customer_Portal_Lead__c();
       CPLead2.First_Name__c= 'Test name';
       CPLead2.Last_Name__c = 'Test name1';
       CPLead2.Preferred_Contact_Method__c = 'Home Phone';
       CPLead2.Borrowers_Home_Phone__c = '(111) 222-3333';
       CPLead2.Loan_Purpose__c = 'Refinance';
       CPLead2.Property_Use__c = 'Vacation or Second Home';
       CPLead2.Property_Type__c = 'Single-Family Home Attached';
       CPLead2.Preferred_Contact_Method__c = 'Work Phone';
        CPLead2.property_located__c = 'TX';
        CPLead2.property_state__c = 'TX';
        CPLead2.Create_Lead__c = true;
        CPLeadList.add(cplead2);
        
       Customer_Portal_Lead__c CPLead3 = new Customer_Portal_Lead__c();
       CPLead3.First_Name__c= 'Test name';
       CPLead3.Last_Name__c = 'Test name1';
       CPLead3.Preferred_Contact_Method__c = 'Home Phone';
       CPLead3.Borrowers_Home_Phone__c = '(111) 222-3333';
       CPLead3.Loan_Purpose__c = 'Refinance';
       CPLead3.Property_Use__c = 'Vacation or Second Home';
       CPLead3.Property_Type__c = 'Single-Family Home Detached';
       CPLead3.Preferred_Contact_Method__c = 'Work Phone';
        CPLead3.property_located__c = 'TX';
        CPLead3.property_state__c = 'TX';
        CPLead3.Create_Lead__c = true;
        CPLeadList.add(cplead3);
        
        Customer_Portal_Lead__c CPLead4 = new Customer_Portal_Lead__c();
       CPLead4.First_Name__c= 'Test name';
       CPLead4.Last_Name__c = 'Test name1';
       CPLead4.Preferred_Contact_Method__c = 'Home Phone';
       CPLead4.Borrowers_Home_Phone__c = '(111) 222-3333';
       CPLead4.Loan_Purpose__c = 'Refinance';
       CPLead4.Property_Use__c = 'Vacation or Second Home';
       CPLead4.Property_Type__c = 'Low-Rise Condominium';
       CPLead4.Preferred_Contact_Method__c = 'Work Phone';
        CPLead4.property_located__c = 'TX';
        CPLead4.property_state__c = 'TX';
        CPLead4.Create_Lead__c = true;
        CPLeadList.add(cplead4);
        
        insert CPLeadList;
       } 
        



      }




}