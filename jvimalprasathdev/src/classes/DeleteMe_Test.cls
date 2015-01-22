@isTest
public class DeleteMe_Test{
    /*
    public static testmethod void DeleteMe_method1(){
        DeleteMe.evaluateLeadsAlreadyCalled = false;
        DeleteMe.evaluateLeadsAlreadyCalled();
        DeleteMe.setEvaluateLeadsAlreadyCalled(false);
        DeleteMe.evaluateCMsAlreadyCalled();
        DeleteMe.setEvaluateCMsAlreadyCalled(false);
        list<lead> tl= [select id from lead limit 1];
        list<lead> cms= [select id,Campaign_Score__c from lead limit 1];
        //list<lead> tl = new list<lead>();
        DeleteMe.evaluateLeads(tl, true);
        list<CampaignMember> cs= [select campaign_score__c from CampaignMember limit 1];
        DeleteMe.evaluateCMs(cs);
        Set<Id> ids = (new Map<Id, Lead>([SELECT Id,campaign_score__c FROM Lead])).keySet();
        DeleteMe.updateLeads(ids);
        map<id,double> leadscores = new map<id,double>();
        list<string> fnames = new list<string>();
        list<lead> fna=[select name from lead limit 1];
        for(lead l:fna){
            fnames.add(l.Name);
        }
        for(lead l : cms){
            leadscores.put(l.id,l.Campaign_Score__c);
        }
        //DeleteMe.updateLeads(IDs,leadScores);
        DeleteMe.getRuleFieldNames(fnames);
        campaignmember[] cm=[select id from campaignmember limit 1];
        list<campaignmember> camp=[select id,LeadId, Campaign_Score__c from campaignmember limit 1];
        DeleteMe.updateCMs(cm);
        DeleteMe.deletedCMs(camp);
        DeleteMe.evaluateCriteria(null, 'equals', null, schema.DisplayType.STRING);
    }
    public static testmethod void DeleteMe_method2(){
        DeleteMe.evaluateLeadsAlreadyCalled = true;
        DeleteMe.evaluateLeadsAlreadyCalled();
        DeleteMe.setEvaluateLeadsAlreadyCalled(true);
        DeleteMe.evaluateCMsAlreadyCalled();
        DeleteMe.setEvaluateCMsAlreadyCalled(true);
        list<lead> tl= [select id from lead limit 1];
        list<lead> cms= [select id,Campaign_Score__c from lead limit 1];
        //list<lead> tl = new list<lead>();
        DeleteMe.evaluateLeads(tl, true);
        list<CampaignMember> cs= [select id,campaign_score__c from CampaignMember limit 1];
        LeadScoringRule__c lsco = new LeadScoringRule__c();
        lsco.Active__c = true;
        for(CampaignMember cm:cs)
        {
            lsco.Campaign__c = cm.id;
        }
        lsco.Field_Name__c = 'text';
        lsco.Type__c = 'Campaign Member';
        DeleteMe.activeLeadScoringRuleDetails('Campaign Member');
        DeleteMe.evaluateCMs(cs);
        Set<Id> ids = (new Map<Id, Lead>([SELECT Id,campaign_score__c FROM Lead])).keySet();
        DeleteMe.updateLeads(ids);
        map<id,double> leadscores = new map<id,double>();
        list<string> fnames = new list<string>();
        list<lead> fna=[select name from lead limit 1];
        for(lead l:fna){
            fnames.add(l.Name);
        }
        for(lead l : cms){
            leadscores.put(l.id,l.Campaign_Score__c);
        }
        //DeleteMe.updateLeads(IDs,leadScores);
        DeleteMe.getRuleFieldNames(fnames);
        campaignmember[] cm=[select id from campaignmember limit 1];
        list<campaignmember> camp=[select id,LeadId, Campaign_Score__c from campaignmember limit 1];
        DeleteMe.updateCMs(cm);
        DeleteMe.deletedCMs(camp);
        string equals = 'not equal to';
        DeleteMe.evaluateCriteria(null,equals,'ABC',null);
    }
   */ 
    public static testmethod void DeleteMe_method10(){
        string equals = 'greater than';
        DeleteMe.evaluateCriteria(null,equals, 'ABC', null);
    }
    public static testmethod void DeleteMe_method3(){
        string equals = 'less than';
        DeleteMe.evaluateCriteria(null,equals, 'ABC', null);
    }
    public static testmethod void DeleteMe_method4(){
        string equals = 'greater or equal';
        DeleteMe.evaluateCriteria(null,equals, 'ABC', null);
    }
    public static testmethod void DeleteMe_method5(){
        string equals = 'less or equal';
        DeleteMe.evaluateCriteria(null,equals, null, null);
    }
    public static testmethod void DeleteMe_method6(){
        string equals = 'contains';
        DeleteMe.evaluateCriteria(null,equals, null, null);
    }
    public static testmethod void DeleteMe_method7(){
        string equals = 'does not contain';
        DeleteMe.evaluateCriteria(null,equals, null, null);
    }
    public static testmethod void DeleteMe_method8(){
        string equals = 'starts with';
        DeleteMe.evaluateCriteria(null,equals, null, null);
    }
}