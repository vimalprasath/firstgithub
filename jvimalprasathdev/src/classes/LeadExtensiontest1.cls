@istest
public with sharing class LeadExtensiontest1 {

 static testmethod void LeadExtensiontest (){
 
 
        Lead TestLead = new Lead();
         testlead.status = 'New - Not Opened';
         /*testlead.Channel__c = 'Centralized Retail';
         testlead.Channel_Sources__c = 'Bank';*/
         testlead.firstname = 'testfirst';
         testlead.lastname = 'testlast';
         testlead.Company = 'Test';
         testlead.Empower_Lead_ID__c = 'D101010';
         testlead.Is_Sofi_Lead__c = true;
         testlead.Property_State__c = 'TX';
         testlead.Borrowers_Mobile_Phone__c = '(111) 222-3333';
         testlead.Transfer_To_HLR__c = true;
         /*testlead.Borrowers_Current_Residence__c = 'test';
         testlead.Occupancy_Code__c = 'Second Home';
         testlead.Notes_Type__c = 'Called Home, Left Message – No Contact';
         testlead.My_Lead__c = false;
         testlead.Transfer_To_HLR__c = false;
         testlead.My_Lead_to_Sofi__c = true;*/
         insert testlead;



        //lead testlead1 = [Select id,name,recordtypeId,status,Empower_Lead_ID__c from lead where status =:'New' and Empower_Lead_ID__c = null limit 1];    
     
         PageReference ref= page.LeadDetail;
         Test.setCurrentPage(ref);
        /* ref.getParameters().put('id',testlead1.id);
         ApexPages.StandardController sc = new ApexPages.standardController(testlead1);
         LeadExtension Cntlr = new LeadExtension(sc);
         Cntlr.init();*/
          
        // lead testlead2 =[Select id,name,recordtypeId,status,Empower_Lead_ID__c from lead where status =:'New' and Empower_Lead_ID__c = null and Transfer_To_HLR__c =:true limit 1] ;
         ref.getParameters().put('id',testlead.id);
         ApexPages.StandardController sc2 = new ApexPages.standardController(testlead);
         LeadExtension Cntlr2 = new LeadExtension(sc2);
         Cntlr2.init();
         
      //   lead testlead3 =[Select id,name,recordtypeId,status,Empower_Lead_ID__c where status =:'New' ];
         /*testlead.Is_Sofi_Lead__c = false;
          testlead.My_Lead__c = false;
          update testlead;
          Cntlr = new LeadExtension(sc);
          Cntlr.init();
          

         testlead.Is_Sofi_Lead__c = false ;
         testlead.My_Lead__c = true;
          update testlead;
          Cntlr = new LeadExtension(sc);
          Cntlr.init();


          testlead.Transfer_To_HLR__c = false ;
          testlead.My_Lead_to_Sofi__c = true;
          update testlead;
          Cntlr = new LeadExtension(sc);
          Cntlr.init();


          testlead.My_Lead_to_Sofi__c = false;
          update testlead;
          Cntlr = new LeadExtension(sc);
          Cntlr.init();*/
        
                  
                   
          
         }
 static testmethod void LeadExtensiontest1 (){
 
        Lead TestLead = new Lead();
         testlead.status = 'New - Not Opened';
         /*testlead.Channel__c = 'Centralized Retail';
         testlead.Channel_Sources__c = 'Bank';*/
         testlead.firstname = 'testfirst';
         testlead.lastname = 'testlast';
         testlead.Company = 'Test';
         testlead.Empower_Lead_ID__c = 'D101010';
         testlead.Is_Sofi_Lead__c = false;
         testlead.Property_State__c = 'TX';
         testlead.Borrowers_Mobile_Phone__c = '(111) 222-3333';
         /*testlead.Borrowers_Current_Residence__c = 'test';
         testlead.Occupancy_Code__c = 'Second Home';
         testlead.Notes_Type__c = 'Called Home, Left Message – No Contact';
         testlead.My_Lead__c = false;
         testlead.Transfer_To_HLR__c = false;
         testlead.My_Lead_to_Sofi__c = true;*/
         insert testlead;

     
         PageReference ref= page.LeadDetail;
         Test.setCurrentPage(ref);
         ref.getParameters().put('id',testlead.id);
         ApexPages.StandardController sc2 = new ApexPages.standardController(testlead);
         LeadExtension Cntlr = new LeadExtension(sc2);
         Cntlr.init();
         }
 static testmethod void LeadExtensiontest2 (){
 
        Lead TestLead = new Lead();
         testlead.status = 'New - Not Opened';
         testlead.firstname = 'testfirst';
         testlead.lastname = 'testlast';
         testlead.Company = 'Test';
         testlead.Empower_Lead_ID__c = 'D101010';
         testlead.Is_Sofi_Lead__c = false;
         testlead.Property_State__c = 'TX';
         testlead.Borrowers_Mobile_Phone__c = '(111) 222-3333';
         testlead.My_Lead__c = false;
         /*testlead.Borrowers_Current_Residence__c = 'test';
         testlead.Channel__c = 'Centralized Retail';
         testlead.Channel_Sources__c = 'Bank';
         testlead.Occupancy_Code__c = 'Second Home';
         testlead.Notes_Type__c = 'Called Home, Left Message – No Contact';
         testlead.Transfer_To_HLR__c = false;
         testlead.My_Lead_to_Sofi__c = true;*/
         insert testlead;

     
         PageReference ref= page.LeadDetail;
         Test.setCurrentPage(ref);
         ref.getParameters().put('id',testlead.id);
         ApexPages.StandardController sc2 = new ApexPages.standardController(testlead);
         LeadExtension Cntlr = new LeadExtension(sc2);
         Cntlr.init();
         }
 static testmethod void LeadExtensiontest3 (){
 
        Lead TestLead = new Lead();
         testlead.status = 'New - Not Opened';
         testlead.firstname = 'testfirst';
         testlead.lastname = 'testlast';
         testlead.Company = 'Test';
         testlead.Empower_Lead_ID__c = '';
         testlead.Is_Sofi_Lead__c = false;
         testlead.Property_State__c = 'TX';
         testlead.Borrowers_Mobile_Phone__c = '(111) 222-3333';
         testlead.My_Lead__c = false;
         testlead.Channel_Sources__c = 'Bank';
         testlead.Channel_Values__c ='RB Portal';
         /*testlead.Borrowers_Current_Residence__c = 'test';
         testlead.Channel__c = 'Centralized Retail';
         testlead.Occupancy_Code__c = 'Second Home';
         testlead.Notes_Type__c = 'Called Home, Left Message – No Contact';
         testlead.Transfer_To_HLR__c = false;
         testlead.My_Lead_to_Sofi__c = true;*/
         insert testlead;

     
         PageReference ref= page.LeadDetail;
         Test.setCurrentPage(ref);
         ref.getParameters().put('id',testlead.id);
         ApexPages.StandardController sc2 = new ApexPages.standardController(testlead);
         LeadExtension Cntlr = new LeadExtension(sc2);
         Cntlr.init();
         }
 static testmethod void LeadExtensiontest4 (){
 
        Lead TestLead = new Lead();
         testlead.status = 'New - Not Opened';
         testlead.firstname = 'testfirst';
         testlead.lastname = 'testlast';
         testlead.Company = 'Test';
         testlead.Empower_Lead_ID__c = 'D101010';
         testlead.Is_Sofi_Lead__c = true;
         testlead.Property_State__c = 'TX';
         testlead.Borrowers_Mobile_Phone__c = '(111) 222-3333';
        /*testlead.My_Lead__c = false;
         testlead.Borrowers_Current_Residence__c = 'test';
         testlead.Channel_Sources__c = 'Bank';
         testlead.Channel_Values__c ='RB Portal';
         testlead.Channel__c = 'Centralized Retail';
         testlead.Occupancy_Code__c = 'Second Home';
         testlead.Notes_Type__c = 'Called Home, Left Message – No Contact';
         testlead.Transfer_To_HLR__c = false;
         testlead.My_Lead_to_Sofi__c = true;*/
         insert testlead;
     
         PageReference ref= page.LeadDetail;
         Test.setCurrentPage(ref);
         ref.getParameters().put('id',testlead.id);
         ApexPages.StandardController sc2 = new ApexPages.standardController(testlead);
         LeadExtension Cntlr = new LeadExtension(sc2);
         Cntlr.init();
         }
 static testmethod void LeadExtensiontest5 (){
 
        Lead TestLead = new Lead();
         testlead.status = 'New - Not Opened';
         testlead.firstname = 'testfirst';
         testlead.lastname = 'testlast';
         testlead.Company = 'Test';
         testlead.Empower_Lead_ID__c = '';
         testlead.Property_State__c = 'TX';
         testlead.Borrowers_Mobile_Phone__c = '(111) 222-3333';
         testlead.Channel_Sources__c = 'Bank';
         testlead.Channel_Values__c ='RB Portal';
         testlead.Transfer_To_HLR__c = true;
         /*testlead.Borrowers_Current_Residence__c = 'test';
         testlead.Is_Sofi_Lead__c = false;
         testlead.My_Lead__c = false;
         testlead.Channel__c = 'Centralized Retail';
         testlead.Occupancy_Code__c = 'Second Home';
         testlead.Notes_Type__c = 'Called Home, Left Message – No Contact';
         testlead.My_Lead_to_Sofi__c = true;*/
         insert testlead;

        Lead testlead1 = new Lead();
         testlead1.status = 'New - Not Opened';
         testlead1.firstname = 'testfirst';
         testlead1.lastname = 'testlast';
         testlead1.Company = 'Test';
         testlead1.Empower_Lead_ID__c = '';
         testlead1.Property_State__c = 'TX';
         testlead1.Borrowers_Mobile_Phone__c = '(111) 222-3333';
         testlead1.Channel_Sources__c = 'Bank';
         testlead1.Channel_Values__c ='RB Portal';
         testlead1.Transfer_To_HLR__c = false;
         /*testlead1.Borrowers_Current_Residence__c = 'test';
         testlead1.Is_Sofi_Lead__c = false;
         testlead1.My_Lead__c = false;
         testlead1.Channel__c = 'Centralized Retail';
         testlead1.Occupancy_Code__c = 'Second Home';
         testlead1.Notes_Type__c = 'Called Home, Left Message – No Contact';
         testlead1.My_Lead_to_Sofi__c = true;*/
         insert testlead1;
     
         PageReference ref= page.LeadDetail;
         Test.setCurrentPage(ref);
         ref.getParameters().put('id',testlead1.id);
         ApexPages.StandardController sc = new ApexPages.standardController(testlead1);
         LeadExtension Cntlr = new LeadExtension(sc);
         Cntlr.init();
     
         /*PageReference ref= page.LeadDetail;
         Test.setCurrentPage(ref);*/
         ref.getParameters().put('id',testlead.id);
         ApexPages.StandardController sc2 = new ApexPages.standardController(testlead);
         LeadExtension Cntlr1 = new LeadExtension(sc2);
         Cntlr1.init();
}

 static testmethod void LeadExtensiontest6 (){
 
        Lead TestLead = new Lead();
         testlead.status = 'New - Not Opened';
         testlead.firstname = 'testfirst';
         testlead.lastname = 'testlast';
         testlead.Company = 'Test';
         testlead.Empower_Lead_ID__c = 'D101010';
         testlead.Property_State__c = 'TX';
         testlead.Borrowers_Mobile_Phone__c = '(111) 222-3333';
         testlead.Channel_Sources__c = 'Bank';
         testlead.Channel_Values__c ='RB Portal';
         testlead.Transfer_To_HLR__c = false;
         testlead.Is_Sofi_Lead__c = false;
         /*testlead.Borrowers_Current_Residence__c = 'test';
         testlead.My_Lead__c = false;
         testlead.Channel__c = 'Centralized Retail';
         testlead.Occupancy_Code__c = 'Second Home';
         testlead.Notes_Type__c = 'Called Home, Left Message – No Contact';
         testlead.My_Lead_to_Sofi__c = true;*/
         insert testlead;

        Lead testlead1 = new Lead();
         testlead1.status = 'New - Not Opened';
         testlead1.firstname = 'testfirst';
         testlead1.lastname = 'testlast';
         testlead1.Company = 'Test';
         testlead1.Empower_Lead_ID__c = 'D1010101';
         testlead1.Property_State__c = 'TX';
         testlead1.Borrowers_Mobile_Phone__c = '(111) 222-3333';
         testlead1.Channel_Sources__c = 'Bank';
         testlead1.Channel_Values__c ='RB Portal';
         testlead1.Is_Sofi_Lead__c = true;
         /*testlead1.Borrowers_Current_Residence__c = 'test';
         testlead1.Transfer_To_HLR__c = false;
         testlead1.My_Lead__c = false;
         testlead1.Channel__c = 'Centralized Retail';
         testlead1.Occupancy_Code__c = 'Second Home';
         testlead1.Notes_Type__c = 'Called Home, Left Message – No Contact';
         testlead1.My_Lead_to_Sofi__c = true;*/
         insert testlead1;

     
         PageReference ref= page.LeadDetail;
         Test.setCurrentPage(ref);
         ref.getParameters().put('id',testlead1.id);
         ApexPages.StandardController sc = new ApexPages.standardController(testlead1);
         LeadExtension Cntlr1 = new LeadExtension(sc);
         Cntlr1.init();

     
         ref.getParameters().put('id',testlead.id);
         ApexPages.StandardController sc2 = new ApexPages.standardController(testlead);
         LeadExtension Cntlr = new LeadExtension(sc2);
         Cntlr.init();
}

    static testmethod void LeadExtensiontest7 (){
 
        Lead TestLead = new Lead();
         testlead.status = 'Active';
         testlead.Transfer_To_HLR__c = false;
         /*testlead.Channel__c = 'Centralized Retail';
         testlead.Channel_Sources__c = 'Bank';*/
         testlead.firstname = 'testfirst';
         testlead.lastname = 'testlast';
         testlead.Company = 'Test';
         //testlead.Empower_Lead_ID__c = '';
        // testlead.Is_Sofi_Lead__c = true;
         testlead.Property_State__c = 'TX';
         testlead.Borrowers_Mobile_Phone__c = '(111) 222-3333';
         //testlead.Transfer_To_HLR__c = true;
         /*testlead.Borrowers_Current_Residence__c = 'test';
         testlead.Occupancy_Code__c = 'Second Home';
         testlead.Notes_Type__c = 'Called Home, Left Message – No Contact';
         testlead.My_Lead__c = false;
         
         testlead.My_Lead_to_Sofi__c = true;*/
         insert testlead;


  
     
         PageReference ref= page.LeadDetail;
         Test.setCurrentPage(ref);
        
          
       
         ref.getParameters().put('id',testlead.id);
         ApexPages.StandardController sc2 = new ApexPages.standardController(testlead);
         LeadExtension Cntlr2 = new LeadExtension(sc2);
         Cntlr2.l=testlead;
         Cntlr2.init();
         
      
        
                  
                   
          
         }
         
 
         
        static testmethod void LeadExtensiontest8 (){
 
        Lead TestLead = new Lead();
         testlead.status = 'New - Not Opened';
         testlead.Transfer_To_HLR__c = false;
         /*testlead.Channel__c = 'Centralized Retail';
         testlead.Channel_Sources__c = 'Bank';*/
         testlead.firstname = 'testfirst';
         testlead.lastname = 'testlast';
         testlead.Company = 'Test';
         testlead.Empower_Lead_ID__c = 'D1010103';
         testlead.Is_Sofi_Lead__c = True;
         testlead.Property_State__c = 'TX';
         testlead.Borrowers_Mobile_Phone__c = '(111) 222-3333';
         //testlead.Transfer_To_HLR__c = true;
         /*testlead.Borrowers_Current_Residence__c = 'test';
         testlead.Occupancy_Code__c = 'Second Home';
         testlead.Notes_Type__c = 'Called Home, Left Message – No Contact';
         testlead.My_Lead__c = false;
         
         testlead.My_Lead_to_Sofi__c = true;*/
         insert testlead;


  
     
         PageReference ref= page.LeadDetail;
         Test.setCurrentPage(ref);
        
          
       
         ref.getParameters().put('id',testlead.id);
         ApexPages.StandardController sc2 = new ApexPages.standardController(testlead);
         LeadExtension Cntlr2 = new LeadExtension(sc2);
         Cntlr2.l=testlead;
         Cntlr2.init();
         
      
        
                  
                   
          
         }
         
     static testmethod void LeadExtensiontest9 (){
 
        Lead TestLead = new Lead();
         testlead.status = 'Active';
         testlead.Transfer_To_HLR__c = True;
         /*testlead.Channel__c = 'Centralized Retail';
         testlead.Channel_Sources__c = 'Bank';*/
         testlead.firstname = 'testfirst';
         testlead.lastname = 'testlast';
         testlead.Company = 'Test';
         testlead.Empower_Lead_ID__c = 'D1010403';
         testlead.Is_Sofi_Lead__c = False;
         testlead.Property_State__c = 'TX';
         testlead.Borrowers_Mobile_Phone__c = '(111) 222-3333';
         //testlead.Transfer_To_HLR__c = true;
         /*testlead.Borrowers_Current_Residence__c = 'test';
         testlead.Occupancy_Code__c = 'Second Home';
         testlead.Notes_Type__c = 'Called Home, Left Message – No Contact';
         testlead.My_Lead__c = True;
         
         testlead.My_Lead_to_Sofi__c = true;*/
         testlead.My_Lead__c = True;
         insert testlead;


  
     
         PageReference ref= page.LeadDetail;
         Test.setCurrentPage(ref);
        
          
       
         ref.getParameters().put('id',testlead.id);
         ApexPages.StandardController sc2 = new ApexPages.standardController(testlead);
         LeadExtension Cntlr2 = new LeadExtension(sc2);
         Cntlr2.l=testlead;
         Cntlr2.init();
         
      
        
                  
                   
          
         } 
         
static testmethod void LeadExtensiontest10 (){
 
        Lead TestLead = new Lead();
         testlead.status = 'Active';
         testlead.firstname = 'testfirst';
         testlead.lastname = 'testlast';
         testlead.Company = 'Test';
         testlead.Empower_Lead_ID__c = 'D1010103';
         testlead.Is_Sofi_Lead__c = False;
         testlead.Property_State__c = 'TX';
         testlead.Borrowers_Mobile_Phone__c = '(111) 222-3333';
         testlead.My_Lead__c = False;
         insert testlead;


  
     
         PageReference ref= page.LeadDetail;
         Test.setCurrentPage(ref);
        
          
       
         ref.getParameters().put('id',testlead.id);
         ApexPages.StandardController sc2 = new ApexPages.standardController(testlead);
         LeadExtension Cntlr2 = new LeadExtension(sc2);
         Cntlr2.l=testlead;
         Cntlr2.init();
         }
         
         static testmethod void LeadExtensiontest11 (){
 
        Lead TestLead = new Lead();
         testlead.status = 'Active';
         testlead.firstname = 'testfirst';
         testlead.lastname = 'testlast';
         testlead.Company = 'Test';
         testlead.Empower_Lead_ID__c = 'D1010105';
         testlead.Is_Sofi_Lead__c = False;
         testlead.Property_State__c = 'TX';
         testlead.Borrowers_Mobile_Phone__c = '(111) 222-3333';
         testlead.My_Lead__c = True;
         //testlead.Transfer_To_HLR__c = True;
         insert testlead;


  
     
         PageReference ref= page.LeadDetail;
         Test.setCurrentPage(ref);
        
          
       
         ref.getParameters().put('id',testlead.id);
         ApexPages.StandardController sc2 = new ApexPages.standardController(testlead);
         LeadExtension Cntlr2 = new LeadExtension(sc2);
         Cntlr2.l=testlead;
         Cntlr2.init();
         }
         
         static testmethod void LeadExtensiontest12 (){
 
        Lead TestLead = new Lead();
         testlead.status = 'Active';
         testlead.firstname = 'testfirst';
         testlead.lastname = 'testlast';
         testlead.Company = 'Test';
         testlead.Empower_Lead_ID__c = 'E1010105';
         testlead.Is_Sofi_Lead__c = False;
         testlead.Property_State__c = 'TX';
         testlead.Borrowers_Mobile_Phone__c = '(111) 222-3333';
         testlead.My_Lead__c = True;
         //testlead.Transfer_To_HLR__c = True;
         insert testlead;


  
     
         PageReference ref= page.LeadDetail;
         Test.setCurrentPage(ref);
        
          
       
         ref.getParameters().put('id',testlead.id);
         ApexPages.StandardController sc2 = new ApexPages.standardController(testlead);
         LeadExtension Cntlr2 = new LeadExtension(sc2);
         Cntlr2.l=testlead;
         Cntlr2.init();
         }
         
         
         static testmethod void LeadExtensiontest13 (){
 
        Lead TestLead = new Lead();
         testlead.status = 'Active';
         testlead.firstname = 'testfirst';
         testlead.lastname = 'testlast';
         testlead.Company = 'Test';
         testlead.Empower_Lead_ID__c = 'D1010105';
         testlead.Is_Sofi_Lead__c = False;
         testlead.Property_State__c = 'TX';
         testlead.Borrowers_Mobile_Phone__c = '(111) 222-3333';
         testlead.My_Lead__c = true;
         testlead.Transfer_To_HLR__c = false;
         testlead.My_Lead_to_Sofi__c = false;
         testlead.Channel_Sources__c ='Bank';
         testlead.Channel_Values__c ='RB Portal';
         insert testlead;


  
     
         PageReference ref= page.LeadDetail;
         Test.setCurrentPage(ref);
        
          
       
         ref.getParameters().put('id',testlead.id);
         ApexPages.StandardController sc2 = new ApexPages.standardController(testlead);
         LeadExtension Cntlr2 = new LeadExtension(sc2);
         Cntlr2.l=testlead;
         Cntlr2.init();
         }
         
         
         static testmethod void LeadExtensiontest14 (){
 
        Lead TestLead = new Lead();
         testlead.status = 'Active';
         testlead.firstname = 'testfirst';
         testlead.lastname = 'testlast';
         testlead.Company = 'Test';
         //testlead.Empower_Lead_ID__c = 'D1010105';
       //  testlead.Is_Sofi_Lead__c = False;
         testlead.Property_State__c = 'TX';
         testlead.Borrowers_Mobile_Phone__c = '(111) 222-3333';
       //  testlead.My_Lead__c = true;
         testlead.Transfer_To_HLR__c = false;
        // testlead.My_Lead_to_Sofi__c = false;
         testlead.Channel_Sources__c ='Bank';
         testlead.Channel_Values__c ='RB Portal';
         insert testlead;


  
     
         PageReference ref= page.LeadDetail;
         Test.setCurrentPage(ref);
        
          
       
         ref.getParameters().put('id',testlead.id);
         ApexPages.StandardController sc2 = new ApexPages.standardController(testlead);
         LeadExtension Cntlr2 = new LeadExtension(sc2);
         Cntlr2.l=testlead;
         Cntlr2.init();
         }
         
         static testmethod void LeadExtensiontest15 (){
 
        Lead TestLead = new Lead();
         testlead.status = 'Active';
         testlead.firstname = 'testfirst';
         testlead.lastname = 'testlast';
         testlead.Company = 'Test';
         testlead.Empower_Lead_ID__c = 'D1010105';
         testlead.Is_Sofi_Lead__c = true;
         testlead.Property_State__c = 'TX';
         testlead.Borrowers_Mobile_Phone__c = '(111) 222-3333';
       //  testlead.My_Lead__c = true;
         testlead.Transfer_To_HLR__c = true;
        // testlead.My_Lead_to_Sofi__c = false;
         testlead.Channel_Sources__c ='Bank';
         testlead.Channel_Values__c ='RB Portal';
         insert testlead;


  
     
         PageReference ref= page.LeadDetail;
         Test.setCurrentPage(ref);
        
          
       
         ref.getParameters().put('id',testlead.id);
         ApexPages.StandardController sc2 = new ApexPages.standardController(testlead);
         LeadExtension Cntlr2 = new LeadExtension(sc2);
         Cntlr2.l=testlead;
         Cntlr2.init();
         }
         
         static testmethod void LeadExtensiontest16 (){
 
        Lead TestLead = new Lead();
         testlead.status = 'Active';
         testlead.firstname = 'testfirst';
         testlead.lastname = 'testlast';
         testlead.Company = 'Test';
         testlead.Empower_Lead_ID__c = 'D1010105';
         testlead.Is_Sofi_Lead__c = false;
         testlead.Property_State__c = 'TX';
         testlead.Borrowers_Mobile_Phone__c = '(111) 222-3333';
         testlead.My_Lead__c = true;
         testlead.Transfer_To_HLR__c = false;
         testlead.My_Lead_to_Sofi__c = true;
         testlead.Channel_Sources__c = 'Bank';
         testlead.Channel_Values__c = 'RB Portal';
         insert testlead;


  
     
         PageReference ref= page.LeadDetail;
         Test.setCurrentPage(ref);
        
          
       
         ref.getParameters().put('id',testlead.id);
         ApexPages.StandardController sc2 = new ApexPages.standardController(testlead);
         LeadExtension Cntlr2 = new LeadExtension(sc2);
         Cntlr2.l=testlead;
         Cntlr2.init();
         }
         
         
         static testmethod void LeadExtensiontest17 (){
 
        Lead TestLead = new Lead();
         testlead.status = 'Active';
         testlead.firstname = 'testfirst';
         testlead.lastname = 'testlast';
         testlead.Company = 'Test';
         testlead.Empower_Lead_ID__c = 'D1010105';
         testlead.Is_Sofi_Lead__c = false;
         testlead.Property_State__c = 'TX';
         testlead.Borrowers_Mobile_Phone__c = '(111) 222-3333';
         testlead.My_Lead__c = true;
         testlead.Transfer_To_HLR__c = false;
         testlead.My_Lead_to_Sofi__c = true;
         testlead.Channel_Sources__c = 'Bank';
         testlead.Channel_Values__c = 'Direct 360';
         insert testlead;


  
     
         PageReference ref= page.LeadDetail;
         Test.setCurrentPage(ref);
        
          
       
         ref.getParameters().put('id',testlead.id);
         ApexPages.StandardController sc2 = new ApexPages.standardController(testlead);
         LeadExtension Cntlr2 = new LeadExtension(sc2);
         Cntlr2.l=testlead;
         Cntlr2.init();
         }
         
         
         static testmethod void LeadExtensiontest18 (){
 
        Lead TestLead = new Lead();
         testlead.status = 'New - Not Opened';
         testlead.firstname = 'testfirst';
         testlead.lastname = 'testlast';
         testlead.Company = 'Test';
         testlead.Empower_Lead_ID__c = '';
        // testlead.Is_Sofi_Lead__c = false;
         testlead.Property_State__c = 'TX';
         testlead.Borrowers_Mobile_Phone__c = '(111) 222-3333';
        // testlead.My_Lead__c = true;
         testlead.Transfer_To_HLR__c = false;
        // testlead.My_Lead_to_Sofi__c = false;
         testlead.Channel_Sources__c = 'Bank';
         testlead.Channel_Values__c = 'Inbound';
         insert testlead;


  
     
         PageReference ref= page.LeadDetail;
         Test.setCurrentPage(ref);
        
          
       
         ref.getParameters().put('id',testlead.id);
         ApexPages.StandardController sc2 = new ApexPages.standardController(testlead);
         LeadExtension Cntlr2 = new LeadExtension(sc2);
         Cntlr2.l=testlead;
         Cntlr2.init();
         }
         
         static testmethod void LeadExtensiontest19 (){
 
        Lead TestLead = new Lead();
         testlead.status = 'Active';
         testlead.firstname = 'testfirst';
         testlead.lastname = 'testlast';
         testlead.Company = 'Test';
         testlead.Empower_Lead_ID__c = 'D34567';
         testlead.Is_Sofi_Lead__c = true;
         testlead.Property_State__c = 'TX';
         testlead.Borrowers_Mobile_Phone__c = '(111) 222-3333';
         testlead.My_Lead__c = true;
         testlead.Transfer_To_HLR__c = true;
         testlead.My_Lead_to_Sofi__c = true;
         testlead.Channel_Sources__c = 'Bank';
         testlead.Channel_Values__c = 'Inbound';
         insert testlead;


  
     
         PageReference ref= page.LeadDetail;
         Test.setCurrentPage(ref);
        
          
       
         ref.getParameters().put('id',testlead.id);
         ApexPages.StandardController sc2 = new ApexPages.standardController(testlead);
         LeadExtension Cntlr2 = new LeadExtension(sc2);
         Cntlr2.l=testlead;
         Cntlr2.init();
         }

         static testmethod void LeadExtensiontest20 (){
 
        Lead TestLead = new Lead();
         testlead.status = 'Active';
         testlead.firstname = 'testfirst1';
         testlead.lastname = 'testlast1';
         testlead.Company = 'Test';
         testlead.Empower_Lead_ID__c = 'D34567';
         testlead.Is_Sofi_Lead__c = false;
         testlead.Property_State__c = 'TX';
         testlead.Borrowers_Mobile_Phone__c = '(111) 222-3333';
         testlead.My_Lead__c = false;
       //  testlead.Transfer_To_HLR__c = true;
       //  testlead.My_Lead_to_Sofi__c = true;
         testlead.Channel_Sources__c = 'Bank';
         testlead.Channel_Values__c = 'RB Portal';
         insert testlead;
         testlead.status = 'Active';
         update testlead;

  
     
         PageReference ref= page.LeadDetail;
         Test.setCurrentPage(ref);
        
          
       
         ref.getParameters().put('id',testlead.id);
         ApexPages.StandardController sc2 = new ApexPages.standardController(testlead);
         LeadExtension Cntlr2 = new LeadExtension(sc2);
         Cntlr2.l=testlead;
         Cntlr2.init();
         }
         
        static testmethod void LeadExtensiontest21 (){
 
         Lead TestLead = new Lead();
         testlead.status = 'New - Not Opened';
         testlead.firstname = 'testfirst1';
         testlead.lastname = 'testlast1';
         testlead.Company = 'Test';
         testlead.Empower_Lead_ID__c = 'D34567';
         testlead.Is_Sofi_Lead__c = true;
         testlead.Property_State__c = 'TX';
         testlead.Borrowers_Mobile_Phone__c = '(111) 222-3333';
       //  testlead.My_Lead__c = true;
       //  testlead.Transfer_To_HLR__c = true;
       //  testlead.My_Lead_to_Sofi__c = true;
         testlead.Channel_Sources__c = 'Bank';
         testlead.Channel_Values__c = 'RB Portal';
         insert testlead;
          testlead.status = 'New - Not Opened';
         update testlead;

  
     
         PageReference ref= page.LeadDetail;
         Test.setCurrentPage(ref);
        
          
       
         ref.getParameters().put('id',testlead.id);
         ApexPages.StandardController sc2 = new ApexPages.standardController(testlead);
         LeadExtension Cntlr2 = new LeadExtension(sc2);
         Cntlr2.l=testlead;
         Cntlr2.init();
         }
         
         
         static testmethod void LeadExtensiontest22 (){
 
         Lead TestLead = new Lead();
         testlead.status = 'New - Not Opened';
         testlead.firstname = 'testfirst1';
         testlead.lastname = 'testlast1';
         testlead.Company = 'Test';
         testlead.Empower_Lead_ID__c = 'D34567';
         testlead.Is_Sofi_Lead__c = true;
         testlead.Property_State__c = 'TX';
         testlead.Borrowers_Mobile_Phone__c = '(111) 222-3333';
       //  testlead.My_Lead__c = true;
       //  testlead.Transfer_To_HLR__c = true;
       //  testlead.My_Lead_to_Sofi__c = true;
         testlead.Channel_Sources__c = 'Bank';
         testlead.Channel_Values__c = 'Inbound';
         insert testlead;
          testlead.status = 'New - Not Opened';
         update testlead;

  
     
         PageReference ref= page.LeadDetail;
         Test.setCurrentPage(ref);
        
          
       
         ref.getParameters().put('id',testlead.id);
         ApexPages.StandardController sc2 = new ApexPages.standardController(testlead);
         LeadExtension Cntlr2 = new LeadExtension(sc2);
         Cntlr2.l=testlead;
         Cntlr2.init();
         }
         
         static testmethod void LeadExtensiontest23 (){
         
         Lead TestLead = new Lead();
         testlead.status = 'Active';
         testlead.firstname = 'testfirst1';
         testlead.lastname = 'testlast1';
         testlead.Company = 'Test';
         testlead.Empower_Lead_ID__c = 'D34567';
         testlead.Is_Sofi_Lead__c = false;
         testlead.Property_State__c = 'TX';
         testlead.Borrowers_Mobile_Phone__c = '(111) 222-3333';
         testlead.My_Lead__c = false;
       //  testlead.Transfer_To_HLR__c = true;
       //  testlead.My_Lead_to_Sofi__c = true;
         testlead.Channel_Sources__c = 'Bank';
         testlead.Channel_Values__c = 'Inbound';
         insert testlead;
         testlead.status = 'Active';
         update testlead;

  
     
         PageReference ref= page.LeadDetail;
         Test.setCurrentPage(ref);
        
          
       
         ref.getParameters().put('id',testlead.id);
         ApexPages.StandardController sc2 = new ApexPages.standardController(testlead);
         LeadExtension Cntlr2 = new LeadExtension(sc2);
         Cntlr2.l=testlead;
         Cntlr2.init();
         }
         
         
         static testmethod void LeadExtensiontest24 (){
 
         Lead TestLead1 = new Lead();
         testlead1.status = 'Active';
         testlead1.Empower_Lead_ID__c = 'D1010403';
         testlead1.Is_Sofi_Lead__c = false;
         testlead1.My_Lead__c = true;
         testlead1.Transfer_To_HLR__c = true;
         /*testlead.Channel__c = 'Centralized Retail';
         testlead.Channel_Sources__c = 'Bank';*/
         testlead1.firstname = 'testfirst';
         testlead1.lastname = 'testlast';
         testlead1.Company = 'Test';
         testlead1.Property_State__c = 'TX';
         testlead1.Borrowers_Mobile_Phone__c = '(111) 222-3333';
         insert testlead1;
         testlead1.status = 'Active';
         update testlead1;


  
     
         PageReference ref= page.LeadDetail;
         Test.setCurrentPage(ref);
        
          
       
         ref.getParameters().put('id',testlead1.id);
         ApexPages.StandardController sc2 = new ApexPages.standardController(testlead1);
         LeadExtension Cntlr2 = new LeadExtension(sc2);
         Cntlr2.l=testlead1;
         Cntlr2.init();
         
  
         } 
         
         static testmethod void LeadExtensiontest25 (){
 
         Lead TestLead1 = new Lead();
         testlead1.status = 'Active';
         testlead1.Empower_Lead_ID__c = 'D1010403';
         testlead1.Is_Sofi_Lead__c = false;
         testlead1.My_Lead__c = true;
         testlead1.Transfer_To_HLR__c = true;
         testlead1.Channel_Sources__c = 'Bank';
         testlead1.Channel_Values__c = 'RB Portal';
         testlead1.firstname = 'testfirst';
         testlead1.lastname = 'testlast';
         testlead1.Company = 'Test';
         testlead1.Property_State__c = 'TX';
         testlead1.Borrowers_Mobile_Phone__c = '(111) 222-3333';
         insert testlead1;
         testlead1.status = 'Active';
         update testlead1;


  
     
         PageReference ref= page.LeadDetail;
         Test.setCurrentPage(ref);
        
          
       
         ref.getParameters().put('id',testlead1.id);
         ApexPages.StandardController sc2 = new ApexPages.standardController(testlead1);
         LeadExtension Cntlr2 = new LeadExtension(sc2);
         Cntlr2.l=testlead1;
         Cntlr2.init();
         
  
         }
         
         static testmethod void LeadExtensiontest26 (){
 
        Lead TestLead = new Lead();
         testlead.status = 'Active';
         testlead.firstname = 'testfirst';
         testlead.lastname = 'testlast';
         testlead.Company = 'Test';
         testlead.Empower_Lead_ID__c = '';
         testlead.Property_State__c = 'TX';
         testlead.Borrowers_Mobile_Phone__c = '(111) 222-3333';
         //testlead.Channel_Sources__c = 'Bank';
         //testlead.Channel_Values__c ='RB Portal';
         testlead.Transfer_To_HLR__c = true;
         insert testlead;
         
         PageReference ref= page.LeadDetail;
         Test.setCurrentPage(ref);
        
          
       
         ref.getParameters().put('id',testlead.id);
         ApexPages.StandardController sc2 = new ApexPages.standardController(testlead);
         LeadExtension Cntlr2 = new LeadExtension(sc2);
         Cntlr2.l=testlead;
         Cntlr2.init();
         }
     
         }