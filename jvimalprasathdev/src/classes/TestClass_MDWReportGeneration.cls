/**
 Description: Test Class for BatchClass_MDWReportGeneration.
 Author - Richard Joseph
 Created Date- March, 2014            
 @istest(seeAllData = true)
 */
  @istest(seeAllData = true)
private class TestClass_MDWReportGeneration {

    static testMethod void MDWReportGenerationTest() {
    
    List<Lead> TestInsertLeadList = new List<lead>();
           
           
        Lead TestLead = new Lead();    
        TestLead.channel__c = 'Centralized Retail';  
        TestLead.Channel_Sources__c = 'web';
        TestLead.Channel_Values__c = 'Google';
        TestLead.FirstName = 'First';
        TestLead.LastName = 'Last Test';
        TestLead.Email = 'TestEmail@Email.com';
       // TestLead.Co_Borrowers_First_Name__c = 'xyz';
       // TestLead.Co_Borrowers_Last_Name__c = 'xyz';
       // TestLead.Co_Borrowers_Email__c = 'xyz@xyz.com';
        TestLead.Applicant_Type__c = 'Individual';
        TestLead.Borrowers_Current_Residence__c = 'own';
        TestLead.Property_State__c = 'TX';
        TestLead.Loan_Type__c = 'HE';
        TestLead.Occupancy_Code__c = 'Owner Occupied';
        TestLead.Requested_Loan_Amount__c = 80000;
        TestLead.Loan_Purpose__c = 'Purchase';
        TestLead.Status = 'New - Not Opened';
        TestLead.Property_State__c = 'TX';   
        TestLead.Company = 'ABC Corp';
       
        TestInsertLeadList.add( TestLead);       
        TestInsertLeadList.add( TestLead.clone());  
        TestInsertLeadList.add( TestLead.clone());
        
        Lead CoBorrowerTestLead=TestLead.clone();
        CoBorrowerTestLead.Co_Borrowers_First_Name__c = 'CO First';
       CoBorrowerTestLead.Co_Borrowers_Last_Name__c = 'Co Last';
       CoBorrowerTestLead.Co_Borrowers_Email__c = 'First.last@CO.com';
       
       Lead BorrowerTestLead=CoBorrowerTestLead.clone();
       BorrowerTestLead.FirstName = 'BR First';
        BorrowerTestLead.LastName = ' BR Last Test';
        BorrowerTestLead.Email = 'First.last@BR.com';
        
        Lead FreshTestlead =TestLead.clone();
        FreshTestlead.FirstName = 'FR First';
        FreshTestlead.LastName = ' FR Last Test';
        FreshTestlead.Email = 'First.last@FR.com';
        TestInsertLeadList.add( FreshTestlead);  
        
        
        Id AccountRecordTypeId= Schema.SObjectType.Account.RecordTypeInfosByName.get('Person Account').RecordTypeId;
        Account TestAcc= new Account (FirstName='Test',LastName='Account', RecordTypeID= AccountRecordTypeId);
        
        
         Account NextTestAcc= new Account (FirstName='Test',LastName='Account 2',RecordTypeID= AccountRecordTypeId);
        
        
        Opportunity TestOpp = new Opportunity(Name='Test Opp', StageName='Closed Won', CloseDate= System.today() );
        Opportunity NextTestOpp = new Opportunity(Name='Test Opp', StageName='Closed Won', CloseDate= System.today() );

              
        Insert TestInsertLeadList;
        
        insert TestAcc;
        insert NextTestAcc;
        insert TestOpp ;
        insert NextTestOpp ;
        
        Account TestOppAcc = [Select Id, PersonContactId from Account where Id = :TestAcc.id];
        
        
        List<OpportunityContactRole> TestOppConRoleList = new List<OpportunityContactRole>();
        TestOppConRoleList.add(new OpportunityContactRole(OpportunityId=TestOpp.id, ContactId=TestOppAcc.PersonContactId, role='Borrower' ));
        TestOppConRoleList.add(new OpportunityContactRole(OpportunityId=TestOpp.id, ContactId=TestOppAcc.PersonContactId, role='Co-Borrower' ));
        
        insert TestOppConRoleList ;
        
        List<MDW_Report_Fields__c> MDWFieldsList= [Select id, Name,Field_API_Name__c from MDW_Report_Fields__c ];
        
        If (MDWFieldsList.size()==0)
        {
            MDWFieldsList.add(new MDW_Report_Fields__c (Name='1',Field_API_Name__c= 'Related_Opportunity__r.Lead_Number__c'));
            MDWFieldsList.add(new MDW_Report_Fields__c (Name='2',Field_API_Name__c= 'Department__c'));
            MDWFieldsList.add(new MDW_Report_Fields__c (Name='3',Field_API_Name__c= 'Co_Borrower__r.FirstName'));
            MDWFieldsList.add(new MDW_Report_Fields__c (Name='4',Field_API_Name__c= 'Account_Name__r.LastName'));
            MDWFieldsList.add(new MDW_Report_Fields__c (Name='5',Field_API_Name__c= 'Account_Name__r.PersonEmail'));
            MDWFieldsList.add(new MDW_Report_Fields__c (Name='6',Field_API_Name__c= 'Co_Borrower__r.State__c'));
            insert MDWFieldsList;
        }
        
        
        Test.startTest();
  
        
        TestLead.Account_Name__c=TestAcc.id;
        TestLead.Co_Borrower__c=NextTestAcc.id;
        TestLead .Related_Opportunity__c=TestOpp.id;
        
        Update TestLead;
        
        //BatchClass_MDMReportGeneration TestMDWObj1  = new BatchClass_MDMReportGeneration ();
        //Database.executeBatch(TestMDWObj1,5);   
        
         TestOpp.Related_Lead__c =TestLead.id;
         Update TestOpp;
            
            BatchClass_MDWReportGeneration TestMDWObj2= new BatchClass_MDWReportGeneration ();
            TestMDWObj2.QueryStr = 'Select id  , LastModifiedById , Value_of_Home__c , Lead_Opp_Created_Timestamp__c,Applicant_Type__c , Channel__c , Channel_Sources__c , Channel_Values__c , Created_Timestamp__c , CreatedById , OwnerId , Loan_Status__c , Requested_Loan_Amount__c , Loan_Purpose__c , Loan_Term__c , Loan_Type__c , Empower_Lead_ID__c ,Lead_Number__c, Transfer_to_HLR__c ,Related_Lead__c,Related_Lead__r.id, Shopping_Stage__c ,Owner.Name,CreatedBy.Name,LastModifiedby.Name,Opportunity_Owner_EID__c, Owner.EmployeeNumber FROM Opportunity  where ID IN (\''+ TestOpp.Id + '\',\''+ NextTestOpp.id+'\')';
            Database.executeBatch(TestMDWObj2); 
        
        Scheduler_MDWReportGeneration MDWShdlr = new Scheduler_MDWReportGeneration();
        
        String sch = '0 0 23 * * ?';
        system.schedule('Test MDW-REPORT', sch, MDWShdlr);

        //VF controller Test Class
        UtilitiesController  UtilityObj = new UtilitiesController();
        UtilityObj.InitateMUMReport();
        Test.StopTest();
        

    }
}