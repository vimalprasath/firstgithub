trigger RealtorContact_trg on Contact (after insert, after update) {
    List<Realtor_Contacts__c> listRC = new List<Realtor_Contacts__c>();
    List<Realtor_Contacts__c> listdelRC = new List<Realtor_Contacts__c>();
    List<Realtor_Contacts__c> existedlistRC = new List<Realtor_Contacts__c>();
    set<string> setconids = new set<string>();
    Map<string,Realtor_Contacts__c> mapRc = new Map<string,Realtor_Contacts__c>();
    for(Contact c:trigger.new){
        setconids.add(c.id);
    }
    if(setconids!=null && setconids.size()>0){
        existedlistRC = [select id,email__c,contact__c,ownerid,deactivate__c from Realtor_Contacts__c where contact__c in:setconids];
    }
    for(Realtor_Contacts__c r:existedlistRC){
        mapRc.put(r.contact__c,r);
    }
    for(Contact con:trigger.new){
        if(con.Contact_Type__c=='Realtor'){
            Realtor_Contacts__c rc;
            if(mapRC!=null && mapRC.containsKey(con.id))
                rc = new Realtor_Contacts__c(id = mapRC.get(con.id).id);
            else
                rc = new Realtor_Contacts__c();
            
            rc.name=con.Firstname+' '+con.lastname;
            rc.email__c = con.email;
            rc.contact__c = con.id;
            rc.ownerid=con.ownerid;
            rc.Deactivate__c=con.InActive__c;
            rc.Mailing_City__c=con.Mailingcity;
            rc.Mailing_Country__c=con.Mailingcountry;
            rc.Mailing_State_Province__c=con.Mailingstate;
            rc.Mailing_Street__c=con.Mailingstreet;
            rc.Mailing_ZIP_Postal_Code__c=con.MailingPostalcode;
            rc.Mobile_Phone__c=con.MobilePhone;
            rc.Notes__c=con.Notes__c;
            rc.Fax__c=con.Fax;
            rc.Home_Phone__c=con.HomePhone;
            rc.Birth_Date__c=con.Birthdate;
            rc.Contact_Type__c=con.Contact_Type__c;
            rc.phone__c=con.phone;
            
            listRC.add(rc);
        } 
        else if(trigger.isupdate && trigger.oldmap.get(con.id).Contact_Type__c=='Realtor' && con.Contact_Type__c!='Realtor'){
            if(mapRC!=null && mapRC.containsKey(con.id)){
                listdelRC.add(mapRC.get(con.id));
            }
            
        }
    }
    if(listRC!=null && listRC.size()>0)
        upsert listRC;
    if(listdelRC!=null && listdelRC.size()>0)
        delete listdelRC;
    set<string> conids = new set<string>(); 
    List<Contact_Management__c> listCM = new List<Contact_Management__c>(); 
    List<Realtor_Contacts__c> listRCu = new List<Realtor_Contacts__c>();
    List<Realtor_Contact_Management__c> listrcminsert = new List<Realtor_Contact_Management__c>(); 
    Map<string,Realtor_Contacts__c> mapconRc = new Map<string,Realtor_Contacts__c>();
    if(trigger.isUpdate){
        for(Contact con:trigger.new){
            if(trigger.oldmap.get(con.id).Contact_Type__c!='Realtor' && con.Contact_Type__c=='Realtor' ){
                conids.add(con.id);
            }
        } 
        if(conids!=null && conids.size()>0){
            listCM = [select Lead__c, contact__c from Contact_Management__c where contact__c in :conids];
            listRCu = [select contact__c,id from Realtor_Contacts__c where contact__c in :conids];
        
            for(Realtor_Contacts__c rc:listRCu){
                mapconRC.put(rc.contact__c, rc);
            }
            if(listCM !=null && listCM.size()>0){
                for(Contact_Management__c cm:listCM){
                    Realtor_Contact_Management__c rcm = new Realtor_Contact_Management__c();
                    rcm.Realtor_Contact__c = mapconRC.get(cm.contact__c).id;
                    rcm.lead__c = cm.lead__c ;
                    listrcminsert.add(rcm);
                }
            }  
            if(listrcminsert!=null && listrcminsert.size()>0)
                insert listrcminsert;
            if(listCM!=null && listCM.size()>0) 
                delete listCM;
        }
    }
    
    
    List<contact> Dupcheckcon = new List<contact>();  
        for(Contact c:trigger.new){
            if((trigger.isInsert && c.Contact_Type__c=='Realtor') || (trigger.isUpdate && trigger.oldmap.get(c.id).Contact_Type__c!='Realtor' && c.Contact_Type__c=='Realtor')){
                Dupcheckcon.add(c);
            }
        }
        if(Dupcheckcon!=null && Dupcheckcon.size()>0)
            CO_SendDupContactMail.CO_DupContact_method(Dupcheckcon);       
    
}