public with sharing class UserController2{
public List<User> filteredUsers{get;set;}

/* Updated for User Story B-433800 by Sunil  -- Start Here */
//public ID CurrentuserId;
//public ID CurrentpageId;

public ID CurrentuserId{get; set;}
public ID CurrentpageId{get; set;}


/* Updated for User Story B-433800 by Sunil  -- End Here */

public UserController2(){
CurrentpageId = ApexPages.currentPage().getParameters().get('id');
List<User> usrlist = new List<User>();
CurrentuserId = userinfo.getuserID();
filteredUsers = new List<User>();
string querystring;
querystring = 'Select Id, Name,ManagerId,Avavilable__c,OOO__c,Count__c,Lead_limit__c,Unlimited_Leads__c from User where id=:CurrentpageId and IsActive=True ';
filteredUsers = Database.query(querystring);

}
 public PageReference saveAction() {   
            try{
                update filteredUsers;
                }catch(exception e){
                }
                PageReference page = new Pagereference('/apex/QueueMgmt?Id='+CurrentuserId);
            page.setRedirect(true);
            return page;
 }
 
  public Pagereference cancelAction(){
        PageReference newpage = new Pagereference('/apex/QueueMgmt?Id='+CurrentuserId);
        newpage.setRedirect(true);
        return newpage;
 }

}