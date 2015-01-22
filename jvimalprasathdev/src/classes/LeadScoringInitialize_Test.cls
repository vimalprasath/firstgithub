@IsTest
public class LeadScoringInitialize_Test{
public static testMethod void LeadScoringInitialize_method() {
        //Use the PageReference Apex class to instantiate a page
        PageReference pageRef = Page.LeadScoringSetup;
        test.startTest();
        Test.setCurrentPage(pageRef);
        LeadScoringBatchInitialize ctr = new LeadScoringBatchInitialize();
        ctr.autoRunLeads(10);
    	LeadScoringInitialize c = new LeadScoringInitialize();
    	c.leadQuery = 'asdada';
        test.stopTest();
   }
}