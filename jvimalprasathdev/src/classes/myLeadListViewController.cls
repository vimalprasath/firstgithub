/*
Name: myLeadListViewController
Author: Piyush
Description: This Class is used for displaying Leads ListView on a visualforce page
Last modified by:
*/
public with sharing class myLeadListViewController {
    
    //new
    
   
    public List<SelectOption> UserListGS {get; set;} 
    public List<SelectOption> statusoptions {get; set;} 
    public List<SelectOption> loanpurposeoptions {get; set;} 
    public List<SelectOption> sourceoptions {get; set;}  
    public boolean hide{get;set;}// Boolean to hide List view
    Public boolean searchflag{get;set;} // Boolean to hide Top Search view
    Public boolean searchflag1{get;set;} // Boolean to hide Search filter view
    public String TName {get; set;}
    public String TPropertyS {get; set;}
    public String Tsource {get; set;}
    public String SelectedU {get; set;}
    public String Selectedstatus {get; set;}
    public String Selectedloanpurpose {get; set;}
    public String Selectedsource {get; set;}
    public String searchType{get; set;}
    public String inputstr{get; set;}
    public boolean errormessage{get;set;}
    public boolean errorname{get;set;}
    private String sortExp = 'Status';
    public string sortFullExp;
    private String sortDirection = 'DESC';
    public List<lead> led = new List<Lead>();
    List<User> UserList = new List<User>();       
    set<Id> inboundqueue = new Set<Id>();
    public List<Lead> filteredLead2{get;set;}
    public String ListViewURLID {get;set;}
    public integer counter{get;set;}  //keeps track of the offset
    public integer list_size{get;set;} //sets the page size or number of rows
    public integer total_size{get;set;} //used to show user the total size of the list
    public String sortExpression
       {
         get
         {
            return sortExp;
         }
         set
         {
           //if the column is clicked on then switch between Ascending and Descending modes
           if (value == sortExp)
             sortDirection = (sortDirection == 'ASC')? 'DESC' : 'ASC';
           else
             sortDirection = 'ASC';
           sortExp = value;
         }
       }
         public String getSortDirection()
         {
         //if not column is selected 
         if (sortExpression == null || sortExpression == '')
         return 'ASC';
         else
         return sortDirection;
         }

         public void setSortDirection(String value)
         {  
             sortDirection = value;
         }
         
   
         
         
/*********Added for pagination  */
   public PageReference Beginning() { //user clicked beginning
      counter = 0;
      if(searchflag == true)
       colmnsorting();
      else if(searchflag1 == true)                  
       colmnsorting1();
      return null;
   }
 
   public PageReference Previous() { //user clicked previous button
      counter -= list_size;
      if(searchflag == true)
       colmnsorting();
      else if(searchflag1 == true)                  
       colmnsorting1();
      return null;
   }
 
   public PageReference Next() { //user clicked next button
      counter += list_size;
      if(searchflag == true)
       colmnsorting();
      else if(searchflag1 == true)                  
       colmnsorting1();
      return null;
   }
 
   public PageReference End() { //user clicked end
      counter = total_size - math.mod(total_size, list_size);
      if(searchflag == true)
       colmnsorting();
      else if(searchflag1 == true)                  
       colmnsorting1();
      return null;
   }
 
   public Boolean getDisablePrevious() { 
      //this will disable the previous and beginning buttons
      system.debug('*******Previous'+counter);
      if (counter>0) return false; else return true;
   }
 
   public Boolean getDisableNext() { //this will disable the next buttons
      system.debug('*******Next'+(counter + list_size)+'*TS*'+total_size);
      if (counter + list_size < total_size) return false; else return true;
   }
   
    public Boolean getDisableEnd() { //this will disable the end buttons
      system.debug('*******Next'+(counter + list_size)+'*TS*'+total_size);
      if (total_size >= 2000) return true;
      if (counter + list_size < total_size) return false; else return true;
   }
/*********/ 

    public myLeadListViewController(){ 
        errormessage= false;
        errorname = false;
        inputstr = 'First Last';
        hide=True;
        searchflag = false;
        list_size = 25;
        counter = 0;
        List<QueueSobject> lstQueues = [SELECT Id,queue.Name, QueueId FROM QueueSobject WHERE SobjectType = 'Lead'];
        for (QueueSobject queueSobject : lstQueues) {
        inboundqueue.add(queueSobject.QueueId );
        }
        
        UserList =  getRoleSubordinateUsers(UserInfo.getUserId());
        UserList.sort(); 
        
        //new
        UserListGS = new List<SelectOption>();
        statusoptions = new List<SelectOption>(); 
        loanpurposeoptions = new List<SelectOption>(); 
        sourceoptions = new List<SelectOption>(); 
        
                                
        user temp = [select id,ProfileId,profile.name,userrole.name,name from user where id =: UserInfo.getuserid() limit 1];   
        UserListGS.add(new SelectOption(temp.id,temp.name)); 
        UserListGS.add(new SelectOption('None','None'));
        for(user temp1 : UserList){
            UserListGS.add(new SelectOption(temp1.id,temp1.name));         
        }
        
        
        Schema.DescribeFieldResult fieldResult = Lead.status.getDescribe();
        List<Schema.PicklistEntry> lestatus = fieldResult.getPicklistValues();
        statusoptions.add(new SelectOption('None','None'));
        for(Schema.PicklistEntry f : lestatus){
            statusoptions.add(new SelectOption(f.getLabel(), f.getValue()));
        }
        Schema.DescribeFieldResult fieldLoanPurpose = Lead.loan_purpose__c.getDescribe();
        List<Schema.PicklistEntry> leLop = fieldLoanPurpose.getPicklistValues();
        loanpurposeoptions.add(new SelectOption('None','None'));
        for(Schema.PicklistEntry f : leLop){
            loanpurposeoptions.add(new SelectOption(f.getLabel(), f.getValue()));
        }
        Schema.DescribeFieldResult fieldsource = Lead.Channel_Sources__c.getDescribe();
        List<Schema.PicklistEntry> lesource = fieldsource.getPicklistValues();
        sourceoptions.add(new SelectOption('None','None'));
        for(Schema.PicklistEntry f : lesource){
            sourceoptions.add(new SelectOption(f.getLabel(), f.getValue()));
        }
        //added to get ListView ID
        String q = 'SELECT Name FROM Lead LIMIT 1';
        ApexPages.StandardSetController ACC = new ApexPages.StandardSetController(Database.getQueryLocator(q));
        List<SelectOption> ListViews = ACC.getListViewOptions();
        for(SelectOption w : ListViews ){
            if(w.getLabel()=='My Leads'){
                ListViewURLID = w.getValue().left(15);
            }
        }
        System.debug('*********My Lead ID'+ListViewURLID);
       }    
    
   public void Onload() { 
    try {
    list<Lead> leadlist1 = new List<Lead>();      
    list<Lead> led =[select id,name,OwnerId,Empower_Lead_ID__c,My_Lead_to_Sofi__c from Lead where OwnerId not in :inboundqueue and isConverted=false and (Transfer_To_HLR__c = true) limit 500];     // or (empower_Lead_ID__c = null or empower_Lead_ID__c = '') Removed for check

        for(integer i=0; i<led.size(); i++){
            if(Led[i].Empower_Lead_ID__c != null) {
                if(Led[i].Empower_Lead_ID__c.contains('D')) {
                    Led[i].My_Lead_to_Sofi__c = true;
                    leadlist1.add(led[i]);
                  //  update led[i];
                }          
                //myFlag = false;
            }
        }
            update leadlist1;
            }
            catch (exception e) {
            
            }
    }
    
    public static List<User> getRoleSubordinateUsers(Id userId) {     
        // get requested user's role
        Id roleId = [select UserRoleId from User where Id = :userId].UserRoleId;
        // get all of the roles underneath the user
        Set<Id> allSubRoleIds = getAllSubRoleIds(new Set<ID>{roleId});
        // get all of the ids for the users in those roles
        List<User> UsersL = [Select Id, Name From User where UserRoleId IN :allSubRoleIds and IsActive = true];
        // return the ids as a set so you can do what you want with them
        return UsersL; 
    }
    
    private static Set<ID> getAllSubRoleIds(Set<ID> roleIds) {
        Set<ID> currentRoleIds = new Set<ID>();     
        // get all of the roles underneath the passed roles
        for(UserRole userRole :[select Id from UserRole where ParentRoleId 
          IN :roleIds AND ParentRoleID != null])
        currentRoleIds.add(userRole.Id);    
        // go fetch some more rolls!
        if(currentRoleIds.size() > 0)
          currentRoleIds.addAll(getAllSubRoleIds(currentRoleIds));
        return currentRoleIds; 
    }
    
    
   public void goLeads(){
  
   errormessage = false;
   errorname = false;
   hide=false;
   searchflag1 = true;
   searchflag = false;
   counter = 0;
   total_size = 0;
       set<Id> Allqueues = new Set<Id>();
       List<QueueSobject> lstQueues = [SELECT Id,queue.Name, QueueId FROM QueueSobject WHERE SobjectType = 'Lead'];
        for (QueueSobject queueSobject : lstQueues) {
        Allqueues.add(queueSobject.QueueId );
        }
      
       filteredLead2 = new List<Lead>(); 
       string sname=Tname+'%';
       string querystring;
       querystring='select id,name,owner.name,status,Source__c,Channel_Sources__c,Loan_Purpose__c,email,Empower_Lead_ID__c,createddate,Owner__c from Lead where OwnerId not in :Allqueues';
       
             
       if(Tname!=null && Tname!=''){
           querystring +=' and name like :sname ';
       }
       if(selectedstatus!='None'){
           if(Tname!=null)
               querystring +=' and ';   
           querystring +='status=:selectedstatus'; 
       }      
       if(selectedloanpurpose!='None'){
           if(Tname!=null || selectedstatus!='None')
               querystring +=' and ';
           querystring +='Loan_purpose__c=:selectedloanpurpose';
       }
       if(selectedsource!='None'){
           if(Tname!=null || selectedstatus!='None' || selectedloanpurpose!='None')
               querystring +=' and ';
           querystring +='channel_sources__c=:selectedsource';
       }
       if(SelectedU!='None'){
           if(Tname!=null || selectedstatus!='None' || selectedsource!='None' || selectedloanpurpose!='None' || TPropertyS!=null)
               querystring +=' and ';
           querystring +='ownerid=:SelectedU';
       }    
       string qs = querystring + ' Limit 5000';
       List<lead> ts = Database.query(qs);
       total_size = ts.size();
       querystring +=' limit :list_size offset :counter';
       filteredLead2=Database.query(querystring);
      if(filteredLead2 !=null && filteredLead2.size()>0){
            searchflag1 = true;
            
           }
      
       
       
   }
   
   
   
   
   public void Search(){
   errormessage = false;
   errorname = false;
   searchflag = true;
   searchflag1 = false;
   hide=false; 
   counter = 0;
   total_size = 0;
   filteredLead2 = new List<Lead>();
   string sname=Inputstr+'%';
   string querystring;
       
   string str = Inputstr;
   if(searchType == 'Name') {
       querystring='select id,name,owner.name,status,Channel_Sources__c,Loan_Purpose__c,email,createddate,Owner__c from Lead where isconverted=false'; 
       if(Inputstr!=null && Inputstr!=''){
          
           if(Inputstr.contains(' ')){
           String s1 = str;
           String name = '%'+s1.substringbefore(' ')+'%'+s1.substringAfter(' ')+'%';
           
           querystring +=' and Name Like \''+name+'\'';
           }
           else{
           errormessage = true;
           ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Must enter name in format: First Last'));
           }
           
           
       }
       else
        errorname = true;
     }
    else if(searchType == 'Phone') {
        string phn = Inputstr;
        querystring='select id,name,owner.name,status,Channel_Sources__c,Loan_Purpose__c,email,createddate,Owner__c from Lead where isconverted=false'; 
       
        
           if((Inputstr!=null || Inputstr!='' )&&Inputstr.length()>=10 ){
           errormessage = false;
               system.debug('entered error1');
               querystring +=' and (Phone =: Inputstr or Borrowers_Home_Phone__c =: Inputstr or Borrowers_Work_Phone__c =: Inputstr or Borrowers_Mobile_Phone__c =: Inputstr)';      
       }
       else{
       errorname = true;
       } 
    
    }
    
    else if(searchType == 'Email') {
       querystring='select id,name,owner.name,status,Channel_Sources__c,Loan_Purpose__c,email,createddate,Owner__c from Lead where isconverted=false'; 
       //  system.debug('%%%%%%Email%%%%%%'+inputstr);
       if(Inputstr!=null && Inputstr!=''){
       
           querystring +=' and Email =:Inputstr';
           system.debug('%%%%%%Email%%%%%%'+inputstr);
       }
       else{
        errorname = true;
       }
    
    }
     string qs = querystring + ' Limit 5000';
     List<lead> ts = Database.query(qs);
     total_size = ts.size();
     querystring +=' limit :list_size offset :counter';
     if(errormessage == false && errorname ==false) 
       filteredLead2=Database.query(querystring);
     else if(errorname ==true)
      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Please enter a value.'));
                   
           
   }
   
   
   public void colmnsorting(){
   sortFullExp = sortExpression  + ' ' + sortDirection;                  
   searchflag = true; 
   searchflag1 = false; 
   errormessage = false;
   errorname = false;
   searchflag = true;
   //counter = 0;
       filteredLead2 = new List<Lead>();
       string sname=Inputstr+'%';
       string querystring;
       
   string str = Inputstr;
   if(searchType == 'Name') {
       querystring='select id,name,owner.name,status,Channel_Sources__c,Loan_Purpose__c,email,createddate,Owner__c from Lead where isconverted=false'; 
              if(Inputstr!=null && Inputstr!=''){
          
           if(Inputstr.contains(' ')){
           String s1 = str;
           String name = '%'+s1.substringbefore(' ')+'%'+s1.substringAfter(' ')+'%';
           
           querystring +=' and Name Like \''+name+'\'';
           }
           else{
           searchflag = false;
           errorname = true;
           ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Must enter name in format: First Last'));
           }
           
           
       }
       else
        errorname = true;
     }
    else if(searchType == 'Phone') {
        string phn = Inputstr;
        querystring='select id,name,owner.name,status,Channel_Sources__c,Loan_Purpose__c,email,createddate,Owner__c from Lead where isconverted=false'; 
          if((Inputstr!=null || Inputstr!='')&&Inputstr.length()>=10){
           errormessage = false;
               system.debug('entered error1');
               querystring +=' and (Phone =: Inputstr or Borrowers_Home_Phone__c =: Inputstr or Borrowers_Work_Phone__c =: Inputstr or Borrowers_Mobile_Phone__c =: Inputstr)';      
       }
       else{
        errorname = true;
       }
        
    
    }
    
    else if(searchType == 'Email') {
       querystring='select id,name,owner.name,status,Channel_Sources__c,Loan_Purpose__c,email,createddate,Owner__c from Lead where isconverted=false'; 
       system.debug('*******Email%%%%%%'+querystring);
       if(Inputstr!=null && Inputstr!=''){
       
           querystring +=' and Email =:Inputstr';
           system.debug('%%%%%%Email%%%%%%'+inputstr);
       }
       else{
        errorname = true;
       }
    
    }

     if(errormessage == false && errorname ==false) {
       
       querystring +=' Order by ' +sortFullExp+' Nulls last';
       querystring +=' limit :list_size offset :counter';
       system.debug('*******Query%%%%%%'+querystring);
       filteredLead2=Database.query(querystring);
     }
     else
      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Please enter a value.'));
           
   
   }
   
   
   public void colmnsorting1(){
   sortFullExp = sortExpression  + ' ' + sortDirection;                  
   searchflag1 = true; 
   searchflag = false; 
   errormessage = false;
   errorname = false;
   //counter = 0;
   set<Id> Allqueues = new Set<Id>();
       List<QueueSobject> lstQueues = [SELECT Id,queue.Name, QueueId FROM QueueSobject WHERE SobjectType = 'Lead'];
        for (QueueSobject queueSobject : lstQueues) {
        Allqueues.add(queueSobject.QueueId );
        }
       filteredLead2 = new List<Lead>(); 
       string sname=Tname+'%';
       string querystring;
       querystring='select id,name,owner.name,status,Channel_Sources__c,Loan_Purpose__c,email,createddate,Owner__c from Lead where OwnerId not in :Allqueues';
       
             
       if(Tname!=null && Tname!=''){
           querystring +=' and name like :sname ';
       }
       if(selectedstatus!='None'){
           if(Tname!=null)
               querystring +=' and ';   
           querystring +='status=:selectedstatus'; 
       }      
       if(selectedloanpurpose!='None'){
           if(Tname!=null || selectedstatus!='None')
               querystring +=' and ';
           querystring +='Loan_purpose__c=:selectedloanpurpose';
       }
       if(selectedsource!='None'){
           if(Tname!=null || selectedstatus!='None' || selectedloanpurpose!='None')
               querystring +=' and ';
           querystring +='channel_sources__c=:selectedsource';
       }
       if(SelectedU!='None'){
           if(Tname!=null || selectedstatus!='None' || selectedsource!='None' || selectedloanpurpose!='None' || TPropertyS!=null)
               querystring +=' and ';
           querystring +='ownerid=:SelectedU';
       } 
          
       querystring +=' Order by ' +sortFullExp+' Nulls last';
       querystring +=' limit :list_size offset :counter';
       system.debug('*******Query1%%%%%%'+querystring);
       filteredLead2=Database.query(querystring);
            
     }
      
    public void refresh(){
       
        searchflag = false;
        searchflag1 = false;
        hide=true;
        selectedstatus='None';
        selectedloanpurpose='None';
        user temp = [select id,name from user where id =: UserInfo.getuserid() limit 1];
        selectedU=temp.name;
        selectedsource='None';
        Tname=null;
        TpropertyS=null;
        inputstr=null;
    }
    
     public pageReference newlead(){
        PageReference pgref = new PageReference('/00Q/e');
        return pgref;
    }

}