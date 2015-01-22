trigger CountofLeads on Realtor_Contact_Management__c (after insert, after delete) {
    set<id> setRCid=new set<id>();
    List<Realtor_Contacts__c> listRC = new List<Realtor_Contacts__c>();
    List<Realtor_Contacts__c> listRCupdate = new List<Realtor_Contacts__c>();
    List<Realtor_Contact_Management__c> listRcm = new List<Realtor_Contact_Management__c>();
    map<Id, List<Realtor_Contact_Management__c>> parentAndChildren = new map<Id, List<Realtor_Contact_Management__c>>();   
    List<Realtor_Contact_Management__c> children;
    if(trigger.isInsert){
        for(Realtor_Contact_Management__c rcm:trigger.new){
            setRCid.add(rcm.Realtor_Contact__c);
        }
    }
    if(trigger.isDelete){
        for(Realtor_Contact_Management__c rcm:trigger.old){
            setRCid.add(rcm.Realtor_Contact__c);
        }
    }
    if(setRCid!=null && setRCid.size()>0){
        listRC = [ select id,No_of_Leads__c from Realtor_Contacts__c where id in: setRCid];
        listrcm = [ select id,realtor_contact__c from Realtor_Contact_Management__c where realtor_contact__c in:setRCid];
    }
    for(Realtor_Contact_Management__c rcm : listrcm) {  
       children = parentAndChildren.containsKey(rcm.realtor_contact__c) ? parentAndChildren.get(rcm.realtor_contact__c) : new List<Realtor_Contact_Management__c>();
       children.add(rcm);
       parentAndChildren.put(rcm.realtor_contact__c, children);
    }
    for(Realtor_Contacts__c rc:listRC){
        if(parentAndChildren.containskey(rc.id)){
            rc.No_of_Leads__c = parentAndChildren.get(rc.id).size();
            listrcupdate.add(rc);
        }
    }
    if(listrcupdate!=null && listrcupdate.size()>0)
        update listrcupdate;
  /*  map<Id, List<Realtor_Contact_Management__c>> parentAndChildren = new map<Id, List<Realtor_Contact_Management__c>>();   
    for(Realtor_Contacts__c rc : listRC) {        
        children = parentAndChildren.containsKey(rc.id) ? parentAndChildren.get(rc.id) : new List<Realtor_Contact_Management__c>();
        children.add(rc);
        parentAndChildren.put(rc.id, children);
    }*/
}