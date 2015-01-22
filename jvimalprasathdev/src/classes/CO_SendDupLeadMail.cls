/*
Name: CO_SendDupLeadMail
Author: Leena N
Description: This Class is used to send email to lead manager when 2/4 fields match
Last modified by: Leena N
*/
public with sharing class CO_SendDupLeadMail{
    public static void CO_DupLead_method(List<Lead> ListLeads){
        //Declaration of variables
        Set<string> setLeadFirstname =new set<string>();
        Set<string> setLeadLastname =new set<string>();
        Set<string> setLeadPhone =new set<string>();
        Set<string> setLeadEmail =new set<string>();
        Set<id> setLeadids =new set<id>();
        Set<String> setusername=new Set<String>();
        Map<String,User> mapMgr=new Map<String,User>();
        list<Lead> Leadslist=new list<Lead>();
        List<User> UserList= new List<User>();
        
        for(Lead ld:ListLeads){
            SetLeadids.add(ld.id);
            setLeadfirstname.add(ld.firstname);
            setLeadLastname.add(ld.lastname);
            setLeadPhone.add(ld.Borrowers_Home_Phone__c);
            setLeadEmail.add(ld.email);            
        }
        //Getting the list of leads with inserted name/phone/email/address
        if(SetLeadids!=null && SetLeadids.size()>0)
            Leadslist = [select id,Salesforce_Lead_Number__c,ownerid,owner.username,owner.Firstname,owner.lastname,CreatedDate,name,Empower_Lead_ID__c,FirstName,LastName,Phone,email,Borrowers_Home_Phone__c,BorrowersHouse__c,Borrowers_Apt__c,Borrowers_Address_1__c,Borrowers_Address_2__c,
                         Borrowers_Zip_Postal_Code__c,Borrowers_City__c,Borrowers_Country__c,Borrowers_County__c,Borrowers_State__c from Lead where id not in:SetLeadids and (FirstName in: setLeadfirstname 
                         or LastName in: setLeadLastname or Borrowers_Home_Phone__c in: setLeadPhone or email in: setLeadEmail) order by createddate limit 1000];
                         
        for(Lead mgrld:Leadslist){
            setusername.add(mgrld.owner.username);
        }
        UserList = [select id,name,manager.name,managerid,manager.email,username,email from User where  username in:setusername];
        for(User u:UserList){
            mapMgr.put(u.username,u);
        }
        
        //Finding 2/4 fields matching criteria
        if(Leadslist!=null && Leadslist.size()>0){
             for(Lead ld:ListLeads){
                 for(Lead aeld:Leadslist){
                     if(ld.firstname!=null && ld.lastname!=null && ld.Borrowers_Home_Phone__c!=null && ld.firstname == aeld.firstname && ld.lastname == aeld.lastname && ld.Borrowers_Home_Phone__c == aeld.Borrowers_Home_Phone__c){                        
                         system.debug('sssssssssssssss'+ld.ownerid);                                                                                         
                         if(ld.ownerid!=aeld.ownerid && mapMgr.get(aeld.owner.username)!=null)  { 
                             sendEmail2LeadMgr(aeld,ld,mapMgr);
                         }                                                     
                         break;
                     }else if(ld.firstname!=null && ld.lastname!=null && ld.email!=null && ld.firstname == aeld.firstname && ld.lastname == aeld.lastname && ld.email == aeld.email){                                                               
                         if(ld.ownerid!=aeld.ownerid && mapMgr.get(aeld.owner.username)!=null)  { 
                             sendEmail2LeadMgr(aeld,ld,mapMgr);
                         }                               
                         break;
                     }
                     else if(ld.Borrowers_Home_Phone__c!=null && ld.email!=null && ld.Borrowers_Home_Phone__c== aeld.Borrowers_Home_Phone__c && ld.email == aeld.email){                                                               
                         if(ld.ownerid!=aeld.ownerid && mapMgr.get(aeld.owner.username)!=null)  { 
                             sendEmail2LeadMgr(aeld,ld,mapMgr);
                         }                               
                         break;
                     } else if(ld.Borrowers_Home_Phone__c!=null && ld.Borrowers_Home_Phone__c== aeld.Borrowers_Home_Phone__c && ld.BorrowersHouse__c!=null && ld.Borrowers_Apt__c!=null && ld.Borrowers_Address_1__c!=null && ld.Borrowers_Address_2__c!=null && ld.Borrowers_Zip_Postal_Code__c!=null 
                        && ld.Borrowers_City__c!=null && ld.Borrowers_Country__c!=null && ld.Borrowers_County__c!=null && ld.Borrowers_State__c!=null && ld.BorrowersHouse__c == aeld.BorrowersHouse__c && ld.Borrowers_Apt__c == aeld.Borrowers_Apt__c && ld.Borrowers_Address_1__c == aeld.Borrowers_Address_1__c
                        && ld.Borrowers_Address_2__c == aeld.Borrowers_Address_2__c && ld.Borrowers_Zip_Postal_Code__c == aeld.Borrowers_Zip_Postal_Code__c && ld.Borrowers_City__c == aeld.Borrowers_City__c && ld.Borrowers_Country__c == aeld.Borrowers_Country__c 
                        && ld.Borrowers_County__c == aeld.Borrowers_County__c && ld.Borrowers_State__c == aeld.Borrowers_State__c){                                                               
                         if(ld.ownerid!=aeld.ownerid && mapMgr.get(aeld.owner.username)!=null)  { 
                             sendEmail2LeadMgr(aeld,ld,mapMgr);
                         }                             
                         break;
                     }else if(ld.firstname!=null && ld.lastname!=null && ld.firstname == aeld.FirstName && ld.lastname == aeld.lastname && ld.BorrowersHouse__c!=null && ld.Borrowers_Apt__c!=null && ld.Borrowers_Address_1__c!=null && ld.Borrowers_Address_2__c!=null && ld.Borrowers_Zip_Postal_Code__c!=null 
                        && ld.Borrowers_City__c!=null && ld.Borrowers_Country__c!=null && ld.Borrowers_County__c!=null && ld.Borrowers_State__c!=null && ld.BorrowersHouse__c == aeld.BorrowersHouse__c && ld.Borrowers_Apt__c == aeld.Borrowers_Apt__c && ld.Borrowers_Address_1__c == aeld.Borrowers_Address_1__c
                        && ld.Borrowers_Address_2__c == aeld.Borrowers_Address_2__c && ld.Borrowers_Zip_Postal_Code__c == aeld.Borrowers_Zip_Postal_Code__c && ld.Borrowers_City__c == aeld.Borrowers_City__c && ld.Borrowers_Country__c == aeld.Borrowers_Country__c 
                        && ld.Borrowers_County__c == aeld.Borrowers_County__c && ld.Borrowers_State__c == aeld.Borrowers_State__c){                                                               
                         if(ld.ownerid!=aeld.ownerid && mapMgr.get(aeld.owner.username)!=null)  { 
                             sendEmail2LeadMgr(aeld,ld,mapMgr);
                         }                               
                         break;
                     }else if(ld.email!=null && ld.email== aeld.email && ld.BorrowersHouse__c!=null && ld.Borrowers_Apt__c!=null && ld.Borrowers_Address_1__c!=null && ld.Borrowers_Address_2__c!=null && ld.Borrowers_Zip_Postal_Code__c!=null 
                        && ld.Borrowers_City__c!=null && ld.Borrowers_Country__c!=null && ld.Borrowers_County__c!=null && ld.Borrowers_State__c!=null && ld.BorrowersHouse__c == aeld.BorrowersHouse__c && ld.Borrowers_Apt__c == aeld.Borrowers_Apt__c && ld.Borrowers_Address_1__c == aeld.Borrowers_Address_1__c
                        && ld.Borrowers_Address_2__c == aeld.Borrowers_Address_2__c && ld.Borrowers_Zip_Postal_Code__c == aeld.Borrowers_Zip_Postal_Code__c && ld.Borrowers_City__c == aeld.Borrowers_City__c && ld.Borrowers_Country__c == aeld.Borrowers_Country__c 
                        && ld.Borrowers_County__c == aeld.Borrowers_County__c && ld.Borrowers_State__c == aeld.Borrowers_State__c){                                                               
                         if(ld.ownerid!=aeld.ownerid && mapMgr.get(aeld.owner.username)!=null)  { 
                             sendEmail2LeadMgr(aeld,ld,mapMgr);
                         }                                
                         break;
                     }                                  
                 }
             }
         }    
    }
    
    //method to send email to lead manager
    public static void sendEmail2LeadMgr(Lead acc, Lead ld,Map<String,User> mapMgr){
        String[] toAdd =  new string[]{mapMgr.get(acc.owner.username).manager.email};
        String subject = 'Lead Owner Assignment';
        String body;
        
        map<id,string> mapuser = new map<id,string>();
        list<user> UserList2 = new list<user>(); 
        try{
        Profile pf = [Select Id from profile where Name='Authenticated Portal Website'];
        UserList2 = [select id,name from User where isactive = true and profileid != :pf.id];
        for(User u:UserList2){
            mapuser.put(u.id,u.name);
        }
        
        
        system.debug('********ld************'+ld);
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        body ='<html><body><pre>'; 
        body += 'Hi '+mapMgr.get(acc.owner.username).manager.name+',';
        body +='<br/><br/>A potential duplicate lead for '+ld.firstname+' '+ld.lastname+' has been created by '+mapuser.get(ld.Ownerid)+'.' ;
        body +='<br/>This account is currently owned by '+acc.Owner.FirstName+' '+acc.Owner.LastName+' with the most recent lead creation date of: '+ acc.CreatedDate +'.';
        body +='<br/><br/>In order to have the new lead re-assigned, please follow the below steps:';
        body +='<br/><br/>1. Inform the creating MC and MC\'s direct manager of existing lead.';
        body +='<br/>2. Contact the system administrator in order to re-assign the new lead.';
        body +='<br/><br/>Existing Lead #: '+acc.Salesforce_Lead_Number__c;
        body +='<br/>New Lead #: '+ld.Salesforce_Lead_Number__c;
        body +='<br/>Customer Email Address: '+ld.Email;
        body +='<br/><br/>Regards,<br/>Salesforce Admin';
        body +='</pre></body></html>';        
        email.setSubject( subject );
        email.setToAddresses(toAdd);
        email.sethtmlbody( body );
        Messaging.SendEmailResult [] r = 
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        }catch(Exception e){
                system.debug(' $ Exception in sending Mail $$ ');
        }
       
    }
}