@isTest
private class UpdateRating_Test {
	
	static void init(){
		List<StatusRatingMapping__c> settingList = new List<StatusRatingMapping__c>();
    	settingList.add(new StatusRatingMapping__c (Name='1', Object_Name__c='Lead;Opportunity', LoanPurpose__c='Purchase;Ref', Status__c='Request For Prequal;Contacted / No Product Available;Contacted / No Longer Interested', Stage__c='Any',Time_to_Apply__c='Any',Rating__c='Cold1',Is_Default__c=false,Default_Mapping_Fields_Name__c=''));
    	settingList.add(new StatusRatingMapping__c (Name='2', Object_Name__c='Opportunity', LoanPurpose__c='Purchase;Ref', Status__c='Contacted / No Longer Interested', Stage__c='Lost',Time_to_Apply__c='Any',Rating__c='Dead',Is_Default__c=false,Default_Mapping_Fields_Name__c=''));
    	settingList.add(new StatusRatingMapping__c (Name='3', Object_Name__c='Opportunity', LoanPurpose__c='Ref', Status__c='any', Stage__c='Any',Time_to_Apply__c='Any',Rating__c='Cold11',Is_Default__c=false,Default_Mapping_Fields_Name__c=''));
    	settingList.add(new StatusRatingMapping__c (Name='4', Object_Name__c='Opportunity', LoanPurpose__c='Purchase', Status__c='Request For Prequal', Stage__c='Prospecting',Time_to_Apply__c='Any',Rating__c='Cold2',Is_Default__c=false,Default_Mapping_Fields_Name__c=''));
    	settingList.add(new StatusRatingMapping__c (Name='5', Object_Name__c='Opportunity', LoanPurpose__c='Refi', Status__c='Contacted / Still Deciding', Stage__c='Prospecting',Time_to_Apply__c='1-2 weeks',Rating__c='Hot',Is_Default__c=false,Default_Mapping_Fields_Name__c=''));
    	settingList.add(new StatusRatingMapping__c (Name='6', Object_Name__c='Opportunity', LoanPurpose__c='', Status__c='', Stage__c='Prospecting',Time_to_Apply__c='',Rating__c='Hot1',Is_Default__c=true,Default_Mapping_Fields_Name__c='Stage__c=Stagename'));
    	settingList.add(new StatusRatingMapping__c (Name='7', Object_Name__c='Opportunity', LoanPurpose__c='any', Status__c='', Stage__c='any',Time_to_Apply__c='',Rating__c='Cold3',Is_Default__c=true,Default_Mapping_Fields_Name__c='Stage__c=StageName;LoanPurpose__c=Loan_Purpose__c'));
    	settingList.add(new StatusRatingMapping__c (Name='8', Object_Name__c='Opportunity', LoanPurpose__c='', Status__c='', Stage__c='Lost',Time_to_Apply__c='',Rating__c='Hot2',Is_Default__c=true,Default_Mapping_Fields_Name__c='Stage__c=Stagename'));
    	settingList.add(new StatusRatingMapping__c (Name='9', Object_Name__c='Opportunity', LoanPurpose__c='', Status__c='', Stage__c='Lost',Time_to_Apply__c='',Rating__c='Hot3',Is_Default__c=true,Default_Mapping_Fields_Name__c='Stage__c=StageName;LoanPurpose__c=Loan_Purpose__c'));
    	settingList.add(new StatusRatingMapping__c (Name='10', Object_Name__c='Opportunity', LoanPurpose__c='', Status__c='', Stage__c='Lost',Time_to_Apply__c='',Rating__c='Cold4',Is_Default__c=true,Default_Mapping_Fields_Name__c='Stage__c=Stagename'));
    	
    	insert settingList;
	}
	
	static testMethod void myUnitTest_UpdateRating() {
		init();
		try{
			Lead ld = new lead();
			ld.status = 'Request For Prequal';
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
			ld.Lead_Stage__c='Lost';
			ld.Shopping_Stage__c='1-2 weeks';
			
			insert ld;
			List<Lead> ldList = new List<Lead>();
			ldList.add(ld);
			UpdateRatings.getLeadRatings(ldList);
			
			
		   account acc =  new account(lastname='Testuser');
	       insert acc;
	      
	       Opportunity opp = new Opportunity(accountid=acc.id,name = 'test name',Loan_Purpose__c='Purchage',Loan_Status__c='Contacted / Still Deciding',StageName='Prospecting',Shopping_Stage__c='1-2 weeks',CloseDate=System.today(),Related_Lead__c = null); 
	       insert opp;
			
			List<Opportunity> oppList = new List<Opportunity>();
			oppList.add(opp);
			UpdateRatings.getOppRatings(oppList);
			opp.Loan_Purpose__c='Purchage1';
			update opp;
			UpdateRatings.getOppRatings(oppList);
			
			
		   Opportunity opp1 = new Opportunity(Related_Lead__c = ld.id, accountid=acc.id,name = 'test name1',Loan_Purpose__c='Purchage',Loan_Status__c='Contacted / Still Deciding',StageName='Prospecting',Shopping_Stage__c='1-2 weeks',CloseDate=System.today()); 
	       insert opp1;
			
		}catch(Exception e){
			System.debug('Error during test run: ' + e);
		}
		
	}
}