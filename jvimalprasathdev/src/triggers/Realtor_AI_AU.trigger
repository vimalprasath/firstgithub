trigger Realtor_AI_AU on Realtor_Contacts__c (after insert,after update) {
    map<Id, List<Realtor_Contacts__c>> parentAndChildren = new map<Id, List<Realtor_Contacts__c>>();   
    List<Realtor_Contacts__c> children;
    List<Realtor_Contacts__c> listParent= new List<Realtor_Contacts__c>();
    List<Realtor_Contacts__c> listChildren = new List<Realtor_Contacts__c>();
    List<Realtor_Contacts__c> listUpdate = new List<Realtor_Contacts__c>();
    set<string> setrcids = new set<string>(); 
    system.debug('fffffffffff1111'+FollowUpEventHelper.hasAlreadyCreatedFollowUpLeads());
    if (!FollowUpEventHelper.hasAlreadyCreatedFollowUpLeads()) {
    system.debug('fffffffffff'+FollowUpEventHelper.hasAlreadyCreatedFollowUpLeads());
    for(Realtor_Contacts__c rc:trigger.new){
        if(rc.Realtor_Id__c!=null){
            setrcids.add(rc.Realtor_Id__c);
        }
            if(trigger.isUpdate){
                if(rc.Realtor_Id__c==null){
                    setrcids.add(rc.id);
                }
            }
         
    } 
    
    if(setrcids!=null && setrcids.size()>0){
    listParent = [select id,no_of_leads__c,total_no_of_leads__c from Realtor_Contacts__c where id in: setrcids];
    listChildren = [select id,Realtor_Id__c,no_of_leads__c from Realtor_Contacts__c where Realtor_Id__c in: setrcids];
    }
    for(Realtor_Contacts__c crc:listChildren){
        children = parentAndChildren.containsKey(crc.Realtor_Id__c) ? parentAndChildren.get(crc.Realtor_Id__c) : new List<Realtor_Contacts__c>();
        children.add(crc);
        parentAndChildren.put(crc.Realtor_Id__c, children);
    } 
    for(Realtor_Contacts__c prc:listParent){
        decimal totl=0;
        if(parentAndChildren.containskey(prc.id)){
            for(Realtor_Contacts__c nc:parentAndChildren.get(prc.id)){
                if(nc.no_of_leads__c==null)
                    nc.no_of_leads__c=0;
                totl=totl+nc.no_of_leads__c;
            }
          
        }
         if(prc.no_of_leads__c==null)
            prc.no_of_leads__c=0;
            system.debug('nnnnnnnnnnnnnnnn'+prc.no_of_leads__c);
        totl=totl+prc.no_of_leads__c;
        prc.total_no_of_leads__c=totl;
        listUpdate.add(prc);
        
        
    } 
    FollowUpEventHelper.setAlreadyCreatedFollowUpLeads();
    if(listUpdate!=null && listUpdate.size()>0)
        update listUpdate;  
    
   // system.debug('fffffffffff'+FollowUpEventHelper.setAlreadyCreatedFollowUpLeads());
    }
}