/*
Author: Vimal 
Description: Whenever the Account Owner is updated, the trigger from Account will call this class and will update the Channel field in opportunity.
For the story #B563968
*/

public class Opportunityowner{
    
    public static void updateOpportunityChannel(Map<Id, Account> accountMap){
        
        List<Opportunity> updateOppList = new List<Opportunity>();
        for(Opportunity opp:[select id,ownerId,accountId,owner.employeenumber,owner.userrole.name from Opportunity where accountId in:accountMap.keyset()]){
            
            if(opp.ownerId==accountMap.get(opp.accountId).ownerId){
                opp.Opportunity_Owner_EID__c=opp.owner.employeenumber;
                String ownerRole=opp.Owner.UserRole.Name;
                if (!ownerRole.Contains('Home Equity') && !ownerRole.Contains('CRA') && !ownerRole.Contains('Distributed') && !ownerRole.Contains('Screener')){
                    opp.channel__c='Centralized Retail';
                }
                else if(ownerRole.Contains('Distributed')){
                    opp.channel__c='Distributed Retail';
                }
                else if(ownerRole.Contains('Home Equity')){
                    opp.channel__c='Home Equity';
                }
                else if(ownerRole.Contains('CRA')){
                    opp.channel__c='Neighborhood Lending';
                }
                
                updateOppList.add(opp);
            }
            
        }
        
        update updateOppList;
        
    }

}