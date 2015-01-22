@IsTest 
    public class MyProfilePageControllertest {
    static testmethod void MyProfilePageControllertest() {       
        // Modify the test to query for a portal user that exists in your org
        List<User> existingPortalUsers = [SELECT id, profileId, userRoleId FROM User WHERE UserRoleId <> null AND UserType='GUEST' AND isactive = true];  
        

        /*User currentUser = [select id, title, firstname, lastname, email, phone,contactid, mobilephone, fax, street, city, state, postalcode, country
                                FROM User WHERE contactid != Null and isactive = true limit 1];*/
        Profile p = [SELECT Id FROM Profile WHERE Name='Authenticated Portal Website']; 
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
    Contact con = new Contact( Branch__c=bran.id,AccountID = A1.id, FirstName = 'Test', LastName = 'User',email = 'test-user@fakeemail.com' ); 
    insert con;
      User currentUser = new User(Alias = 'newUser', Email='newuser@testorg.com',phone='(765) 123-9977',mobilephone='(765) 123-9977',
         fax='5552224444',street='San Fernando St',city='San Jose',state='California',postalcode='95113',country='USA', 
         EmailEncodingKey='UTF-8', LastName='Testing', FirstName='Mohana', LanguageLocaleKey='en_US', 
         LocaleSidKey='en_US', ProfileId = p.Id,contactid = con.Id, 
         TimeZoneSidKey='America/Los_Angeles', UserName='newuser@testorg.com'); 
         insert currentUser;                    
        
 system.debug('++++++Current user+++++'+currentUser);
 system.debug('++++++existingPortalUsers +++++'+existingPortalUsers.size());       
        User currentUser1 = [select id, title, firstname, lastname, email, phone,contactid, mobilephone, fax, street, city, state, postalcode, country
                                FROM User WHERE contactid = Null and isactive = true limit 1];
        
        
                                
         System.Runas(currentUser)
         {                       
       
        if (existingPortalUsers.isEmpty()) {
   
        system.debug('Entered if');
        
            
            MyProfilePageController controller = new MyProfilePageController();
           // System.assertEquals(currentUser .Id, controller.getUser().Id, 'Did not successfully load the current user');
            controller.cancel();
            controller.saveto();
            controller.submit();
            controller.getUser();
           
            System.assert(Page.ChangePassword.getUrl().equals(controller.changePassword().getUrl()));
        } else {
            User existingPortalUser = existingPortalUsers[0];
            String randFax = Math.rint(Math.random() * 1000) + '5551234';
            
            system.debug('***********'+randFax);
            System.runAs(existingPortalUser) {
                MyProfilePageController controller = new MyProfilePageController();
                System.assertEquals(existingPortalUser.Id, controller.getUser().Id, 'Did not successfully load the current user');

                system.debug('Entered else');
                controller.cancel();
              
                
                controller.getUser().Fax = randFax;
                controller.saveto();
                system.debug('*****saved******'+controller.getUser().Fax);
            
            }
            system.debug('*****after save******'+randFax);
            
            // verify that the user and contact were updated
            existingPortalUser = [Select id, fax, Contact.Fax from User where id =: existingPortalUser.id];
            system.debug('============'+existingPortalUser.fax);
            system.debug('============'+existingPortalUser.Contact.Fax);
            system.debug('============'+existingPortalUser);
            System.assert(existingPortalUser.fax == randFax);
            System.assert(existingPortalUser.Contact.fax == randFax);
    
     }   
    }    
    }
     static testmethod void MyProfilePageControllertest1() {       
        // Modify the test to query for a portal user that exists in your org
          Profile p= [ Select id from Profile where name = 'Marketing User'];  
         userrole  r=[select id from userrole where name='System Administrator'];   
         User u2=[select id from user where userroleid != Null and isactive = true limit 1];
    
        Recordtype R1 = [select id from recordtype where name = 'Business Account' AND SobjectType = 'Account'];   
        Account A1 = new Account( name = 'Test Account',Ownerid = u2.id,recordtypeid=r1.id); 
        insert A1;
    
        List<Contact> ContactList = new List<Contact>(); 
        Contact C1 = new Contact(AccountID = A1.id, FirstName = 'Test', LastName = 'User',email = 'test-user@fakeemail.com' ); 
        insert C1;
  
        ID ProfileID = [ Select id from Profile where name = 'Authenticated Portal Website'].id;
        User currentUser = new User(lastName='Abc',email='test-user@fakeemail.com',contactid = c1.id,profileid = ProfileID, UserName='test-user@fakeemail.com', alias='tuser1', CommunityNickName='tuser1',TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='ISO-8859-1',LanguageLocaleKey='en_US'); 
        insert currentUser; 
                                
         System.Runas(currentUser)
         {                       
              
            
            MyProfilePageController controller = new MyProfilePageController();
            System.assertEquals(currentUser .Id, controller.getUser().Id, 'Did not successfully load the current user');
            controller.cancel();
            controller.saveto();
            controller.submit();
           
            System.assert(Page.ChangePassword.getUrl().equals(controller.changePassword().getUrl()));
        } 
    
     }   
   
    
    }