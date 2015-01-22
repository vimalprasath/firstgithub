/**
 * An apex class that keeps updates of a portal user in sync with its corresponding contact.
   Guest users are never able to access this page.
 */
public with sharing class MyProfilePageController {

    private User user;
    private boolean isEdit = false;
    
    public User getUser() {
        return user;
    }

    public MyProfilePageController() {
        user = [SELECT id, email, username, usertype, communitynickname, timezonesidkey, languagelocalekey, firstname, lastname, phone, title,
                street, city, country, postalcode, state, localesidkey, mobilephone, extension, fax, contact.email
                FROM User
                WHERE id = :UserInfo.getUserId()];
        // guest users should never be able to access this page
        if (user.usertype == 'GUEST') {
            throw new NoAccessException();
        }
    }
    
  /*  public Boolean getIsEdit() {
        return isEdit;
    }
    
    public void edit() {
        isEdit=true;
    }    
    */
    public pagereference saveto() {
        return null;
    }
    
    public pagereference Submit() {
     system.debug('+++++user.contact+++++ ');
  //  try {
     boolean updateU = false;
     if((user.firstname == null || user.firstname == '')) {
      
            system.debug('******user.firstname*******'+user.firstname);
            system.debug('+++++user.contact+++++ '+user.contact);
               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please enter a value in the Required Field'));
               // ApexPages.Message myMsg = new ApexPages.Message(ApexPages.FATAL, 'My Error Message');
              //  myMsg.addError('This is a field Error');
              updateU = false;
        }else{
            updateU = true;
        }
    
        if (user.contact != null) {              
            setContactFields(user.contact, user);        
        }
        
        if(updateU == true){
            update user;
            if (user.contact != null) { 
                update user.contact;
            pagereference pageref= new pagereference('/apex/CO_RBPipeline_VF');
            pageref.setredirect(true);
            return pageref;    
            }
    }   
    isEdit=false;
    return null;
            
            
  //  }catch(DmlException e) {
   //            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please enter a value in the Required Field'));
   //     return null;
  //  }
    }
    
    public PageReference changePassword() {
        return Page.ChangePassword;
    }
    
    public pagereference cancel() {
        isEdit=false;
    pagereference pageref= new pagereference('/apex/CO_RBPipeline_VF');
            pageref.setredirect(true);
            return pageref;     
    }
    
    private static void setContactFields(Contact c, User u) {
     //   c.title = u.title;
        c.firstname = u.firstname;
        c.lastname = u.lastname;
        c.email = u.email;
        c.phone = u.phone;
       // c.mobilephone = u.mobilephone;
     //   c.fax = u.fax;
     //   c.mailingstreet = u.street;
     //   c.mailingcity = u.city;
     //  c.mailingstate = u.state;
     //   c.mailingpostalcode = u.postalcode;
     //   c.mailingcountry = u.country;
    }

}