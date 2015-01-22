@istest
global class testleadupdate{
 testMethod static void testmethod1(){
       integer i;
       list<lead> leads=new list<lead>();
       user u=[select id from user limit 1];
        for (i=0;i<2;i++){
            Lead l = new Lead(FirstName='John'+i,LastName='Doe'+i, email='test@test.com',Company='test',Property_State__c='DE',Status='New-Not Opened',Applicant_Type__c='Individual',Internal_Referral__c='MC Referral',Channel__c='Centralized Retail',Channel_Sources__c='Bank',Occupancy_Code__c='Owner Occupied',Internal_Referral_Name__c=u.id);
            leads.add(l);
        }//for
       
         insert leads;
         
         Test.StartTest();
         LeadUpdate leadupdates =  new LeadUpdate();
         leadupdates.query='SELECT  firstname,lastname,DoNotCall,  DNC__c  FROM Lead where Internal_Referral_Name__c=u.id ';
         ID batchprocessid = Database.executeBatch(leadupdates);
         Test.StopTest();
        
       
       }
       
       
 }