@istest
public class LeadExtension_Test{

/* public static testmethod void test_Lead_Extension0(){
    
     Database.DMLOptions dmo = new Database.DMLOptions();
     dmo.assignmentRuleHeader.useDefaultRule= true;
        Lead TestLead = new Lead();    
        TestLead.channel__c = 'Centralized Retail';  
        TestLead.Channel_Sources__c = 'Bank';
        TestLead.Channel_Values__c = 'RB Portal';
        TestLead.loan_purpose__c = 'Purchase';
        TestLead.department__c = 'Mid-Atlantic';
        TestLead.FirstName = 'ABCD';
        TestLead.Status = 'New - Not Opened';
        TestLead.VFUpdate__c = 'Yes';
        TestLead.New_to_Active__c = true;
        TestLead.Is_Sofi_Lead__c = true;
        TestLead.My_Lead__c = true;
        TestLead.Transfer_To_HLR__c = true;
        TestLead.My_Lead_to_Sofi__c = true;
        TestLead.Empower_Lead_ID__c = '';
        TestLead.Property_State__c = 'TX';
        TestLead.LastName = 'ABCD';
        TestLead.Company = 'ABCD';
        TestLead.setOptions(dmo);
        TestLead.RecordTypeId = [select Id from RecordType where Name Like: 'No_Send_to_empower' and SobjectType = 'Lead' limit 1].Id;
        insert TestLead;
        
        
         PageReference ref= page.LeadDetail;
         Test.setCurrentPage(ref);
         ref.getParameters().put('id',TestLead.id);
         ApexPages.StandardController sc1 = new ApexPages.standardController(TestLead);
         LeadExtension Cntlr1 = new LeadExtension(sc1);
         Cntlr1.init();
    
    } 


    public static testmethod void test_Lead_Extension(){
        //Positive TestLead
        Lead TestLead = new Lead();
        TestLead.Channel_Sources__c = 'Bank';
        TestLead.Channel_Values__c = 'RB Portal';
        TestLead.FirstName = 'ABCD';
        TestLead.Status = 'New - Not Opened';
        TestLead.VFUpdate__c = 'Yes';
        TestLead.New_to_Active__c = true;
        TestLead.Is_Sofi_Lead__c = true;
        TestLead.My_Lead__c = true;
        TestLead.Transfer_To_HLR__c = true;
        TestLead.My_Lead_to_Sofi__c = true;
        TestLead.Empower_Lead_ID__c = '';
        TestLead.Property_State__c = 'TX';
        TestLead.LastName = 'ABCD';
        TestLead.Company = 'ABCD';
        TestLead.RecordTypeId = [select Id from RecordType where Name Like: 'No_Send_to_empower' and SobjectType = 'Lead' limit 1].Id;
        insert TestLead;
        
        TestLead.Channel_Sources__c = 'Direct 360';
        TestLead.Channel_Values__c = 'Inbound';
        update TestLead;
        
            
         PageReference ref= page.LeadDetail;
         Test.setCurrentPage(ref);
         ref.getParameters().put('id',TestLead.id);
         ApexPages.StandardController sc1 = new ApexPages.standardController(TestLead);
         LeadExtension Cntlr1 = new LeadExtension(sc1);
         Cntlr1.init();
        
        //Negative TestLead
        Lead TestLeadN = new Lead();
        TestLeadN.Channel_Sources__c = 'Bank';
        TestLeadN.Channel_Values__c = 'Inbound';
        TestLeadN.FirstName = 'ABCD';
        TestLeadN.Status = 'New - Not Opened';
        TestLeadN.VFUpdate__c = 'Yes';
        TestLeadN.New_to_Active__c = true;
        TestLeadN.Is_Sofi_Lead__c = true;
        TestLeadN.My_Lead__c = true;
        TestLeadN.Transfer_To_HLR__c = true;
        TestLeadN.My_Lead_to_Sofi__c = true;
        TestLeadN.Empower_Lead_ID__c = '';
        TestLeadN.Property_State__c = 'TX';
        TestLeadN.LastName = 'ABCD';
        TestLeadN.Company = 'ABCD';
        TestLeadN.RecordTypeId = [select Id from RecordType where Name Like: 'RB No Send to empower' and SobjectType = 'Lead' limit 1].Id;
        insert TestLeadN;
        
        TestLeadN.Channel_Sources__c = 'RB Portal';
        TestLeadN.Channel_Values__c = 'Inbound';
        update TestLeadN;
        
        PageReference refN= page.LeadDetail;
         Test.setCurrentPage(refN);
         refN.getParameters().put('id',TestLeadN.id);
         ApexPages.StandardController sc1N = new ApexPages.standardController(TestLeadN);
         LeadExtension Cntlr1N = new LeadExtension(sc1N);
         Cntlr1N.init();
    }  
    static testmethod void test_Lead_Extension1()
    {
        Lead TestLead1 = new Lead();
        TestLead1.Channel_Sources__c = 'Bank';
        TestLead1.Channel_Values__c = 'RB Portal';
        TestLead1.FirstName = 'ABCD';
        TestLead1.Status = 'Active';
        TestLead1.VFUpdate__c = 'Yes';
        TestLead1.New_to_Active__c = true;
        TestLead1.Is_Sofi_Lead__c = true;
        TestLead1.My_Lead__c = true;
        TestLead1.Transfer_To_HLR__c = true;
        TestLead1.My_Lead_to_Sofi__c = true;
        TestLead1.Empower_Lead_ID__c = '';
        TestLead1.Property_State__c = 'TX';
        TestLead1.LastName = 'ABCD';
        TestLead1.Company = 'ABCD';
        TestLead1.RecordTypeId = [select Id from RecordType where Name Like: 'RB MC Send to empower when HLR true' and SobjectType = 'Lead' limit 1].Id;
        insert TestLead1;
        
        TestLead1.Channel_Sources__c = 'Direct 360';
        TestLead1.Channel_Values__c = 'Inbound';
        update TestLead1;
        
         PageReference ref1= page.LeadDetail;
         Test.setCurrentPage(ref1);
         ref1.getParameters().put('id',TestLead1.id);
         ApexPages.StandardController sc2 = new ApexPages.standardController(TestLead1);
         LeadExtension Cntlr2 = new LeadExtension(sc2);
         Cntlr2.init();
        
        //Negative TestLead
        Lead TestLeadN = new Lead();
        TestLeadN.Channel_Sources__c = 'Bank';
        TestLeadN.Channel_Values__c = 'Inbound';
        TestLeadN.FirstName = 'ABCD';
        TestLeadN.Status = 'Active';
        TestLeadN.VFUpdate__c = 'Yes';
        TestLeadN.New_to_Active__c = true;
        TestLeadN.Is_Sofi_Lead__c = true;
        TestLeadN.My_Lead__c = true;
        TestLeadN.Transfer_To_HLR__c = true;
        TestLeadN.My_Lead_to_Sofi__c = true;
        TestLeadN.Empower_Lead_ID__c = '';
        TestLeadN.Property_State__c = 'TX';
        TestLeadN.LastName = 'ABCD';
        TestLeadN.Company = 'ABCD';
        TestLeadN.RecordTypeId = [select Id from RecordType where Name Like: 'No Send to empower Unlock HLR Lead Id' and SobjectType = 'Lead' limit 1].Id;
        insert TestLeadN;
        
        TestLeadN.Channel_Sources__c = 'RB Portal';
        TestLeadN.Channel_Values__c = 'Inbound';
        update TestLeadN;
        
        PageReference refN= page.LeadDetail;
         Test.setCurrentPage(refN);
         refN.getParameters().put('id',TestLeadN.id);
         ApexPages.StandardController sc1N = new ApexPages.standardController(TestLeadN);
         LeadExtension Cntlr1N = new LeadExtension(sc1N);
         Cntlr1N.init();
    }
        
    static testmethod void test_Lead_Extension2(){
        Lead TestLead2 = new Lead();
        TestLead2.Channel_Sources__c = 'Bank';
        TestLead2.Channel_Values__c = 'RB Portal';
        TestLead2.FirstName = 'ABCD';
        TestLead2.Status = 'Active';
        TestLead2.VFUpdate__c = 'Yes';
        TestLead2.New_to_Active__c = true;
        TestLead2.Is_Sofi_Lead__c = true;
        TestLead2.My_Lead__c = true;
        TestLead2.Transfer_To_HLR__c = false;
        TestLead2.My_Lead_to_Sofi__c = true;
        TestLead2.Empower_Lead_ID__c = '';
        TestLead2.Property_State__c = 'TX';
        TestLead2.LastName = 'ABCD';
        TestLead2.Company = 'ABCD';
        TestLead2.RecordTypeId = [select Id from RecordType where Name Like: 'RB No Send to empower Unlock HLR Lead Id' and SobjectType = 'Lead' limit 1].Id;
        insert TestLead2;
        
        TestLead2.Channel_Sources__c = 'Direct 360';
        TestLead2.Channel_Values__c = 'Inbound';
        update TestLead2;
        
         PageReference ref2= page.LeadDetail;
         Test.setCurrentPage(ref2);
         ref2.getParameters().put('id',TestLead2.id);
         ApexPages.StandardController sc3 = new ApexPages.standardController(TestLead2);
         LeadExtension Cntlr3 = new LeadExtension(sc3);
         Cntlr3.init();
        
        //Negative TestLead
        Lead TestLeadN = new Lead();
        TestLeadN.Channel_Sources__c = 'Bank';
        TestLeadN.Channel_Values__c = 'Inbound';
        TestLeadN.FirstName = 'ABCD';
        TestLeadN.Status = 'Active';
        TestLeadN.VFUpdate__c = 'Yes';
        TestLeadN.New_to_Active__c = true;
        TestLeadN.Is_Sofi_Lead__c = true;
        TestLeadN.My_Lead__c = true;
        TestLeadN.Transfer_To_HLR__c = false;
        TestLeadN.My_Lead_to_Sofi__c = true;
        TestLeadN.Empower_Lead_ID__c = '';
        TestLeadN.Property_State__c = 'TX';
        TestLeadN.LastName = 'ABCD';
        TestLeadN.Company = 'ABCD';
        TestLeadN.RecordTypeId = [select Id from RecordType where Name Like: 'MC_Send_to_empower_when_HLR_true' and SobjectType = 'Lead' limit 1].Id;
        insert TestLeadN;
        
        TestLeadN.Channel_Sources__c = 'RB Portal';
        TestLeadN.Channel_Values__c = 'Inbound';
        update TestLeadN;
        
        PageReference refN= page.LeadDetail;
         Test.setCurrentPage(refN);
         refN.getParameters().put('id',TestLeadN.id);
         ApexPages.StandardController sc1N = new ApexPages.standardController(TestLeadN);
         LeadExtension Cntlr1N = new LeadExtension(sc1N);
         Cntlr1N.init();
  
    }
        
    static testmethod void test_Lead_Extension3(){
        Lead TestLead3 = new Lead();
        TestLead3.Channel_Sources__c = 'Bank';
        TestLead3.Channel_Values__c = 'RB Portal';
        TestLead3.FirstName = 'ABCD';
        TestLead3.Status = 'New - Not Opened';
        TestLead3.VFUpdate__c = 'Yes';
        TestLead3.New_to_Active__c = true;
        TestLead3.Is_Sofi_Lead__c = false;
        TestLead3.My_Lead__c = true;
        TestLead3.Transfer_To_HLR__c = false;
        TestLead3.My_Lead_to_Sofi__c = false;
        TestLead3.Empower_Lead_ID__c = 'D101010';
        TestLead3.Property_State__c = 'TX';
        TestLead3.LastName = 'ABCD';
        TestLead3.Company = 'ABCD';
        TestLead3.RecordTypeId = [select Id from RecordType where Name Like: 'RB No Send to empower1' and SobjectType = 'Lead' limit 1].Id;
        insert TestLead3;
        
        TestLead3.Channel_Sources__c = 'Direct 360';
        TestLead3.Channel_Values__c = 'Inbound';
        update TestLead3;
        
         PageReference ref3= page.LeadDetail;
         Test.setCurrentPage(ref3);
         ref3.getParameters().put('id',TestLead3.id);
         ApexPages.StandardController sc4 = new ApexPages.standardController(TestLead3);
         LeadExtension Cntlr4 = new LeadExtension(sc4);
         Cntlr4.init();
        
        //Negative TestLead
        Lead TestLeadN = new Lead();
        TestLeadN.Channel_Sources__c = 'Bank';
        TestLeadN.Channel_Values__c = 'Inbound';
        TestLeadN.FirstName = 'ABCD';
        TestLeadN.Status = 'New - Not Opened';
        TestLeadN.VFUpdate__c = 'Yes';
        TestLeadN.New_to_Active__c = true;
        TestLeadN.Is_Sofi_Lead__c = false;
        TestLeadN.My_Lead__c = true;
        TestLeadN.Transfer_To_HLR__c = false;
        TestLeadN.My_Lead_to_Sofi__c = false;
        TestLeadN.Empower_Lead_ID__c = 'D101011';
        TestLeadN.Property_State__c = 'TX';
        TestLeadN.LastName = 'ABCD';
        TestLeadN.Company = 'ABCD';
        TestLeadN.RecordTypeId = [select Id from RecordType where Name Like: 'No_Send_to_empower1' and SobjectType = 'Lead' limit 1].Id;
        insert TestLeadN;
        
        TestLeadN.Channel_Sources__c = 'RB Portal';
        TestLeadN.Channel_Values__c = 'Inbound';
        update TestLeadN;
        
        PageReference refN= page.LeadDetail;
         Test.setCurrentPage(refN);
         refN.getParameters().put('id',TestLeadN.id);
         ApexPages.StandardController sc1N = new ApexPages.standardController(TestLeadN);
         LeadExtension Cntlr1N = new LeadExtension(sc1N);
         Cntlr1N.init();
       
    }
    
    static testmethod void test_Lead_Extension4(){
        Lead TestLead4 = new Lead();
        TestLead4.Channel_Sources__c = 'Bank';
        TestLead4.Channel_Values__c = 'RB Portal';
        TestLead4.FirstName = 'ABCD';
        TestLead4.Status = 'New - Not Opened';
        TestLead4.VFUpdate__c = 'Yes';
        TestLead4.New_to_Active__c = true;
        TestLead4.Is_Sofi_Lead__c = true;
        TestLead4.My_Lead__c = true;
        TestLead4.Transfer_To_HLR__c = true;
        TestLead4.My_Lead_to_Sofi__c = true;
        TestLead4.Empower_Lead_ID__c = 'D101011';
        TestLead4.Property_State__c = 'TX';
        TestLead4.LastName = 'ABCD';
        TestLead4.Company = 'ABCD';
        TestLead4.RecordTypeId = [select Id from RecordType where Name Like: 'RB No send to empower in  My Sofi Leads' and SobjectType = 'Lead' limit 1].Id;
        insert TestLead4;
        
        TestLead4.Channel_Sources__c = 'Direct 360';
        TestLead4.Channel_Values__c = 'Inbound';
        update TestLead4;
        
         PageReference ref4= page.LeadDetail;
         Test.setCurrentPage(ref4);
         ref4.getParameters().put('id',TestLead4.id);
         ApexPages.StandardController sc5 = new ApexPages.standardController(TestLead4);
         LeadExtension Cntlr5 = new LeadExtension(sc5);
         Cntlr5.init();
        
         //Negative TestLead
        Lead TestLeadN = new Lead();
        TestLeadN.Channel_Sources__c = 'Bank';
        TestLeadN.Channel_Values__c = 'Inbound';
        TestLeadN.FirstName = 'ABCD';
        TestLeadN.Status = 'New - Not Opened';
        TestLeadN.VFUpdate__c = 'Yes';
        TestLeadN.New_to_Active__c = true;
        TestLeadN.Is_Sofi_Lead__c = true;
        TestLeadN.My_Lead__c = true;
        TestLeadN.Transfer_To_HLR__c = true;
        TestLeadN.My_Lead_to_Sofi__c = true;
        TestLeadN.Empower_Lead_ID__c = 'D101012';
        TestLeadN.Property_State__c = 'TX';
        TestLeadN.LastName = 'ABCD';
        TestLeadN.Company = 'ABCD';
        TestLeadN.RecordTypeId = [select Id from RecordType where Name Like: 'No send to empower in My Sofi Leads' and SobjectType = 'Lead' limit 1].Id;
        insert TestLeadN;
        
        TestLeadN.Channel_Sources__c = 'RB Portal';
        TestLeadN.Channel_Values__c = 'Inbound';
        update TestLeadN;
        
        PageReference refN= page.LeadDetail;
         Test.setCurrentPage(refN);
         refN.getParameters().put('id',TestLeadN.id);
         ApexPages.StandardController sc1N = new ApexPages.standardController(TestLeadN);
         LeadExtension Cntlr1N = new LeadExtension(sc1N);
         Cntlr1N.init();
        
    }
    
    static testmethod void test_Lead_Extension5(){
        Lead TestLead4 = new Lead();
        TestLead4.Channel_Sources__c = 'Bank';
        TestLead4.Channel_Values__c = 'RB Portal';
        TestLead4.FirstName = 'ABCD';
        TestLead4.Status = 'Active';
        TestLead4.VFUpdate__c = 'Yes';
        TestLead4.New_to_Active__c = true;
        TestLead4.Is_Sofi_Lead__c = false;
        TestLead4.My_Lead__c = false;
        TestLead4.Transfer_To_HLR__c = true;
        TestLead4.My_Lead_to_Sofi__c = true;
        TestLead4.Empower_Lead_ID__c = 'D101011';
        TestLead4.Property_State__c = 'TX';
        TestLead4.LastName = 'ABCD';
        TestLead4.Company = 'ABCD';
        TestLead4.RecordTypeId = [select Id from RecordType where Name Like: 'RB No send to empower in  My Sofi Leads' and SobjectType = 'Lead' limit 1].Id;
        insert TestLead4;
        
        TestLead4.Channel_Sources__c = 'Direct 360';
        TestLead4.Channel_Values__c = 'Inbound';
        update TestLead4;
        
         PageReference ref4= page.LeadDetail;
         Test.setCurrentPage(ref4);
         ref4.getParameters().put('id',TestLead4.id);
         ApexPages.StandardController sc5 = new ApexPages.standardController(TestLead4);
         LeadExtension Cntlr5 = new LeadExtension(sc5);
         Cntlr5.init();
        
        //Negative TestLead
        Lead TestLeadN = new Lead();
        TestLeadN.Channel_Sources__c = 'Bank';
        TestLeadN.Channel_Values__c = 'Inbound';
        TestLeadN.FirstName = 'ABCD';
        TestLeadN.Status = 'Active';
        TestLeadN.VFUpdate__c = 'Yes';
        TestLeadN.New_to_Active__c = true;
        TestLeadN.Is_Sofi_Lead__c = false;
        TestLeadN.My_Lead__c = false;
        TestLeadN.Transfer_To_HLR__c = true;
        TestLeadN.My_Lead_to_Sofi__c = true;
        TestLeadN.Empower_Lead_ID__c = 'D101012';
        TestLeadN.Property_State__c = 'TX';
        TestLeadN.LastName = 'ABCD';
        TestLeadN.Company = 'ABCD';
        TestLeadN.RecordTypeId = [select Id from RecordType where Name Like: 'No send to empower in My Sofi Leads' and SobjectType = 'Lead' limit 1].Id;
        insert TestLeadN;
        
        TestLeadN.Channel_Sources__c = 'RB Portal';
        TestLeadN.Channel_Values__c = 'Inbound';
        update TestLeadN;
        
        PageReference refN= page.LeadDetail;
         Test.setCurrentPage(refN);
         refN.getParameters().put('id',TestLeadN.id);
         ApexPages.StandardController sc1N = new ApexPages.standardController(TestLeadN);
         LeadExtension Cntlr1N = new LeadExtension(sc1N);
         Cntlr1N.init();
        
    }
    
    static testmethod void test_Lead_Extension6(){
        Lead TestLead4 = new Lead();
        TestLead4.Channel_Sources__c = 'Bank';
        TestLead4.Channel_Values__c = 'RB Portal';
        TestLead4.FirstName = 'ABCD';
        TestLead4.Status = 'Active';
        TestLead4.VFUpdate__c = 'Yes';
        TestLead4.New_to_Active__c = true;
        TestLead4.Is_Sofi_Lead__c = true;
        TestLead4.My_Lead__c = false;
        TestLead4.Transfer_To_HLR__c = true;
        TestLead4.My_Lead_to_Sofi__c = true;
        TestLead4.Empower_Lead_ID__c = 'D101011';
        TestLead4.Property_State__c = 'TX';
        TestLead4.LastName = 'ABCD';
        TestLead4.Company = 'ABCD';
        TestLead4.RecordTypeId = [select Id from RecordType where Name Like: 'RB No Send To Empower for My Sofi leads with HLR ID Unlocked' and SobjectType = 'Lead' limit 1].Id;
        insert TestLead4;
        
        TestLead4.Channel_Sources__c = 'Direct 360';
        TestLead4.Channel_Values__c = 'Inbound';
        update TestLead4;
        
         PageReference ref4= page.LeadDetail;
         Test.setCurrentPage(ref4);
         ref4.getParameters().put('id',TestLead4.id);
         ApexPages.StandardController sc5 = new ApexPages.standardController(TestLead4);
         LeadExtension Cntlr5 = new LeadExtension(sc5);
         Cntlr5.init();
        
        //Negative TestLead
        Lead TestLeadN = new Lead();
        TestLeadN.Channel_Sources__c = 'Bank';
        TestLeadN.Channel_Values__c = 'Inbound';
        TestLeadN.FirstName = 'ABCD';
        TestLeadN.Status = 'Active';
        TestLeadN.VFUpdate__c = 'Yes';
        TestLeadN.New_to_Active__c = true;
        TestLeadN.Is_Sofi_Lead__c = true;
        TestLeadN.My_Lead__c = false;
        TestLeadN.Transfer_To_HLR__c = true;
        TestLeadN.My_Lead_to_Sofi__c = true;
        TestLeadN.Empower_Lead_ID__c = 'D101012';
        TestLeadN.Property_State__c = 'TX';
        TestLeadN.LastName = 'ABCD';
        TestLeadN.Company = 'ABCD';
        TestLeadN.RecordTypeId = [select Id from RecordType where Name Like: 'No Send To Empower for My Sofi leads with HLR ID Unlocked' and SobjectType = 'Lead' limit 1].Id;
        insert TestLeadN;
        
        TestLeadN.Channel_Sources__c = 'RB Portal';
        TestLeadN.Channel_Values__c = 'Inbound';
        update TestLeadN;
        
        PageReference refN= page.LeadDetail;
         Test.setCurrentPage(refN);
         refN.getParameters().put('id',TestLeadN.id);
         ApexPages.StandardController sc1N = new ApexPages.standardController(TestLeadN);
         LeadExtension Cntlr1N = new LeadExtension(sc1N);
         Cntlr1N.init();
        
    }
    
    static testmethod void test_Lead_Extension7(){
        Lead TestLead4 = new Lead();
        TestLead4.Channel_Sources__c = 'Bank';
        TestLead4.Channel_Values__c = 'RB Portal';
        TestLead4.FirstName = 'ABCD';
        TestLead4.Status = 'Active';
        TestLead4.VFUpdate__c = 'Yes';
        TestLead4.New_to_Active__c = true;
        TestLead4.Is_Sofi_Lead__c = false;
        TestLead4.My_Lead__c = true;
        TestLead4.Transfer_To_HLR__c = true;
        TestLead4.My_Lead_to_Sofi__c = true;
        TestLead4.Empower_Lead_ID__c = 'D101011';
        TestLead4.Property_State__c = 'TX';
        TestLead4.LastName = 'ABCD';
        TestLead4.Company = 'ABCD';
        TestLead4.RecordTypeId = [select Id from RecordType where Name Like: 'RB No Send To Empower for My Sofi leads with HLR ID Unlocked' and SobjectType = 'Lead' limit 1].Id;
        insert TestLead4;
        
        TestLead4.Channel_Sources__c = 'Direct 360';
        TestLead4.Channel_Values__c = 'Inbound';
        update TestLead4;
        
         PageReference ref4= page.LeadDetail;
         Test.setCurrentPage(ref4);
         ref4.getParameters().put('id',TestLead4.id);
         ApexPages.StandardController sc5 = new ApexPages.standardController(TestLead4);
         LeadExtension Cntlr5 = new LeadExtension(sc5);
         Cntlr5.init();
        
        //Negative TestLead
        Lead TestLeadN = new Lead();
        TestLeadN.Channel_Sources__c = 'Bank';
        TestLeadN.Channel_Values__c = 'Inbound';
        TestLeadN.FirstName = 'ABCD';
        TestLeadN.Status = 'Active';
        TestLeadN.VFUpdate__c = 'Yes';
        TestLeadN.New_to_Active__c = true;
        TestLeadN.Is_Sofi_Lead__c = false;
        TestLeadN.My_Lead__c = true;
        TestLeadN.Transfer_To_HLR__c = true;
        TestLeadN.My_Lead_to_Sofi__c = true;
        TestLeadN.Empower_Lead_ID__c = 'D101012';
        TestLeadN.Property_State__c = 'TX';
        TestLeadN.LastName = 'ABCD';
        TestLeadN.Company = 'ABCD';
        TestLeadN.RecordTypeId = [select Id from RecordType where Name Like: 'No Send To Empower for My Sofi leads with HLR ID Unlocked' and SobjectType = 'Lead' limit 1].Id;
        insert TestLeadN;
        
        TestLeadN.Channel_Sources__c = 'RB Portal';
        TestLeadN.Channel_Values__c = 'Inbound';
        update TestLeadN;
        
        PageReference refN= page.LeadDetail;
         Test.setCurrentPage(refN);
         refN.getParameters().put('id',TestLeadN.id);
         ApexPages.StandardController sc1N = new ApexPages.standardController(TestLeadN);
         LeadExtension Cntlr1N = new LeadExtension(sc1N);
         Cntlr1N.init();
        
    }
    
    static testmethod void test_Lead_Extension8(){
        Lead TestLead4 = new Lead();
        TestLead4.Channel_Sources__c = 'Bank';
        TestLead4.Channel_Values__c = 'RB Portal';
        TestLead4.FirstName = 'ABCD';
        TestLead4.Status = 'Active';
        TestLead4.VFUpdate__c = 'Yes';
        TestLead4.New_to_Active__c = true;
        TestLead4.Is_Sofi_Lead__c = false;
        TestLead4.My_Lead__c = true;
        TestLead4.Transfer_To_HLR__c = false;
        TestLead4.My_Lead_to_Sofi__c = true;
        TestLead4.Empower_Lead_ID__c = 'D101011';
        TestLead4.Property_State__c = 'TX';
        TestLead4.LastName = 'ABCD';
        TestLead4.Company = 'ABCD';
        TestLead4.RecordTypeId = [select Id from RecordType where Name Like: 'RB No Send to empower2' and SobjectType = 'Lead' limit 1].Id;
        insert TestLead4;
        
        TestLead4.Channel_Sources__c = 'Direct 360';
        TestLead4.Channel_Values__c = 'Inbound';
        update TestLead4;
        
         PageReference ref4= page.LeadDetail;
         Test.setCurrentPage(ref4);
         ref4.getParameters().put('id',TestLead4.id);
         ApexPages.StandardController sc5 = new ApexPages.standardController(TestLead4);
         LeadExtension Cntlr5 = new LeadExtension(sc5);
         Cntlr5.init();
        
        //Negative TestLead
        Lead TestLeadN = new Lead();
        TestLeadN.Channel_Sources__c = 'Bank';
        TestLeadN.Channel_Values__c = 'Inbound';
        TestLeadN.FirstName = 'ABCD';
        TestLeadN.Status = 'Active';
        TestLeadN.VFUpdate__c = 'Yes';
        TestLeadN.New_to_Active__c = true;
        TestLeadN.Is_Sofi_Lead__c = false;
        TestLeadN.My_Lead__c = true;
        TestLeadN.Transfer_To_HLR__c = false;
        TestLeadN.My_Lead_to_Sofi__c = true;
        TestLeadN.Empower_Lead_ID__c = 'D101012';
        TestLeadN.Property_State__c = 'TX';
        TestLeadN.LastName = 'ABCD';
        TestLeadN.Company = 'ABCD';
        TestLeadN.RecordTypeId = [select Id from RecordType where Name Like: 'No_Send_to_empower2' and SobjectType = 'Lead' limit 1].Id;
        insert TestLeadN;
        
        TestLeadN.Channel_Sources__c = 'RB Portal';
        TestLeadN.Channel_Values__c = 'Inbound';
        update TestLeadN;
        
        PageReference refN= page.LeadDetail;
         Test.setCurrentPage(refN);
         refN.getParameters().put('id',TestLeadN.id);
         ApexPages.StandardController sc1N = new ApexPages.standardController(TestLeadN);
         LeadExtension Cntlr1N = new LeadExtension(sc1N);
         Cntlr1N.init();
        
    }
    
    static testmethod void test_Lead_Extension9(){
        Lead TestLead4 = new Lead();
        TestLead4.Channel_Sources__c = 'Bank';
        TestLead4.Channel_Values__c = 'RB Portal';
        TestLead4.FirstName = 'ABCD';
        TestLead4.Status = 'Active';
        TestLead4.VFUpdate__c = 'Yes';
        TestLead4.New_to_Active__c = true;
        TestLead4.Is_Sofi_Lead__c = false;
        TestLead4.My_Lead__c = true;
        TestLead4.Transfer_To_HLR__c = false;
        TestLead4.My_Lead_to_Sofi__c = false;
        TestLead4.Empower_Lead_ID__c = 'D101011';
        TestLead4.Property_State__c = 'TX';
        TestLead4.LastName = 'ABCD';
        TestLead4.Company = 'ABCD';
        TestLead4.RecordTypeId = [select Id from RecordType where Name Like: 'RB No send to empower in  My Sofi Leads without HLR' and SobjectType = 'Lead' limit 1].Id;
        insert TestLead4;
        
        TestLead4.Channel_Sources__c = 'Direct 360';
        TestLead4.Channel_Values__c = 'Inbound';
        update TestLead4;
        
         PageReference ref4= page.LeadDetail;
         Test.setCurrentPage(ref4);
         ref4.getParameters().put('id',TestLead4.id);
         ApexPages.StandardController sc5 = new ApexPages.standardController(TestLead4);
         LeadExtension Cntlr5 = new LeadExtension(sc5);
         Cntlr5.init();
        
        //Negative TestLead
        Lead TestLeadN = new Lead();
        TestLeadN.Channel_Sources__c = 'Bank';
        TestLeadN.Channel_Values__c = 'Inbound';
        TestLeadN.FirstName = 'ABCD';
        TestLeadN.Status = 'Active';
        TestLeadN.VFUpdate__c = 'Yes';
        TestLeadN.New_to_Active__c = true;
        TestLeadN.Is_Sofi_Lead__c = false;
        TestLeadN.My_Lead__c = true;
        TestLeadN.Transfer_To_HLR__c = false;
        TestLeadN.My_Lead_to_Sofi__c = false;
        TestLeadN.Empower_Lead_ID__c = 'D101012';
        TestLeadN.Property_State__c = 'TX';
        TestLeadN.LastName = 'ABCD';
        TestLeadN.Company = 'ABCD';
        TestLeadN.RecordTypeId = [select Id from RecordType where Name Like: 'No send to empower in My Sofi Leads without HLR' and SobjectType = 'Lead' limit 1].Id;
        insert TestLeadN;
        
        TestLeadN.Channel_Sources__c = 'RB Portal';
        TestLeadN.Channel_Values__c = 'Inbound';
        update TestLeadN;
        
        PageReference refN= page.LeadDetail;
         Test.setCurrentPage(refN);
         refN.getParameters().put('id',TestLeadN.id);
         ApexPages.StandardController sc1N = new ApexPages.standardController(TestLeadN);
         LeadExtension Cntlr1N = new LeadExtension(sc1N);
         Cntlr1N.init();
        
    }
    
    static testmethod void test_Lead_Extension10(){
        Lead TestLead4 = new Lead();
        TestLead4.Channel_Sources__c = 'Bank';
        TestLead4.Channel_Values__c = 'RB Portal';
        TestLead4.FirstName = 'ABCD';
        //TestLead4.Status = 'Active';
        TestLead4.VFUpdate__c = 'Yes';
        TestLead4.New_to_Active__c = true;
        TestLead4.Is_Sofi_Lead__c = false;
        TestLead4.My_Lead__c = true;
        TestLead4.Transfer_To_HLR__c = false;
        TestLead4.My_Lead_to_Sofi__c = false;
        TestLead4.Empower_Lead_ID__c = 'E101011';
        TestLead4.Property_State__c = 'TX';
        TestLead4.LastName = 'ABCD';
        TestLead4.Company = 'ABCD';
        TestLead4.RecordTypeId = [select Id from RecordType where Name Like: 'For_My_loans' and SobjectType = 'Lead' limit 1].Id;
        insert TestLead4;
        
        TestLead4.Channel_Sources__c = 'Direct 360';
        TestLead4.Channel_Values__c = 'Inbound';
        update TestLead4;
        
         PageReference ref4= page.LeadDetail;
         Test.setCurrentPage(ref4);
         ref4.getParameters().put('id',TestLead4.id);
         ApexPages.StandardController sc5 = new ApexPages.standardController(TestLead4);
         LeadExtension Cntlr5 = new LeadExtension(sc5);
         Cntlr5.init();
        
    }*/
    
}