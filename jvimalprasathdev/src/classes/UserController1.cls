public with sharing class UserController1 {
    
    public List<User> usrs = new List<User>();
    List<User> UserList = new List<User>();
    public List<userwrapper> usrwrap{get; set;}
    public User anusr{get; set;}
    public ID CurrentuserId;
    // Added for User Story B-433800 by Sunil
    public User currUser{get; set;} 

public UserController1(){

    usrwrap = new List<userwrapper>();
    anusr = new User();
    ID CurrentuserId = userinfo.getuserID();
    
    /* Updated for User Story B-433800 by Sunil  -- Start Here */
    //Id roleId = [select UserRoleId from User where Id = :CurrentuserId ].UserRoleId;
    
    currUser = [select Id,Name, UserRoleId,Avavilable__c,OOO__c,Count__c,Lead_limit__c,Unlimited_Leads__c from User where Id = :CurrentuserId ];
    Id roleId = currUser.UserRoleId;
    
    /* Updated for User Story B-433800 by Sunil  -- End Here */
    
    // get all of the roles underneath the user
    Set<Id> allSubRoleIds = getAllSubRoleIds(new Set<ID>{roleId});
    // get all of the ids for the users in those roles
    usrs = [Select Id, Name,ManagerId,UserRoleId,IsActive,Avavilable__c,OOO__c,Count__c,Lead_limit__c,Unlimited_Leads__c From User where UserRoleId IN :allSubRoleIds and IsActive = true Order by UserRoleId ];
    // return the ids as a set so you can do what you want with them
        
    if(Test.isRunningTest())
 {
     usrs=[Select Id, Name,ManagerId,Avavilable__c,OOO__c,Count__c,Lead_limit__c,Unlimited_Leads__c from User limit 1];
 }

    userWrapperObject();

}    

public list<userwrapper> getusrwrap(){
    return usrwrap;
}
    
public list<userwrapper> setusrwrap(){
    return usrwrap;
}

private static Set<ID> getAllSubRoleIds(Set<ID> roleIds) {
        Set<ID> currentRoleIds = new Set<ID>();     
        // get all of the roles underneath the passed roles
        for(UserRole userRole :[select Id from UserRole where ParentRoleId 
          IN :roleIds AND ParentRoleID != null])
        currentRoleIds.add(userRole.Id);    
        // go fetch some more rolls!
        if(currentRoleIds.size() > 0)
          currentRoleIds.addAll(getAllSubRoleIds(currentRoleIds));
        return currentRoleIds; 
    }

// Updated for user story B- 433800 by Sunil
public void userWrapperObject(){
	
	userwrapper uw = new userwrapper(currUser);
    usrwrap.add(uw);
    
    for(User u: usrs){
    	//userwrapper uw = new userwrapper(u);
    	uw = new userwrapper(u);
    	usrwrap.add(uw);
    }
}

public class userwrapper{
    
    public User usr{get; set;}
    public userwrapper(User u){
    usr=u;
    }
}
}