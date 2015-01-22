trigger evaluateLeadScoringRulesCMInsertOrUpdate on CampaignMember (after insert, after update) {
//    Set<Id> CampaignMemberIds=new Set<Id>();
     
    //Loop needed as asynch apex does not allow passage of Sobjects, only Set's
//    for (CampaignMember cm:trigger.new){
//        CampaignMemberIds.add(cm.Id); 
//    }//for

    //Send that list of created or updated campaign members to the apex class for processing
    //system.debug('CMs lead scoring method class already called? '+LeadScoring.evaluateCMsAlreadyCalled());

    if (LeadScoring.evaluateCMsAlreadyCalled()==False){
            LeadScoring.evaluateCMs(trigger.new);    
    }
//    system.debug('CMs lead scoring method class already called? '+LeadScoring.evaluateCMsAlreadyCalled());
}