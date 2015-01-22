@isTest
public class CreateOpusID_Opp_Test{

public static testmethod void CreateOpusID_Opp_test_mehod(){


     user u=[select id from user limit 1];
     Recordtype R1 = [select id from recordtype where name = 'Business Account' AND SobjectType = 'Account'];
      User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];//Added by vimal
       System.runAs(thisuser){        //Added by vimal
     Account A = new Account( name = 'Test Account',Ownerid = u.id,recordtypeid=r1.id); 
     insert A;

Lead L = new lead();
L.status = 'Active';
L.Channel__c = 'Centralized Retail';
L.Channel_Sources__c = 'Bank';
L.Applicant_Type__c = 'Individual';
L.Channel_Values__c = 'RB Portal';
L.Internal_Referral__c = 'N/A';
L.Borrowers_Current_Residence__c =  'Own';
L.Company = 'None';
L.FirstName = 'John';
L.LastName = 'Doe';
L.Borrowers_Home_Phone__c = '(111) 222-3333';
L.Internal_Referral_Name__c = u.id;
L.Property_State__c = 'TX';
L.Notes_Type__c = 'Called Home, Left Message – No Contact';
L.Loan_Purpose__c = 'Purchase';

insert L;


Opportunity O = new Opportunity();
O.name = 'ABC';
O.CloseDate = date.today();
O.StageName = 'Prospecting';
O.Annual_Homeowner_s_Association_Dues__c = 5555;
O.Annual_Homeowner_s_Insurance__c = 5555;
O.Annual_Real_Estate_Taxes__c = 4444;
O.Applicant_Type__c = 'Individual';
O.Channel__c = 'Centralized Retail';
O.Channel_Sources__c = 'Bank';
O.Channel_Values__c = 'RB Portal';
O.Value_of_Home__c = 23424;
O.Requested_Loan_Amount__c = 42424;
O.Loan_Purpose__c = 'Purchase';
O.Property_Address_1__c = 'ABC';
O.Property_Address_2__c = 'ABC';
O.Property_Apt__c = '22222';
O.Property_City__c = 'India';
O.Property_Country__c = 'India';
O.Property_County__c = 'India';
O.Property_House__c = 'India';
O.Property_State__c = 'TX';
O.Property_Type__c = '2 Unit';
O.Property_Zip_Postal_Code__c = '11111';
O.Empower_Lead_ID__c = '455461';
O.Related_Lead__c = L.id;
O.Shopping_Stage__c = 'Immediately';
O.AccountID = a.id;
//O.Account.id = '001f000000C91AJAAZ';
insert O;

String Dnumber = CreateOpusid_Opp.show(O.id);



  Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
  //Userrole  r = [select id from userrole where name='System Administrator'];
  UserRole r= new UserRole(name='System Administrator',CaseAccessForAccountOwner='Edit', OpportunityAccessForAccountOwner='Edit'); //Changes made by Vimal for the story B-653680 
  insert r; //Changes made by Vimal for the story B-653680 
  List<User> userlist = new List<User>(); 

  userlist.add(new User(Alias = 'standt', Email='standarduser1@testorg.com',EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='CapitalOne@test1.com.CapitalOne',CommunityNickname='standarduser1',userroleid=r.id));
  userlist.add(new User(Alias = 'standt2', Email='standarduser2@testorg.com',EmailEncodingKey='UTF-8', LastName='Testing2', LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='CapitalOne@test2.com.CapitalOne',CommunityNickname='standarduser2',userroleid=r.id));
  insert userlist;

  Opportunity opps = o.clone(false);
  opps.Empower_Lead_ID__c = 'D100666';
  opps.StageName='Offer Not Accepted';
  opps.OwnerId = userlist[0].id;
  insert opps;
  try{        
    opps.ownerId = userlist[1].id;        
    update opps;        
    Set<Id> oppIds = new Set<Id>();
    oppIds.add(opps.Id);                
    UpdateOPUSInfo.updateLOService(oppIds);              

  }catch(Exception e){        
    System.debug('Update Fail: ' + e);      
  }

}

 }
}