@istest
private class LeadScoringBatchInitialize_Test{
    static testMethod void LeadScoringBatchInitialize_method1(){
        LeadScoringBatchInitialize lsb= new LeadScoringBatchInitialize();
        lsb.autoRun();
        lsb.autoRunCampaignMembers(1);
        lsb.autoRunLeads(1);
    }
}