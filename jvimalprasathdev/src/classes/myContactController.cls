/*
Name: myContactController
Author: Leena N
Description: This Class is used for displaying contacts on a visualforce page
Last modified by: Leena N
*/
public with sharing class myContactController {
         
    List<Contact> Contacts;
    List<ContactWrapper> actualContacts = new List<ContactWrapper>();
    //new
    List<User> UserList = new List<User>();
    public String SelectedU {get; set;}
    public List<SelectOption> UserListGS {get; set;}    
    public List<SelectOption> ContactType {get; set;}
    public String SelectedCT {get; set;}
    //
    public myContactController(){        
        if(Contacts == null) {
            Contacts =[select id,name,phone,email,mobilephone,createddate,contact_type__c from Contact limit 500];     
            ContactWrappermethod(Contacts);
        }
        
        
        ContactType = new List<SelectOption>();
        UserListGS = new List<SelectOption>();
        //statusoptions = new List<SelectOption>();
        UserList =  getRoleSubordinateUsers(UserInfo.getUserId());
        user temp = [select id,name from user where id =: UserInfo.getuserid() limit 1];
        UserList.add(temp); 
        UserList.sort();
         
        system.debug('************getRoleSubordinateUsers(UserInfo.getUserId());************'+getRoleSubordinateUsers(UserInfo.getUserId()));
        UserListGS.add(new SelectOption('None','None'));
        for(user temp1 : UserList){
            UserListGS.add(new SelectOption(temp1.id,temp1.name));         
        }
        Schema.DescribeFieldResult fieldContactPurpose = Contact.Contact_Type__c.getDescribe();
        List<Schema.PicklistEntry> CaLop = fieldContactPurpose.getPicklistValues();
        ContactType.add(new SelectOption('None','None'));
        for(Schema.PicklistEntry f : CaLop){
            ContactType.add(new SelectOption(f.getLabel(), f.getValue()));
        }
        
    }
    
    public static List<User> getRoleSubordinateUsers(Id userId) {     
        // get requested user's role
        Id roleId = [select UserRoleId from User where Id = :userId].UserRoleId;
        // get all of the roles underneath the user
        Set<Id> allSubRoleIds = getAllSubRoleIds(new Set<ID>{roleId});
        // get all of the ids for the users in those roles
        List<User> UsersL = [Select Id, Name From User where UserRoleId IN :allSubRoleIds];
        // return the ids as a set so you can do what you want with them
        return UsersL; 
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
    
    public void goContacts(){
       Contacts.clear();
       Contacts = new List<Contact>();
       if(SelectedCT != 'None' && SelectedU != 'None')
           Contacts = [select id,name,phone,email,mobilephone,createddate,contact_type__c from Contact where (ownerid=:SelectedU and Contact_Type__c =: SelectedCT) order by createddate desc LIMIT 500];
       if(SelectedCT == 'None')
           Contacts = [select id,name,phone,email,mobilephone,createddate,contact_type__c from Contact where ownerid=:SelectedU order by createddate desc LIMIT 500];
       if(SelectedU == 'None')
           Contacts = [select id,name,phone,email,mobilephone,createddate,contact_type__c from Contact where Contact_Type__c =: SelectedCT order by createddate desc LIMIT 500];
       if(SelectedCT == 'None' && SelectedU == 'None')
           Contacts = [select id,name,phone,email,mobilephone,createddate,contact_type__c from Contact order by createddate desc LIMIT 500];
       if(Contacts!=null && Contacts.size()>0){
           ContactWrappermethod(Contacts);
       }else{
       Contacts.Clear();
       ContactWrappermethod(Contacts);
       }
           
    }
   
    public void ContactWrappermethod(List<Contact> Contacts){
        actualContacts = new List<ContactWrapper>();
        for(integer i=0; i<Contacts.size(); i++){
            ContactWrapper wrapclass = new ContactWrapper(Contacts[i]);
            actualContacts.add(wrapclass);
        }
    }
    public class ContactWrapper{
        public string createddate{get; set;}
        public Contact Con{get; set;}
        public ContactWrapper(Contact conObj){
            createddate=conObj.createddate.format();
            Con=conObj;        
        }
    }
    public List<ContactWrapper> getVFContacts(){
        return actualContacts;
    }    
    public void RefereshCT() {
       Contacts.clear();
       Contacts = new List<Contact>();    
       Contacts = [select id,name,phone,email,mobilephone,createddate,contact_type__c from Contact order by createddate desc LIMIT 500];
       ContactWrappermethod(Contacts);
       SelectedU='None';
       SelectedCT='None';
       
    }    
    public pageReference newContact(){
        PageReference pgref = new PageReference('/003/e');
        return pgref;
    }
    
}