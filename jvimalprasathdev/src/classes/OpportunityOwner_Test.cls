/* Test Class for OpportunityOwner Class and Account Trigger*/

@isTest
public class OpportunityOwner_Test {
  
  static testMethod void OpportunityOwnertest() {
  
    Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
  
    Userrole  r = [select id from userrole where name='Distributed Loan Officer Manager 1 RSM 1'];

    Userrole  r1 = [select id from userrole where name='Centralized Loan Officer Manager 1 RSM 1'];
    
    User u = new User(Alias = 'standt', Email='standarduser@testorg.com',EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='CapitalOne@test.com.CapitalOne',CommunityNickname='standarduser',userroleid=r.id);
    insert u;  

    User u1 = new User(Alias = 'standt1', Email='standarduser1@testorg.com',EmailEncodingKey='UTF-8', LastName='Testing2', LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='CapitalOne1@test.com.CapitalOne',CommunityNickname='standarduser1',userroleid=r1.id);
    insert u1;  
     system.runas(u){
    
       //inserting account and related opportunity
     //  Recordtype R1 = [select id from recordtype where name = 'Customer' AND SobjectType = 'Account'];   
       account acc =  new account(lastname='Testuser');
       insert acc;
      
       Opportunity opp = new Opportunity(accountid=acc.id,name = 'test name',StageName='Offer Not Accepted',CloseDate=System.today(),Related_Lead__c = null); 
       insert opp;
        
       acc.ownerid=u1.id;
       update acc;  
      // System.assertEquals(opp.channel__c,'Centralized Retail');

    }
     
    
  }
}