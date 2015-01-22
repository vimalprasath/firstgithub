@istest(seeAllData = true)
public class wsLead_Test{
    public static testMethod void wsLead_TestMethod(){
    String EmpowerID = '244';
    String OpportunityStatus = 'Acitve 1';
     Opportunity opp = new Opportunity();
     opp.name = 'ABC';
     opp.Channel__c = 'Centralized Retail';
     opp.Channel_Sources__c = 'Web';
     opp.Channel_Values__c = 'Google';
     opp.CloseDate = date.today();
     opp.Applicant_Type__c = 'Individual';
     opp.StageName = 'Prospecting';
     opp.Occupancy_Code__c = 'Owner Occupied';
     opp.Loan_Type__c = 'HE';
     opp.Requested_Loan_Amount__c = 5456;
     opp.Loan_Status__c = 'Active';
     opp.Empower_Lead_ID__c = '2442';
     insert opp;
     
     /*opp.Loan_Status__c = OpportunityStatus;
     opp.Empower_Lead_ID__c = OpportunityStatus;
     update opp;*/
     
     wsLead.UpdateLoanStatus ws = new wsLead.UpdateLoanStatus();
     list<String> res = new list<string>();
     res = wsLead.updateLead(ws);
     ws.OpportunityStatus = 'Active';
     ws.EmpowerID = '2442';
     ws.AppraisedValue=1000;
     ws.ClosingDate=Date.today();
     ws.DisbursementDate=Date.today();
     ws.LoanAmount=100;
     ws.LoanPurpose='testpurpose';
     ws.LoanTerm='15';
     ws.LockExpirationDate=Date.today();
     res = wsLead.updateLead(ws);
     
    }
    
    public static testMethod void wsLead_TestMethod2(){
    String loanId = '2442';
     Opportunity opp = new Opportunity();
     opp.name = 'ABC';
     opp.Channel__c = 'Centralized Retail';
     opp.Channel_Sources__c = 'Web';
     opp.Channel_Values__c = 'Google';
     opp.CloseDate = date.today();
     opp.Applicant_Type__c = 'Individual';
     opp.StageName = 'Prospecting';
     opp.Occupancy_Code__c = 'Owner Occupied';
     opp.Loan_Type__c = 'HE';
     opp.Requested_Loan_Amount__c = 5456;
     opp.Loan_Status__c = 'Active';
     opp.Empower_Lead_ID__c = '2442';
     insert opp;
     
     opp.Empower_Lead_ID__c = loanId;
     update opp;
     
     /*opp.Loan_Status__c = OpportunityStatus;
     opp.Empower_Lead_ID__c = OpportunityStatus;
     update opp;*/
     
     wsLead.UpdateeidField ws = new wsLead.UpdateeidField();
     list<String> res = new list<string>();
     res = wsLead.updateEID(ws);
     ws.OpportunityId = opp.id;
     ws.loanId = '2442';
     //ws.Empower_Lead_ID__c = '2442';
     res = wsLead.updateEID(ws);
     
    }
    
}