@isTest
Public class myLeadListViewController_Test{  
 Static TestMethod Void test_myLeadListViewController(){
 
myLeadListViewController ldc = new myLeadListViewController();
 ldc.TName = 'john';
 ldc.Tsource = 'ABC';
 ldc.searchflag = true;
 ldc.searchflag1 = true;
 ldc.SelectedU = 'ABC';
 ldc.Selectedstatus = 'Active';
 ldc.Selectedloanpurpose = 'Rent';
 ldc.Selectedsource = 'Source'; 
 ldc.inputstr = 'name';
 ldc.errormessage = true;
 ldc.errorname = true;
 ldc.getSortDirection();
 ldc.setSortDirection('ASC');
 ldc.TPropertyS = 'TX';
 ldc.Onload();
 ldc.goLeads();
 ldc.colmnsorting1();
 ldc.searchType = 'Name';
 ldc.Inputstr = 'john john';
  ldc.Search();
  ldc.colmnsorting();
   ldc.searchType = 'Name';
 ldc.Inputstr = 'john';
  ldc.Search();
  ldc.colmnsorting();
 ldc.searchType = 'Phone';
  ldc.Search();
  ldc.colmnsorting();
  ldc.searchType = 'Phone';
  ldc.Inputstr = '0123456789';
  ldc.Search();
  ldc.colmnsorting();
 ldc.searchType = 'Email';
  ldc.Search();
  ldc.colmnsorting();
 ldc.Beginning();
 ldc.Next();
 ldc.Previous();
 ldc.End();
 ldc.newlead();
 ldc.getDisableNext();
 ldc.getDisablePrevious();
 ldc.refresh();
 ldc.searchType = 'Email';
  ldc.Inputstr = '';
  ldc.Search();
  ldc.colmnsorting();
 }
    
Static TestMethod Void test_myLeadListViewController2(){
 
 myLeadListViewController ldc = new myLeadListViewController();
 User lookupRMUser = [select Id from User where id = :userinfo.getUserId()limit 1];
 ldc.TName = 'john';
 ldc.Tsource = 'ABC';
 ldc.searchflag = false;
 ldc.searchflag1 = true;
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
 ldc.inputstr = 'name';
 ldc.errormessage = true;
 ldc.errorname = true;
 ldc.sortExpression = 'Name';
 ldc.getSortDirection();
 ldc.TPropertyS = 'TX';
 ldc.Onload();
 ldc.goLeads();
 ldc.searchType = 'Name';
 ldc.Inputstr = 'john john';
  ldc.Search();
 ldc.searchType = 'Phone';
  ldc.Search();
 ldc.searchType = 'Email';
  ldc.Search();
 ldc.newlead();
 ldc.refresh();
 }
 }