@isTest
Public class myContactController_Test{  
 Static TestMethod Void TestmyContactController()  {
 
 myContactController mcc = new myContactController();
 mcc.SelectedCT='None';
 mcc.SelectedU='None';
 mcc.goContacts();
 mcc.getVFContacts();
 mcc.RefereshCT();
 mcc.newContact();  
 }
 }