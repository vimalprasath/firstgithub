@istest(seeAllData = true)
public class UserController1_Test{
    public static testmethod void UserController1_method(){
        
        ID currentuserID = userinfo.getUserId();
        User u = new User();
        u.Avavilable__c = true;
        u.OOO__c = false;
        u.Count__c = 10;
        u.Lead_limit__c = 100;
        u.Unlimited_Leads__c = false;
        UserController1 uc = new UserController1();
        uc.userWrapperObject();
        UserController1.userwrapper wrap = new UserController1.userwrapper(u);
        list<UserController1.userwrapper> uw = new list<UserController1.userwrapper>();
        uc.getusrwrap();
        uc.setusrwrap();
    }
}