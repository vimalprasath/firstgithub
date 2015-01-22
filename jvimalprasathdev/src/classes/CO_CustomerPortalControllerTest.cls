@istest
public class CO_CustomerPortalControllerTest { 

    Static Testmethod Void TestCO_CustomerPortalController(){

    Profile p= [ Select id from Profile where name = 'Marketing User'];  
    //Changes made by Vimal for the story B-653680 starts here
    User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];//Added by vimal
    System.runAs(thisuser){  
    UserRole r= new UserRole(name='System Administrator',CaseAccessForAccountOwner='Edit', OpportunityAccessForAccountOwner='Edit');
    insert r;
       
    //userrole  r=[select id from userrole where name='System Administrator'];   
    // User u2=[select id from user where userroleid != Null and isactive = true limit 1];
     User u2 = new User( email='test-user1@fakeemail.com',  profileid = p.id, userroleid=r.id,UserName='test-use1r@fakeemail.com', alias='tuser2', CommunityNickName='tuser3',TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='ISO-8859-1',LanguageLocaleKey='en_US', FirstName = 'Test1', LastName = 'User1',isactive=true );
     insert u2; 
    //Changes made by Vimal for the story B-653680 Ends here
    
    Region__c reg = new Region__c(Name='Test Region');
    insert reg;
    //By Mohana
     Region__c reg1 = new Region__c(Name='Test Region1');
    insert reg1;
    
    District__c des = new District__c(name='Test district',Region__c=reg.id);
    insert des;
    //by Mohana
    District__c des1 = new District__c(name='Test district1',Region__c=reg.id);
    insert des1;
    District__c des2 = new District__c(name='Test district2',Region__c=reg.id);
    insert des2;
    District__c des3 = new District__c(name='Test district3',Region__c=reg.id);
    insert des3;
    
    Branch__c bran = new Branch__c(name='Test branch',District__c=des.id,Branch_Number__c='1010');
    insert bran;
    //By Mohana
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
    Contact C1 = new Contact( Branch__c=bran.id,AccountID = A1.id, FirstName = 'Test', LastName = 'User',email = 'test-user@fakeemail.com' ); 
    insert C1;
    // by Mohana
    Contact C2 = new Contact( AccountID = A1.id, FirstName = 'TestMohana', LastName = 'UserMohana',email = 'test@test.com' ); 
    insert C2;
    
  
    ID ProfileID = [ Select id from Profile where name = 'Authenticated Portal Website'].id;
    User u1 = new User( email='test-user@fakeemail.com', contactid = c1.id, profileid = ProfileID, UserName='test-user@fakeemail.com', alias='tuser1', CommunityNickName='tuser1',TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='ISO-8859-1',LanguageLocaleKey='en_US', FirstName = 'Test', LastName = 'User' ); 
    insert u1; 
    //by Mohana
     User user2 = new User( email='test1@test.com', contactid = c2.id, profileid = ProfileID, UserName='test1@test.com', alias='tuser2', CommunityNickName='tuser2',TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='ISO-8859-1',LanguageLocaleKey='en_US', FirstName = 'MohanaTest', LastName = 'User' ); 
    insert user2; 
     /*User user3 = new User( email='test2@test.com', profileid = ProfileID, UserName='test2@test.com', alias='tuser3', CommunityNickName='tuser3',TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='ISO-8859-1',LanguageLocaleKey='en_US', FirstName = 'MohanaTest1', LastName = 'User1' ); 
    insert user3; */
    
   //By Mohana
   
   //user user2 = [select id,contactid from user where profile.name = 'Authenticated Portal Website' limit 1];
 //   System.runAs (user2 ){  
    
User portaluser2 = [Select id,contactId,Name  from user where id =:UserInfo.getUserId()]; 

        Customer_Portal_Lead__c CPLeadtest = new Customer_Portal_Lead__c();
        
        ApexPages.StandardController sc = new ApexPages.standardController(CPLeadtest);
        CO_CustomerPortalController Cntlr = new CO_CustomerPortalController(sc);
           Cntlr.CPLead = CPLeadtest;
           Cntlr.submit();
        
        CPLeadtest.property_located__c = 'TX';
        CPLeadtest.property_state__c = 'NA';
        CPLeadtest.First_Name__c = 'Test Name';
        CPLeadtest.Last_Name__c ='test Last';
        CPLeadtest.Daytime_Phone__c = '(999) 456-1234';
        CPLeadtest.Borrowers_Home_Phone__c = '(111) 222-3333';
        //by Mohana for Zip code
        CPLeadtest.Borrowers_Zip_Postal_Code__c = '12345';
        CPLeadtest.Marrital_Status__c = 'new'; 
        CPLeadtest.Applicant_Type__c = 'new';
        CPLeadtest.Borrowers_Address_1__c = 'test'; 
        CPLeadtest.Borrower_State_2__c = 'TX';
        CPLeadtest.Preferred_Contact_Method__c = 'test';
        CPLeadtest.Time_Zone__c = 'test';
        CPLeadtest.Best_Contact_Time__c = 'test';
        CPLeadtest.How_did_you_hear_about_us__c = 'test';
        CPLeadtest.Loan_Purpose__c = 'test';
        CPLeadtest.Total_amount_finance_needed__c = 123;
        CPLeadtest.Property_Use__c = 'test';
        CPLeadtest.Property_Type__c = 'test';
        //insert CPLeadtest;
               
                
        ApexPages.StandardController sc1 = new ApexPages.standardController(CPLeadtest);
        CO_CustomerPortalController Cntlr1 = new CO_CustomerPortalController(sc1);
           Cntlr1.CPLead = CPLeadtest;
           Cntlr1.submit();
           
           CPLeadtest.Borrowers_Zip_Postal_Code__c = '123';
           CPLeadtest.property_state__c = 'TX';
           ApexPages.StandardController sc2 = new ApexPages.standardController(CPLeadtest);
          CO_CustomerPortalController Cntlr2 = new CO_CustomerPortalController(sc2);
           Cntlr2.CPLead = CPLeadtest;
           Cntlr2.submit();
           
           CPLeadtest.Borrowers_Zip_Postal_Code__c = '12345';
           ApexPages.StandardController sc3 = new ApexPages.standardController(CPLeadtest);
           CO_CustomerPortalController Cntlr3 = new CO_CustomerPortalController(sc3);
           Cntlr3.CPLead = CPLeadtest;
           Cntlr3.submit();
         
           Cntlr3.onload() ;
           Cntlr3.Previous();
           Cntlr3.Close();
           
        //insert CPLeadtest;
        PageReference pageRef = Page.CO_Referral_VF;
        Test.setCurrentPage(pageRef);
       // pageRef.getParameters().put('id',CPLeadtest.id);
        pageRef.getParameters().put('branch','Test branch');
        pageRef.getParameters().put('district','-- Choose A District --');
        
        ApexPages.StandardController sc4 = new ApexPages.standardController(CPLeadtest);
           CO_CustomerPortalController Cntlr4 = new CO_CustomerPortalController(sc4);
           Cntlr4.CPLead = CPLeadtest;
           Cntlr4.submit();
        
       
        PageReference pageRef1 = Page.CO_Referral_VF;
        Test.setCurrentPage(pageRef1);
        pageRef1.getParameters().put('id',CPLeadtest.id);
        ApexPages.StandardController sc5 = new ApexPages.standardController(CPLeadtest);
        CO_CustomerPortalController Cntlr5 = new CO_CustomerPortalController(sc5);
             

}

        
   /* System.runAs (u1 ){  
    
User portaluser = [Select id,contactId,Name  from user where id =:UserInfo.getUserId()];    
             System.debug('*****Portal User Selected*****'+portaluser.Name); 
             System.debug('*****Portal User contactId*****'+portaluser.contactId);   
Contact TCon = [Select id,Branch_Region__c,Branch__c,Branch_Name__c,Branch_District__c,RelationShip_Banker_EID__c from contact where Id =:portaluser.contactId];

 /*District__c dist = [Select id,Name from District__c where Name =:TCon.Branch_District__c];
dist.Name =  '-- Choose A District --'; */
 
