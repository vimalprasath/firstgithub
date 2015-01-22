public class LeadTrgg_CL{
@future    
    public static void CO_Insertnew_Lead(Set<id> setids){
        List<Lead> listnoteLeads = new List<Lead>();
        listnoteLeads = [select id,Notes__c,Notes_Type__c from Lead where id in: setids limit 1000];
        if (!FollowUpEventHelper.hasAlreadyCreatedFollowUpLeads()) {
            Notes n = new Notes();
            n.createInsertNotes(listnoteLeads);    
            FollowUpEventHelper.setAlreadyCreatedFollowUpLeads();
        }     
    }
@future
    public static void CO_Updatenew_Lead(Set<id> setids,map<id,string> mapnotestype,map<id,string> mapnotes){
        Notes__c NewNote1;
        List<Lead> listnoteLeads = new List<Lead>();
        List<Notes__c> insertNotes = new List<Notes__c>();
        listnoteLeads = [select id,Notes__c,Notes_Type__c from Lead where id in: setids limit 1000];
        for(integer i = 0 ; i< listnoteLeads.size(); i++){                           
            if((listnoteLeads[i].Notes__c != null || listnoteLeads[i].Notes__c != '' || listnoteLeads[i].Notes_Type__c != null) &&((mapnotestype.get(listnoteLeads[i].id)!=null && listnoteLeads[i].Notes_Type__c != mapnotestype.get(listnoteLeads[i].id)) || (mapnotes.get(listnoteLeads[i].id)!=null && listnoteLeads[i].Notes__c !=  mapnotes.get(listnoteLeads[i].id))) ){
                NewNote1 = new Notes__c(
                Lead__c = listnoteLeads[i].id,               
                Comments__c = listnoteLeads[i].Notes__c,
                Comments_List__c = listnoteLeads[i].Notes_Type__c                                    
                );   
                insertNotes.add(NewNote1); 
            } 
        }
        if(insertNotes.size()>0)
            insert insertNotes; 
    }
}