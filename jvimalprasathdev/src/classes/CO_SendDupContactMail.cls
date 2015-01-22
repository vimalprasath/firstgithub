public class CO_SendDupContactMail{
    public static void CO_DupContact_method(List<Contact> Listcontacts){
        //Declaration of variables
        Set<string> setConphone =new set<string>();
        Set<string> setConEmail =new set<string>();
        Set<string> sethomephone =new set<string>();
        Set<string> setmobilephone =new set<string>();
        Set<id> SetContactids =new set<id>();
        Set<String> setusername=new Set<String>();
        Map<String,User> mapMgr=new Map<String,User>();
        list<Contact> Contactslist=new list<Contact>();
        List<User> UserList= new List<User>();
        List<String> UseremailList= new List<String>();
        
        for(Contact c:ListContacts){
            SetContactids.add(c.id);
            setConphone.add(c.phone);
            setConEmail.add(c.email); 
            sethomephone.add(c.homephone); 
            setmobilephone.add(c.mobilephone);                    
        }
        if(SetContactids!=null && SetContactids.size()>0){
            contactsList = [select id,firstname,lastname,mobilephone,homephone,ownerid,owner.username,owner.Firstname,owner.lastname,email,phone,CreatedDate from contact where (id not in:SetContactids and Contact_type__c='Realtor') and ((phone!=null and phone in: setConphone) or (Email!=null and Email in:setConEmail)or (homephone!=null and homephone in: sethomephone) or (mobilephone!=null and mobilephone in: setmobilephone)) order by createddate];
        }
        /*for(Contact mgrld:contactsList){
            setusername.add(mgrld.owner.username);
            system.debug('uuuuuuuuuuuu'+setusername);
        }
        UserList = [select id,name,manager.name,managerid,manager.email,username,email from User where  username in:setusername];*/
        UserList = [select id,name,manager.name,managerid,manager.email,username,email,userroleid,userrole.name from User where  userrole.name='Sales Support Admin'];
        for(User u:UserList){
            //mapMgr.put(u.username,u);
            UseremailList.add(u.email);
        }
        if(contactsList!=null && contactsList.size()>0){
            for(Contact cnew:ListContacts){
                for(Contact cold:contactsList){
                    system.debug('oooooooooooooooooooooooooo'+cold);
                   // system.debug('nnnnnnn'+cnew.phone+'oooooooo'+cold.phone+'iiiiiiiii'+cold.owner.username);
                    if(cnew.phone!=null && cold.phone!=null && cnew.phone==cold.phone){
                    //system.debug('eeeeeeeeeee'+mapMgr.get(cold.owner.username));
                        //if(mapMgr.get(cold.owner.username)!=null)  { 
                             sendEmail2ConMgr(cold,cnew,UseremailList);
                             break;
                        // }
                         
                    }
                    if(cnew.email!=null && cold.email!=null && cnew.email==cold.email){
                       // if(mapMgr.get(cold.owner.username)!=null)  { 
                             sendEmail2ConMgr(cold,cnew,UseremailList);
                             break;
                       //  }
                         
                    }
                    if(cnew.homephone!=null && cold.homephone!=null && cnew.homephone==cold.homephone){                      
                         sendEmail2ConMgr(cold,cnew,UseremailList);
                         break;                                               
                    }
                    if(cnew.mobilephone!=null && cold.mobilephone!=null && cnew.mobilephone==cold.mobilephone){                      
                         sendEmail2ConMgr(cold,cnew,UseremailList);
                         break;                                               
                    }
                }
            }
        }
        
        
        
        
    }
    
    //method to send email to lead manager
    public static void sendEmail2ConMgr(Contact cold, Contact cnew,List<String> UseremailList){
  //  for(integer)
   //     String[] toAdd =  new string[]{UseremailList};
        String subject = 'Duplicate Realtor Contact';
        String body;
        
        map<id,string> mapuser = new map<id,string>();
        list<user> UserList2 = new list<user>(); 
        try{
        
        UserList2 = [select id,name from User];
        for(User u:UserList2){
            mapuser.put(u.id,u.name);
        }
        
        
        system.debug('********ld************'+cnew);
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        body ='<html><style type="text/css">body {font-family: Arial; font-size: 12px;}</style><body><pre>'; 
        body += 'Hi,';
        body +='<br/><br/>A potential duplicate realtor contact for '+cnew.firstname+' '+cnew.lastname+' has been created' ;  //by '+mapuser.get(cnew.Ownerid)+'.' ;
        body +='<br/><br/>This contact is currently owned by '+cold.owner.FirstName+' '+cold.owner.LastName+' with the earliest Realtor Contact creation date of: '+ cold.CreatedDate +'.';       
        body +='<br/><br/>Please take the necessary action.';
        body +='<br/><br/><b>Existing Contact Details: </b>';
        body +='<br/>Name: '+cold.firstname+' '+cold.lastname;
        if(cold.phone!=null)
        body +='<br/>Phone: '+cold.phone;
        if(cold.email!=null)
        body +='<br/>Email: '+cold.email;
        if(cold.homephone!=null)
        body +='<br/>Home Phone: '+cold.homephone;
        if(cold.mobilephone!=null)
        body +='<br/>Mobile: '+cold.mobilephone;
        body +='<br/><br/><b>New Contact Details: </b>';
        body +='<br/>Name: '+cnew.firstname+' '+cnew.lastname;
        if(cnew.phone!=null)
        body +='<br/>Phone: '+cnew.phone;
        if(cnew.email!=null)
        body +='<br/>Email: '+cnew.email;  
        if(cnew.homephone!=null)
        body +='<br/>Home Phone: '+cnew.homephone;
        if(cnew.mobilephone!=null)
        body +='<br/>Mobile: '+cnew.mobilephone;      
        body +='<br/><br/>Regards,<br/>Salesforce Admin';
        body +='</pre></body></html>';        
        email.setSubject( subject );
        useremaillist.add('leena.nandimandalam@wipro.com');
        email.setToAddresses(UseremailList);
        email.sethtmlbody( body );
        Messaging.SendEmailResult [] r = 
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        }catch(Exception e){
                system.debug(' $ Exception in sending Mail $$ ');
        }
       
    }
}