       /* Customer_Portal_Lead__c CPLead = new Customer_Portal_Lead__c();
        // missing:Borrowers_Address_2__c,Borrowers_City__c,Preferred_Contact_Method__c,Time_Zone__c,Best_Contact_Time__c,
        //How_did_you_hear_about_us__c,Loan_Purpose__c,Total_amount_finance_needed__c,Property_Use__c,Property_Type__c
        //Approximate_value_of_your_property__c,
        CPLead.property_located__c = 'TX'; //Not needed By Mohana
        
        CPLead.First_Name__c = 'Test Name';
        CPLead.Last_Name__c ='test Last';
        CPLead.Borrowers_Home_Phone__c = '(111) 222-3333';
        CPLead.Daytime_Phone__c = '(999) 456-1234';
        CPLead.Marrital_Status__c = 'new'; 
        CPLead.Applicant_Type__c = 'new';
        CPLead.Borrowers_Address_1__c = 'test'; 
        CPLead.Borrower_State_2__c = 'TX';        
        //byMohana
        CPLead.Borrowers_Zip_Postal_Code__c = '';
        //byMohana
        CPLead.property_state__c = 'A';
        
       
        // Cplead.createddate.format();
        insert cplead;
        system.debug('<<<<<<<<Sucessful insert>>>>>>>>'+cplead.id);

         Lead TestLead = new Lead();
         testlead.status = 'New';
         testlead.firstname = 'testfirst';
         testlead.lastname = 'testlast';
         testlead.Company = 'Test';
         testlead.Empower_Lead_ID__c = 'E1234';
         testlead.Property_State__c = 'TX';
         testlead.Borrowers_Mobile_Phone__c = '(111) 222-3333';
         testlead.Borrowers_Home_Phone__c = '(222) 222-3333';
         testlead.Customer_Portal_Lead__c = cplead.id;
         insert testlead;
        
        
        PageReference pageRef = Page.CO_Referral_VF;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('id',CPlead.id);
        ApexPages.StandardController sc = new ApexPages.standardController(cplead);
        CO_CustomerPortalController Cntlr = new CO_CustomerPortalController(sc);
        CO_CustomerPortalController.LeadWrappermethod wrap = new CO_CustomerPortalController.LeadWrappermethod(CPLead,testlead);
         String paramSelectedBr= System.currentPagereference().getParameters().get('branch');
         String paramSelectedDist= System.currentPagereference().getParameters().get('district'); 
           Cntlr.CustomerAssessment();
           Cntlr.getBranches();
           Cntlr.saveBranches();     
           Cntlr.CPLead=CPlead; 
           Cntlr.OnCancel();
           Cntlr.AssessmentComplete();
           Cntlr.submit();
           Cntlr.GoSearch();
           Cntlr.onload() ;
           Cntlr.getLeadWrappermtd();
           Cntlr.Previous();
           Cntlr.Close();
           Cntlr.nextPage();
           Cntlr.refresh();
           Cntlr.getPortalLeads();
            PageReference pageRef1= new PageReference('/apex/CO_successfullysubmitted_VF?id='+CPLead.id);
                 pageRef1.getParameters().put('branch',paramSelectedBr);
                 pageRef1.getParameters().put('district',paramSelectedDist);
       
        PageReference pageRefer = Page.CO_RBPipeline_VF;
        Test.setCurrentPage(pageRefer);
        //pageRef.getParameters().put('id',CPlead.id);
        
        ApexPages.StandardController sclr = new ApexPages.standardController(cplead);
        CO_CustomerPortalController Cntlr1 = new CO_CustomerPortalController(sclr);
        //Cntlr1.TListleadwrappermethod = Cntlr1.getLeadWrappermtd();
        Cntlr1.Borrower_Name = 'john';
        Cntlr1.GoSearch();
        Cntlr1.Borrower_PropertyAdd = 'Address';
        Cntlr1.GoSearch();
        Cntlr1.Borrower_Email = 'test@test.com';
        Cntlr1.GoSearch();
        Cntlr1.Borrower_LoanNo = 'PL-123445';
        Cntlr1.GoSearch();
        Cntlr1.Borrower_Phone = '(111) 222-3333';
        Cntlr1.GoSearch();     
        
     

        //CO_CustomerPortalController.LeadWrappermethod wrapper = new CO_CustomerPortalController.LeadWrappermethod(cplead,TestLead);
         
         }
         }

    Static Testmethod Void TestCO_CustomerPortalController1(){

    Profile p= [ Select id from Profile where name = 'Marketing User'];
  
    userrole  r=[select id from userrole where name='System Administrator'];
   
    User u2=[select id from user where userroleid != Null and isactive = true limit 1];
    
    Region__c reg = new Region__c(Name='Test Region');
    insert reg;
    
    District__c des = new District__c(name='Test district',Region__c=reg.id);
    insert des;
    
    Branch__c bran = new Branch__c(name='Test branch',District__c=des.id,Branch_Number__c='1010',Cost_Center__c = 123);
    insert bran;
    
    Account A1 = new Account(Name = 'Test Account',Ownerid = u2.id); 
    insert A1;
    
    List<Contact> ContactList = new List<Contact>(); 
    Contact C1 = new Contact( Branch__c=bran.id,AccountID = A1.id, FirstName = 'Test', LastName = 'User',email = 'test-user@fakeemail.com' ); 
    insert C1;

  
    ID ProfileID = [ Select id from Profile where name = 'Authenticated Portal Website'].id;
    User u11 = new User( email='test-user@fakeemail.com', contactid = c1.id, profileid = ProfileID, UserName='test-user@fakeemail.com', alias='tuser1', CommunityNickName='tuser1',TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='ISO-8859-1',LanguageLocaleKey='en_US', FirstName = 'Test', LastName = 'User' ); 
    insert u11; 
        
    System.runAs (u11 ){
             User portaluser = [Select id,contactId,Name  from user where id =:UserInfo.getUserId()];    
             System.debug('*****Portal User Selected*****'+portaluser.Name); 
             System.debug('*****Portal User contactId*****'+portaluser.contactId);            
        Customer_Portal_Lead__c CPLeadtest = new Customer_Portal_Lead__c();
        CPLeadtest.property_located__c = 'TX';
        CPLeadtest.property_state__c = 'TX';
        CPLeadtest.First_Name__c = 'Test Name';
        CPLeadtest.Last_Name__c ='test Last';
        CPLeadtest.Daytime_Phone__c = '(999) 456-1234';
        CPLeadtest.Borrowers_Home_Phone__c = '(111) 222-3333';
        CPLeadtest.Borrowers_Zip_Postal_Code__c = '12344';
        CPLeadtest.Marrital_Status__c = 'new'; 
        CPLeadtest.Applicant_Type__c = 'new';
        CPLeadtest.Borrowers_Address_1__c = 'test'; 
        CPLeadtest.Borrower_State_2__c = 'TX';
        CPLeadtest.Preferred_Contact_Method__c = 'test';
        CPLeadtest.Time_Zone__c = 'test';
        CPLeadtest.Best_Contact_Time__c = 'test';
        CPLeadtest.How_did_you_hear_about_us__c = 'test';
        CPLeadtest.Loan_Purpose__c = 'test';
        CPLeadtest.Total_amount_finance_needed__c = 123;
        CPLeadtest.Property_Use__c = 'test';
        CPLeadtest.Property_Type__c = 'test';
        insert CPLeadtest;
               
         Lead TestLead = new Lead();
         testlead.status = 'new';
         testlead.firstname = 'testfirst';
         testlead.lastname = 'testlast';
         testlead.Company = 'Test';
         testlead.Empower_Lead_ID__c = '';
         testlead.Property_State__c = 'TX';
         testlead.Borrowers_Mobile_Phone__c = '(111) 222-3333';
         testlead.Borrowers_Home_Phone__c = '(222) 222-3333';
         testlead.Customer_Portal_Lead__c = cpleadtest.id;
         insert testlead;
         
                
        PageReference pageRef = Page.CO_Referral_VF;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('id',CPLeadtest.id);
        pageRef.getParameters().put('branch','Test branch');
        pageRef.getParameters().put('district','-- Choose A District --');
        ApexPages.StandardController sc = new ApexPages.standardController(CPLeadtest);
        CO_CustomerPortalController Cntlr = new CO_CustomerPortalController(sc);
        CO_CustomerPortalController.LeadWrappermethod wrap = new CO_CustomerPortalController.LeadWrappermethod(CPLeadtest,testlead);
           Cntlr.CustomerAssessment();
           Cntlr.getBranches();
           Cntlr.saveBranches();     
           Cntlr.CPLead=CPleadtest; 
           Cntlr.OnCancel();
           Cntlr.AssessmentComplete();
           Cntlr.submit();
           Cntlr.GoSearch();
           Cntlr.onload() ;
           Cntlr.getLeadWrappermtd();
           Cntlr.Previous();
           Cntlr.Close();
           Cntlr.nextPage();
           Cntlr.refresh();
           Cntlr.getPortalLeads();

        PageReference pageRefer = Page.CO_RBPipeline_VF;
        Test.setCurrentPage(pageRefer);
        pageRefer.getParameters().put('branch','Test branch');
        pageRefer.getParameters().put('district','-- Choose A District --');
        ApexPages.StandardController sclr = new ApexPages.standardController(CPLeadtest);
        CO_CustomerPortalController Cntlr1 = new CO_CustomerPortalController(sclr);
        Cntlr1.Borrower_Name = 'john';
        Cntlr1.GoSearch();
        Cntlr1.Borrower_PropertyAdd = 'Address';
        Cntlr1.GoSearch();
        Cntlr1.Borrower_Email = 'test@test.com';
        Cntlr1.GoSearch();
        Cntlr1.Borrower_LoanNo = 'PL-123445';
        Cntlr1.GoSearch();
        Cntlr1.Borrower_Phone = '(111) 222-3333';
        Cntlr1.GoSearch();
       
         
         }*/
         }
         }