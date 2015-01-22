@istest
public class CO_PortalLeadDetailController_Test{ 
 Static Testmethod Void TestCO_PortalLeadDetailController(){ 
 
 Customer_Portal_Lead__c CPLead = new Customer_Portal_Lead__c();
 CPLead.property_located__c = 'TX';
 CPLead.property_state__c = 'TX';
 insert cplead;
 PageReference pageRef = page.CO_PortalLeadDetail_VF;
 Test.setCurrentPage(pageRef);
 pageRef.getParameters().put('id',CPlead.id);
 ApexPages.StandardController sc = new ApexPages.standardController(cplead);
 
 CO_PortalLeadDetailController pld = new CO_PortalLeadDetailController(sc);
 pld.SaveNote();
 pld.ClosePopUp();
 pld.CreateLead();
 pld.showsubmit();
 pld.backbutton ();
 }
 }