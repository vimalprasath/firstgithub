@istest
public Class CO_SendDupContactMail_TestClass{
    Static testmethod void CloseLead_Test(){
        Contact con1= new Contact(lastname='testc1',phone='(999) 999-9999',Contact_Type__c='Realtor',mailingpostalcode='77777',email='test@test.com',homephone='(999) 999-9998',mobilephone='(999) 999-9998');
        insert con1;
        List<contact> Listcontacts =new List<contact>();
        Listcontacts.add(con1);
        CO_SendDupContactMail.CO_DupContact_method(Listcontacts);
        Listcontacts.clear();
        
        //con1.lastname='testc2';
        //update con1;
        Contact con2= new Contact(lastname='testc1',phone='(999) 999-9999',Contact_Type__c='Realtor',mailingpostalcode='77777',email='test@test.com',homephone='(999) 999-9998',mobilephone='(999) 999-9998');
        insert con2;
        Listcontacts.add(con2);
        CO_SendDupContactMail.CO_DupContact_method(Listcontacts);
        Listcontacts.clear();
        
        //con2.lastname='testc2';
        //update con2;
        Contact con3= new Contact(lastname='testc1',Contact_Type__c='Realtor',mailingpostalcode='77777',homephone='(999) 999-9998');
        insert con3;
        Listcontacts.add(con3);
        CO_SendDupContactMail.CO_DupContact_method(Listcontacts);
        Listcontacts.clear();
        
        Contact con4= new Contact(lastname='testc1',Contact_Type__c='Realtor',mailingpostalcode='77777',mobilephone='(999) 999-9998');
        insert con4;
        Listcontacts.add(con4);
        CO_SendDupContactMail.CO_DupContact_method(Listcontacts);
        
        system.debug('homephone='+con1.homephone);
        system.debug('homephone_old='+con2.homephone);
        system.debug('mobilephone='+con1.mobilephone);
        system.debug('mobilephone_old='+con2.mobilephone);
        
        /*
        user u = new user(email='test@test.com');
        insert u;
        list<user> userlist = new list<user>();
        userlist.add(u);
        list<string> useremaillist= new list<string>();
        useremaillist.add(userlist);
        CO_SendDupContactMail.sendEmail2ConMgr(con1,con2,useremaillist);*/
        
        
        
        /*List<contact> Listcontacts =new List<contact>();
        Listcontacts.add(con1);
        CO_SendDupContactMail.CO_DupContact_method(Listcontacts);*/
        
    }
}