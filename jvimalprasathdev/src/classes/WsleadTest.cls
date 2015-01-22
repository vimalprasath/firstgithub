@isTest
public class WsleadTest {
  
  static testMethod void wsleadtest()
  {
  Opportunity op= new opportunity( Name='John Doe',StageName='Offer Not Accepted',CloseDate=system.today(),Empower_Lead_ID__c ='TestEID12334',Property_State__c ='TX',loan_purpose__c ='test',loan_type__c='test');
  insert op;
  

    wslead.UpdateLoanStatus ttf = new  wslead.UpdateLoanStatus();
    wslead.updatelead(ttf);
    ttf.EmpowerID = 'TestEID12334';
    ttf.OpportunityStatus = 'Open';
    wslead.updatelead(ttf);
   

   Opportunity[] opp = [select Empower_Lead_ID__c from Opportunity where Empower_Lead_ID__c = 'TestEID12334'];
   

   string EmpowerID = 'emp123';
   string LeadStatus = 'Open';
   wslead.UpdateLoanStatus led = new wslead.UpdateLoanStatus(); 
  }
  
  
  
  static testMethod void wsleadtest1() {
   Opportunity op2= new opportunity(Name='John Doe',StageName='Offer Not Accepted',CloseDate=system.today(),Empower_Lead_ID__c ='TestEID12334',Property_State__c ='TX',loan_purpose__c ='test',loan_type__c='test');
  insert op2;
  
  wslead.UpdateeidField ttf = new  wslead.UpdateeidField();
    ttf.OpportunityID = 'TestEI';
    wslead.updateEID(ttf);
    ttf.OpportunityID = 'TestEID12334';
    ttf.loanID= '123456789';
    wslead.updateEID(ttf);
}
  
 static testMethod void wsleadtest2() {
  Opportunity op1= new opportunity(Name='John Doe',StageName='Offer Not Accepted',CloseDate=system.today(),Empower_Lead_ID__c ='TestDID12335',Property_State__c ='TX',loan_purpose__c ='test',loan_type__c='test');
  insert op1;
  
    wslead.UpdateeidField ttf = new  wslead.UpdateeidField();
    ttf.OpportunityID ='TestDID12335';
    ttf.loanID='TestEID12335';
    wslead.updateEID(ttf);
    ttf.OpportunityID ='TestEID12334';
    wslead.updateEID(ttf);
 
     
  }
}