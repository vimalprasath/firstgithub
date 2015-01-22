/*
Author: Vimal 
Description: Whenever the Account Owner is updated, this trigger will update the Channel field in opportunity.
For the story #B563968
*/

trigger AccountOpportunityOwnerUpdate on Account (after update) {
    
    Map<id,Account> accountmap= new Map<id,Account>();
    for(Account newAcc:trigger.new){
        Account oldAcc = Trigger.oldMap.get(newAcc.Id);
        if(oldAcc.ownerId<>newAcc.OwnerId){
                accountMap.put(newAcc.id,newAcc);
        }   
    }
    OpportunityOwner.updateOpportunityChannel(accountMap);
}