@isTest
Public class mySofiLeadListViewController_Test{  
 Static TestMethod Void test_mySofiLeadListViewController(){
 
mySofiLeadListViewController ldc = new mySofiLeadListViewController();
 ldc.TName = 'john';
 ldc.Tsource = 'ABC';
 ldc.searchflag = true;
 //ldc.searchflag1 = true;
 ldc.SelectedU = 'ABC';
 ldc.Selectedstatus = 'Active';
 ldc.Selectedloanpurpose = 'Rent';
 ldc.Selectedsource = 'Source'; 
 //ldc.inputstr = 'name';
 ldc.errormessage = true;
 ldc.errorname = true;
 ldc.getSortDirection();
 ldc.setSortDirection('ASC');
 ldc.TPropertyS = 'TX';
 ldc.Onload();
 ldc.goLeads();
 ldc.colmnsorting1();
 ldc.Beginning();
 ldc.Next();
 ldc.Previous();
 ldc.End();
 ldc.getDisableNext();
 ldc.getDisablePrevious();
 ldc.getDisableEnd();
 ldc.refresh();
  }
    
Static TestMethod Void test_mySofiLeadListViewController2(){
 
 mySofiLeadListViewController ldc = new mySofiLeadListViewController();
 User lookupRMUser = [select Id from User where id = :userinfo.getUserId()limit 1];
 ldc.TName = 'john';
 ldc.Tsource = 'ABC';
 ldc.searchflag = false;
 ldc.total_size = 10;
 ldc.Beginning();  
 ldc.Next();
 ldc.Previous();
 ldc.getDisableNext();
 ldc.getDisablePrevious();
 ldc.End();
 ldc.SelectedU = 'ABC';
 ldc.Selectedstatus = 'Active';
 ldc.Selectedloanpurpose = 'Rent';
 ldc.Selectedsource = 'Source'; 
 ldc.errormessage = true;
 ldc.errorname = true;
 ldc.sortExpression = 'Name';
 ldc.getSortDirection();
 ldc.TPropertyS = 'TX';
 ldc.goLeads();
 ldc.refresh();
 }
 }