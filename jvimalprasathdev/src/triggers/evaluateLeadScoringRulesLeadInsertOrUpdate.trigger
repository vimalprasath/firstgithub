trigger evaluateLeadScoringRulesLeadInsertOrUpdate on Lead (before insert, before update) {

//    Set<Id> leadIds=new Set<Id>();
//    Map<Id, Double> leadScores=new Map<Id,Double>();    

    //Needed as asynch apex does not allow passage of Sobjects, only Set's
//    for (Lead l:trigger.new){
//        leadIds.add(l.Id);
//    }//for

    //Send that list of created or updated campaign members to the apex class for processing
//    system.debug('Leads lead scoring method already called? '+LeadScoring.evaluateLeadsAlreadyCalled());
    if (LeadScoring.evaluateLeadsAlreadyCalled()==False){
            Boolean batchUpdate=FALSE;
            LeadScoring.evaluateLeads(trigger.new, batchUpdate);    
    }//if 1  
    
//    system.debug('Leads lead scoring method already called? '+LeadScoring.evaluateLeadsAlreadyCalled());
      
}//trigger