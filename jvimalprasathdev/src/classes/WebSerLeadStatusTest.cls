@isTest
public class WebSerLeadStatusTest {

static testMethod void WebSerLeadStatustest()
  {
  lead ld11 = new lead(lastname = 'test name', company ='test company', Empower_Lead_ID__c ='TestEID12334',Property_State__c ='TX',firstname='test name',loan_purpose__c ='test',loan_type__c='test',Borrowers_Home_Phone__c='(999) 999-9999');
  insert ld11;
  
    WebSerLeadStatus.UpdateLoanStatus ttf = new  WebSerLeadStatus.UpdateLoanStatus();
     boolean res = WebSerLeadStatus.updatelead(ttf);
    ttf.EmpowerID = 'TestEID12334';
    ttf.LeadStatus = 'Open';
    res = WebSerLeadStatus.updatelead(ttf);
  }
  }