@istest

public with sharing class LeadExtensiontest {
 static testmethod void LeadExtensiontest (){
 
 /*        List<lead> testlead = new List<lead>();
         for(integer i=0;i<25;i++){    
         Lead TestLead1 = new Lead();
         TestLead1.status = 'New';
         TestLead1.Channel__c = 'Centralized Retail';
         TestLead1.Channel_Sources__c = 'Bank';
         TestLead1.firstname = 'testfirst';
         TestLead1.lastname = 'testlast';
         TestLead1.Company = 'Test';
         TestLead1.Borrowers_Current_Residence__c = 'test';
         TestLead1.Occupancy_Code__c = 'Second Home';
         TestLead1.Notes_Type__c = 'Called Home, Left Message – No Contact';
         TestLead1.Property_State__c = 'TX';
         TestLead1.Borrowers_Mobile_Phone__c = '(111) 222-3333';
         //testlead.Empower_Lead_ID__c = 'D101010';
         TestLead1.Is_Sofi_Lead__c = false;
         TestLead1.My_Lead__c = false;
         TestLead1.Transfer_To_HLR__c = true;
         TestLead1.My_Lead_to_Sofi__c = true;
         testlead.add(testlead1);
         }
         
         testlead[1].status = 'Active';
         testlead[2].status = 'Active';
         testlead[2].Transfer_To_HLR__c = false;
         testlead[3].Empower_Lead_ID__c = 'D101010';
         testlead[4].Empower_Lead_ID__c = 'D000001';
         testlead[4].Is_Sofi_Lead__c =true;
         testlead[5].status = 'Active';
         testlead[5].Empower_Lead_ID__c = 'D000011';
         testlead[6].status = 'Active';
         testlead[6].Empower_Lead_ID__c = 'D000010';
         testlead[6].Is_Sofi_Lead__c = true;
         testlead[6].Transfer_To_HLR__c = true;
         testlead[7].status = 'Active';
         testlead[7].Empower_Lead_ID__c = 'D000100';
         testlead[7].My_Lead__c = true;
         testlead[7].Transfer_To_HLR__c = true;
         testlead[8].status = 'Active';
         testlead[8].Empower_Lead_ID__c = 'D000110';
         testlead[8].My_Lead__c = true;
         testlead[8].Transfer_To_HLR__c = false;
         testlead[8].My_Lead_to_Sofi__c = false;
         testlead[9].status = 'Active';
         testlead[9].Empower_Lead_ID__c = 'D000111';
         testlead[9].My_Lead__c = true;
         testlead[9].Transfer_To_HLR__c = false;
         testlead[9].My_Lead_to_Sofi__c = true;
         testlead[10].Empower_Lead_ID__c = 'E000111';
         

        insert testlead;

     
         PageReference ref= page.LeadDetail;
         Test.setCurrentPage(ref);
         ref.getParameters().put('id',testlead[0].id);
         ApexPages.StandardController sc = new ApexPages.standardController(testlead[0]);
         LeadExtension Cntlr = new LeadExtension(sc);
         Cntlr.init();
         
         ref.getParameters().put('id',testlead[1].id);
         ApexPages.StandardController sc1 = new ApexPages.standardController(testlead[1]);
         LeadExtension Cntlr1 = new LeadExtension(sc1);
         Cntlr1.init();
         
         ref.getParameters().put('id',testlead[2].id);
         ApexPages.StandardController sc2 = new ApexPages.standardController(testlead[2]);
         LeadExtension Cntlr2 = new LeadExtension(sc2);
         Cntlr2.init();
         
         ref.getParameters().put('id',testlead[3].id);
         ApexPages.StandardController sc3 = new ApexPages.standardController(testlead[3]);
         LeadExtension Cntlr3 = new LeadExtension(sc3);
         Cntlr3.init();*/
         
         /*ref.getParameters().put('id',testlead[4].id);
         ApexPages.StandardController sc4 = new ApexPages.standardController(testlead[4]);
         LeadExtension Cntlr4 = new LeadExtension(sc4);
         Cntlr4.init();*/
         
         /*ref.getParameters().put('id',testlead[5].id);
         ApexPages.StandardController sc5 = new ApexPages.standardController(testlead[5]);
         LeadExtension Cntlr5 = new LeadExtension(sc5);
         Cntlr5.init();
         
         ref.getParameters().put('id',testlead[6].id);
         ApexPages.StandardController sc6 = new ApexPages.standardController(testlead[6]);
         LeadExtension Cntlr6 = new LeadExtension(sc6);
         Cntlr6.init();*/
         
         /*ref.getParameters().put('id',testlead[7].id);
         ApexPages.StandardController sc7 = new ApexPages.standardController(testlead[7]);
         LeadExtension Cntlr7 = new LeadExtension(sc7);
         Cntlr7.init();
         
         ref.getParameters().put('id',testlead[8].id);
         ApexPages.StandardController sc8 = new ApexPages.standardController(testlead[8]);
         LeadExtension Cntlr8 = new LeadExtension(sc8);
         Cntlr8.init();
         
         ref.getParameters().put('id',testlead[9].id);
         ApexPages.StandardController sc9 = new ApexPages.standardController(testlead[9]);
         LeadExtension Cntlr9 = new LeadExtension(sc9);
         Cntlr9.init();
         
         ref.getParameters().put('id',testlead[10].id);
         ApexPages.StandardController sc10 = new ApexPages.standardController(testlead[10]);
         LeadExtension Cntlr10 = new LeadExtension(sc10);
         Cntlr10.init();*/
         
         /*ref.getParameters().put('id',testlead[0].id);
         ApexPages.StandardController sc = new ApexPages.standardController(testlead[0]);
         LeadExtension Cntlr = new LeadExtension(sc);
         Cntlr.init();*/
          
          /*testlead.Status = 'Active';
          update testlead;
          Cntlr = new LeadExtension(sc);
          Cntlr.init();
          
          testlead.Transfer_To_HLR__c = false;
          update testlead;
          Cntlr = new LeadExtension(sc);
          Cntlr.init();

         testlead.Empower_Lead_ID__c = 'D101010';
        testlead.Status = 'New';
        testlead.Is_Sofi_Lead__c = false;
        update testlead;
          Cntlr = new LeadExtension(sc);
          Cntlr.init();


          testlead.Is_Sofi_Lead__c = true;
          update testlead;
          Cntlr = new LeadExtension(sc);
          Cntlr.init();
        
           testlead.Status = 'Active';        
           testlead.Is_Sofi_Lead__c = false;      
          testlead.My_Lead__c = false; 
          update testlead;
          Cntlr = new LeadExtension(sc);
          Cntlr.init();*/
          
         }
}