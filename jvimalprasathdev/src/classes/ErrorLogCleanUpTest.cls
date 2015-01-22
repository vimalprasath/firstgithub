@istest
public with sharing class ErrorLogCleanUpTest {
	
	static testMethod void ErrorLogCleanTest(){
		
		
		Test.startTest();
	/*	List<Profile> pList=[Select Id FROM Profile WHERE Name = 'SOFI API' ];
		Id pID=null;
		for(Profile p:pList)
		{
			pID=p.Id;
		}
		User uRec=[Select Id FROM User WHERE ProfileId=:pID AND IsActive = true limit 1];
		//List<User> uList=[Select Id FROM User WHERE ProfileId=:pID limit 1];
		//Id uID=null;
		//for(User u:uList)
		//{
			//uID=u.Id;
		//}*/
		 User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];//Added by vimal for the story B-653680
		System.runAs(thisUser)
		{
			Date currentDate=Date.newInstance(Date.Today().year(), Date.Today().month(), Date.Today().day());
			ErrorLogDetail__c errLog=new ErrorLogDetail__c();
			errLog.Record_ID__c='12345';
			errLog.Error_Type__c='Technical';
			errLog.Error_Source__c='API';
			errLog.Error_Message__c='Error Log created by the test class';
			errLog.Severity__c='Low';
			insert errLog;
			
			ErrorLogCleanUp sh1 = new ErrorLogCleanUp();
			String sch = '0 0 23 * * ?'; 
			system.schedule('Test Error Logs', sch, sh1); 
			
		}
		Test.stopTest();	
	}

}