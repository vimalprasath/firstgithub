@isTest
public class TestOpportunityMasterTrigger {
  
  static testMethod void OpportunityMasterTriggertest() {
  //inserting user with SOFI API profile
  Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
  
    Userrole  r = [select id from userrole where name='System Administrator'];
    
     User u = new User(Alias = 'standt', Email='standarduser@testorg.com',EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='CapitalOne@test.com.CapitalOne',CommunityNickname='standarduser',userroleid=r.id);
     system.runas(u){
    
   //inserting account and related opportunity
   Recordtype R1 = [select id from recordtype where name = 'Customer' AND SobjectType = 'Account'];   
   account acc =  new account(lastname='Doe',recordtypeid=r1.id);
   insert acc;
  
   opportunity  opp = new opportunity(accountid=acc.id,name = 'test name',Empower_Lead_ID__c ='TestEID12334',StageName='Offer Not Accepted',CloseDate=System.today(),Related_Lead__c = null);
   insert opp;
    
   update opp;
    }
     
    
  }
}