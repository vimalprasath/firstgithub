@istest
global class testleadscoringbackup{
 testMethod static void testmethod1(){

         leadscoringbackup lsb =  new leadscoringbackup();
           
         campaign cm = new campaign();
         cm.name='Fake';
         insert cm;
        
         List<Lead> leads = new List<Lead>{};
         List<contact> contacts = new List<contact>{};
         List<campaignmember> cms= new List<campaignmember>{}; 
         Integer i;
                 
        for (i=0;i<5;i++){
            Contact c = new contact(FirstName='John'+i,LastName='Doe'+i);
            contacts.add(c);
        }//for
        insert contacts;
        
        
       user u=[select id from user limit 1];
        for (i=0;i<5;i++){
            Lead l = new Lead(FirstName='John'+i,LastName='Doe'+i,email='test@test.com', Company='test',Property_State__c='DE',Status='New-Not Opened',Applicant_Type__c='Individual',Internal_Referral__c='MC Referral',Channel__c='Centralized Retail',Channel_Sources__c='Bank',Occupancy_Code__c='Owner Occupied',Internal_Referral_Name__c=u.id);
            leads.add(l);
        }//for
        insert leads;
           
         
         for (i=0;i<5;i++)
         {  
         campaignmember cm1 =  new campaignmember();
         cm1.campaignid=cm.id;
         cm1.ContactId=contacts.get(i).id;
         cm1.leadid=leads.get(i).id;
         cm1.Campaign_Score__c = 1;
         cms.add(cm1);
        } 
         insert cms;
         system.debug('%%%%%%%%55'+cms);       
         
         
         LeadScoringRule__c cmscore =  new LeadScoringRule__c(Active__c=true,Campaign__c=cm.id,Field_Label__c='Status',Field_Name__c='Status',Operator__c='equal',Score_Change__c=10,Type__c='Campaign Member',Value__c='Sent');
         insert cmscore;
         LeadScoringRule__c cmscore1 =  new LeadScoringRule__c(Active__c=true,Campaign__c=null,Field_Label__c='Status',Field_Name__c='Status',Operator__c='equal',Score_Change__c=10,Type__c='Lead',Value__c='New-Not Opened');
         insert cmscore1; 
      
      
         LeadScoringBackup.leadScoringClassAlreadyCalled();
        
         set<id> leadids =  new set<id>(); 
         set<id> cmids =  new set<id>(); 
         
         for(lead l:leads)
         {    leadids.add(l.id);   } 
         
         for( campaignmember cam :cms)
         {    cmids.add(cam.id);   } 
           
        
         LeadScoringBackup.evaluateCMs(cmids);
         LeadScoringBackup.evaluateLeads(leadids);
         LeadScoringBackup.deletedCMs(cmids);
         
            
         
         leadscoringbackup.evaluateCriteria('Sent', 'equals', 'Sent', schema.DisplayType.STRING);
         leadscoringbackup.evaluateCriteria('Sent', 'equals', 'Sent', schema.DisplayType.BOOLEAN);
         leadscoringbackup.evaluateCriteria('10', 'equals', '10', schema.DisplayType.INTEGER);
         leadscoringbackup.evaluateCriteria('Sent', 'not equal to', 'Sent', schema.DisplayType.BOOLEAN);  
         leadscoringbackup.evaluateCriteria('10', 'not equal to', '10', schema.DisplayType.INTEGER);
         leadscoringbackup.evaluateCriteria('Sent', 'not equal to', 'Sent', schema.DisplayType.STRING);
         leadscoringbackup.evaluateCriteria('10', 'greater than', '10', schema.DisplayType.INTEGER);
         leadscoringbackup.evaluateCriteria('Sent', 'greater than', 'Sent', schema.DisplayType.STRING);
         leadscoringbackup.evaluateCriteria('10', 'greater or equal', '10', schema.DisplayType.INTEGER);
         leadscoringbackup.evaluateCriteria('Sent', 'greater or equal', 'Sent', schema.DisplayType.STRING);
         leadscoringbackup.evaluateCriteria('10', 'less than', '10', schema.DisplayType.INTEGER);
         leadscoringbackup.evaluateCriteria('Sent', 'less than', 'Sent', schema.DisplayType.STRING);
         leadscoringbackup.evaluateCriteria('10', 'less or equal', '10', schema.DisplayType.INTEGER);
         leadscoringbackup.evaluateCriteria('Sent', 'less or equal', 'Sent', schema.DisplayType.STRING);
         leadscoringbackup.evaluateCriteria('S', 'contains', 'S', schema.DisplayType.STRING);
         leadscoringbackup.evaluateCriteria('S', 'starts with', 'S', schema.DisplayType.STRING);
         leadscoringbackup.evaluateCriteria('S', 'does not contain', 'S', schema.DisplayType.STRING);
  }  
   
}