@isTest
private class ConvertObj_Test {


	static testMethod void myUnitTest() {
		Lead ld = new lead();
		ld.status = 'Active';
		ld.Channel__c = 'Centralized Retail';
		ld.Channel_Sources__c = 'Bank';
		ld.Applicant_Type__c = 'Individual';
		ld.Channel_Values__c = 'RB Portal';
		ld.Internal_Referral__c = 'N/A';
		ld.Borrowers_Current_Residence__c =  'Own';
		ld.Company = 'None';
		ld.FirstName = 'sunil';
		ld.LastName = 'testrec';
		ld.Borrowers_Home_Phone__c = '(111) 222-3333';
		//ld.Internal_Referral_Name__c = u.id;
		ld.Property_State__c = 'TX';
		ld.Notes_Type__c = 'Called Home, Left Message – No Contact';
		ld.Loan_Purpose__c = 'Purchase';
		
		insert ld;
		Test.startTest();

		String str = 'Property_details';
		ConvertObj.convert(ld.Id, str);

		Test.stopTest();
    }
    
    static testMethod void myUnitTest1() {
        List<ObjectConvertorMapping__c> settingList = new List<ObjectConvertorMapping__c>();
    	settingList.add(new ObjectConvertorMapping__c (Name='1', Mapping_Name__c='Property_details', Source_Api_Name__c='Closing_Date__c', Source_Object_Name__c='Lead', Target_API_Name__c='CloseDate',Target_Object_Name__c='Opportunity'));
    	settingList.add(new ObjectConvertorMapping__c (Name='2', Mapping_Name__c='Property_details', Source_Api_Name__c='Channel_Values__c', Source_Object_Name__c='Lead', Target_API_Name__c='Channel_Values__c',Target_Object_Name__c='Opportunity'));
    	settingList.add(new ObjectConvertorMapping__c (Name='3', Mapping_Name__c='Property_details', Source_Api_Name__c='Channel__c', Source_Object_Name__c='Lead', Target_API_Name__c='Channel__c',Target_Object_Name__c='Opportunity'));
    	settingList.add(new ObjectConvertorMapping__c (Name='4', Mapping_Name__c='Property_details', Source_Api_Name__c='Status', Source_Object_Name__c='Lead', Target_API_Name__c='Loan_Status__c',Target_Object_Name__c='Opportunity'));
    	settingList.add(new ObjectConvertorMapping__c (Name='5', Mapping_Name__c='Property_details', Source_Api_Name__c='Related_Opportunity__c', Source_Object_Name__c='Lead', Target_API_Name__c='Id',Target_Object_Name__c='Opportunity',Source_Object_Action__c=true));
    	settingList.add(new ObjectConvertorMapping__c (Name='6', Mapping_Name__c='Property_details', Source_Api_Name__c='Id', Source_Object_Name__c='Lead', Target_API_Name__c='Related_Lead__c',Target_Object_Name__c='Opportunity'));
    	settingList.add(new ObjectConvertorMapping__c (Name='7', Mapping_Name__c='Property_details', Source_Api_Name__c='Name', Source_Object_Name__c='Lead', Target_API_Name__c='StageName',Target_Object_Name__c='Opportunity',Is_Static__c=true, Static_Value__c='Prospecting'));
    	settingList.add(new ObjectConvertorMapping__c (Name='8', Mapping_Name__c='Property_details', Source_Api_Name__c='Target_Opportunity_Name__c', Source_Object_Name__c='Lead', Target_API_Name__c='Name',Target_Object_Name__c='Opportunity'));
    	settingList.add(new ObjectConvertorMapping__c (Name='9', Mapping_Name__c='Property_details', Source_Api_Name__c='Annual_Homeowner_s_Insurance__c', Source_Object_Name__c='Lead', Target_API_Name__c='Annual_Homeowner_s_Insurance__c',Target_Object_Name__c='Opportunity'));
    	settingList.add(new ObjectConvertorMapping__c (Name='10', Mapping_Name__c='Property_details', Source_Api_Name__c='Transfer_to_HLR__c', Source_Object_Name__c='Lead', Target_API_Name__c='Transfer_to_HLR__c',Target_Object_Name__c='Opportunity'));
    	
    	
    	insert settingList;
    	
		
		Lead ld = new lead();
		ld.status = 'Active';
		ld.Channel__c = 'Centralized Retail';
		ld.Channel_Sources__c = 'Bank';
		ld.Applicant_Type__c = 'Individual';
		ld.Channel_Values__c = 'RB Portal';
		ld.Internal_Referral__c = 'N/A';
		ld.Borrowers_Current_Residence__c =  'Own';
		ld.Company = 'None';
		ld.FirstName = 'sunil';
		ld.LastName = 'testrec';
		ld.Borrowers_Home_Phone__c = '(111) 222-3333';
		//ld.Internal_Referral_Name__c = u.id;
		ld.Property_State__c = 'TX';
		ld.Notes_Type__c = 'Called Home, Left Message – No Contact';
		ld.Loan_Purpose__c = 'Purchase';
		
		insert ld;
		
		Test.startTest();
		try{
			String str = 'Property_details';
			ConvertObj.convert(ld.Id, str);
			
			
		}catch (Exception e) {}
		Test.stopTest();
    }
}