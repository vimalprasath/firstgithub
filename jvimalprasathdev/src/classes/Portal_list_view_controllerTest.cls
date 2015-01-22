@istest(seealldata=false)
public class Portal_list_view_controllerTest { 

    Static Testmethod Void TestPortal_list_view_controller(){

    Profile p= [ Select id from Profile where name = 'Marketing User'];
  
    userrole  r=[select id from userrole where name='System Administrator'];
   
    User u2=[select id from user where userroleid != Null and isactive = true limit 1];
    
    Region__c reg = new Region__c(Name='Test Region');
    insert reg;
    
    District__c des = new District__c(name='Test district',Region__c=reg.id);
    insert des;
    
    Branch__c bran = new Branch__c(name='Test branch',District__c=des.id,Branch_Number__c='1010');
    insert bran;
    
    Recordtype R1 = [select id from recordtype where name = 'Business Account' AND SobjectType = 'Account'];   
    Account A1 = new Account( name = 'Test Account',Ownerid = u2.id,recordtypeid=r1.id); 
    insert A1;
    
    List<Contact> ContactList = new List<Contact>(); 
    Contact C1 = new Contact( Branch__c=bran.id,AccountID = A1.id, FirstName = 'Test', LastName = 'User',email = 'test-user@fakeemail.com' ); 
    insert C1;
  
    ID ProfileID = [ Select id from Profile where name = 'Authenticated Portal Website'].id;
    User u1 = new User( email='test-user@fakeemail.com', contactid = c1.id, profileid = ProfileID, UserName='test-user@fakeemail.com', alias='tuser1', CommunityNickName='tuser1',TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='ISO-8859-1',LanguageLocaleKey='en_US', FirstName = 'Test', LastName = 'User' ); 
    insert u1; 
        
    System.runAs (u1 ){       

        User portaluser = [Select id,contactId,Name  from user where id =:UserInfo.getUserId()];    
        System.debug('*****Portal User Selected*****'+portaluser.Name); 
        System.debug('*****Portal User contactId*****'+portaluser.contactId);            
        
   
        Customer_Portal_Lead__c CPLead = new Customer_Portal_Lead__c();
        CPLead.property_located__c = 'TX';
        CPLead.property_state__c = 'TX';
        CPLead.First_Name__c = 'Test Name';
        CPLead.Last_Name__c ='test Last';
        CPLead.Daytime_Phone__c = '(999) 456-1234';
        CPLead.Borrowers_Home_Phone__c = '(111) 222-3333';
        CPLead.Borrowers_Zip_Postal_Code__c = '12344';
        CPLead.Marrital_Status__c = 'new'; 
        CPLead.Applicant_Type__c = 'new';
        CPLead.Borrowers_Address_1__c = 'test'; 
        CPLead.Borrower_State_2__c = 'TX';
        system.debug('<<<<<<<<Sucessful insert>>>>>>>>'+cplead.id);
        
         
        
        PageReference pageRef = Page.RB_Portal_List_View;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('id',CPlead.id);
        
        ApexPages.StandardController sc = new ApexPages.standardController(cplead);
        Portal_list_view_controller Cntlr = new Portal_list_view_controller(sc);
           Cntlr.CustomerAssessment();
           Cntlr.getBranches();
           Cntlr.saveBranches(); 
           Cntlr.sortExpression = 'Application_number__c';

           Cntlr.Search();
           Cntlr.colmnsorting();

           Cntlr.refresh();

       Cntlr.Borrower_Name = 'john';
       Cntlr.colmnsorting();
       Cntlr.Borrower_PropertyAdd = 'Address';
       Cntlr.colmnsorting();
       Cntlr.Borrower_Email = 'test@test.com';
       Cntlr.colmnsorting();
       Cntlr.Borrower_LoanNo = 'PL-123445';
       Cntlr.colmnsorting(); 
       Cntlr.Borrower_Phone = '(111) 222-3333';
       Cntlr.colmnsorting(); 
       Cntlr.getSortDirection();
       Cntlr.Setsortdirection('abc');
       cntlr.paramSelectedDist = 'TX';
       cntlr.getSortDirection();
         
        PageReference pageRefer = Page.RB_Portal_List_View;
        Test.setCurrentPage(pageRefer);
        pageRefer.getParameters().put('branch','Test branch');
        pageRefer.getParameters().put('district','Test district');
        
        ApexPages.StandardController sclr = new ApexPages.standardController(cplead);
        Portal_list_view_controller Cntlr1 = new Portal_list_view_controller(sclr);
        Cntlr1.Borrower_Name = 'john';
        Cntlr1.Search();
        Cntlr1.Borrower_PropertyAdd = 'Address';
        Cntlr1.Search();
        Cntlr1.Borrower_Email = 'test@test.com';
        Cntlr1.Search();
        Cntlr1.Borrower_LoanNo = 'PL-123445';
        Cntlr1.Search();
        Cntlr1.Borrower_Phone = '(111) 222-3333';
        Cntlr1.Search();
        cntlr1.paramSelectedDist = 'TX';
        cntlr1.getSortDirection();
        cntlr1.sortExpression = null;
        cntlr1.getSortDirection();
        
        
        PageReference pageRef1 = Page.RB_Portal_List_View;
        Test.setCurrentPage(pageRef1);
        pageRef1.getParameters().put('id',CPlead.id);
        pageRef1.getParameters().put('branch','Test branch');
        pageRef1.getParameters().put('district','Test district');
        ApexPages.StandardController sc11 = new ApexPages.standardController(cplead);
        Portal_list_view_controller Cntlr11 = new Portal_list_view_controller(sc11);
           Cntlr11.SelectedDistrict = '-- Choose A District --';
           Cntlr11.SelectedBranch = '';
           Cntlr11.CustomerAssessment();
           Cntlr11.getBranches();
           Cntlr11.search();
           Cntlr11.colmnsorting();

        
         }
         }
         }