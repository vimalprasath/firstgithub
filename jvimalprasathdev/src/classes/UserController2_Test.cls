@istest(seeAllData = true)
public class UserController2_Test{
	public static testmethod void UserController1_method(){
        ID currentuserID = userinfo.getUserId();
		ID CurrentpageId = ApexPages.currentPage().getParameters().get('id');
        User u = new User();
        u.Avavilable__c = true;
        u.OOO__c = false;
        u.Count__c = 10;
        u.Lead_limit__c = 100;
        u.Unlimited_Leads__c = false;
        UserController2 uc = new UserController2();
        uc.saveAction();
        uc.cancelAction();
    }
}