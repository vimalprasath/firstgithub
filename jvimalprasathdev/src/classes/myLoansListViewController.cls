/*
Name: myLoansListViewController
Author: Piyush
Description: This Class is used for displaying Leads ListView on a visualforce page
Last modified by:
*/
public with sharing class myLoansListViewController {
    
    //new
    
   
    public List<SelectOption> UserListGS {get; set;} 
    public List<SelectOption> statusoptions {get; set;} 
    public List<SelectOption> loanpurposeoptions {get; set;} 
    public List<SelectOption> sourceoptions {get; set;}  
    public boolean hide{get;set;}// Boolean to hide List view
    Public boolean searchflag{get;set;} // Boolean to hide Search view
    public String TName {get; set;}
    public String TPropertyS {get; set;}
    public String Tsource {get; set;}
    public String SelectedU {get; set;}
    public String Selectedstatus {get; set;}
    public String Selectedloanpurpose {get; set;}
    public String Selectedsource {get; set;}
    public boolean errormessage{get;set;}
    public boolean errorname{get;set;}
    private String sortExp = 'Status';
    public string sortFullExp;
    private String sortDirection = 'DESC';
    public List<lead> led = new List<Lead>();
    List<User> UserList = new List<User>();       
    set<Id> inboundqueue = new Set<Id>();
    public String ListViewURLID {get;set;}
    public List<Lead> filteredLead2{get;set;}
    private integer counter=0;  //keeps track of the offset
    private integer list_size=25; //sets the page size or number of rows
    public integer total_size; //used to show user the total size of the list
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
      return null;
   }
 
   public PageReference Previous() { //user clicked previous button
      counter -= list_size;
    if(searchflag == true)                  
       colmnsorting();
      return null;
   }
 
   public PageReference Next() { //user clicked next button
      counter += list_size;
      if(searchflag == true)                  
       colmnsorting();
      return null;
   }
 
   public PageReference End() { //user clicked end
      counter = total_size - math.mod(total_size, list_size);
      if(searchflag == true)                  
       colmnsorting();
      return null;
   }
 
   public Boolean getDisablePrevious() { 
      //this will disable the previous and beginning buttons
      system.debug('*******Previous'+counter);
      if (counter>0) return false; else return true;
   }
 
   public Boolean getDisableNext() { //this will disable the next button
      system.debug('*******Next'+(counter + list_size)+'*TS*'+total_size);
      if (counter + list_size < total_size) return false; else return true;
   }
   
   public Boolean getDisableEnd() { //this will disable the end button
      system.debug('*******Next'+(counter + list_size)+'*TS*'+total_size);
      if (total_size >= 2000) return true;
      if (counter + list_size < total_size) return false; else return true;
   }
/*********/ 

    public myLoansListViewController(){ 

        hide=True;
        searchflag = false;

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
            if(w.getLabel()=='My Loans'){
                ListViewURLID = w.getValue().left(15);
            }
        }
        System.debug('*********My Lead ID'+ListViewURLID);
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
   searchflag = true;
   counter = 0;
   total_size = 0;

      
       filteredLead2 = new List<Lead>(); 
       string sname=Tname+'%';
       string querystring;
       querystring='select id,name,owner.name,status,Loan_Purpose__c,email,empower_lead_id__c,createddate,Rate_Lock_Expiration_Date__c from Lead where isconverted=false and empower_lead_id__c like \'E%\' ';
       
             
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
       
       if(SelectedU!='None'){
           if(Tname!=null || selectedstatus!='None' || selectedsource!='None' || selectedloanpurpose!='None' || TPropertyS!=null)
               querystring +=' and ';
           querystring +='ownerid=:SelectedU';
       }    
       List<lead> ts = Database.query(querystring);
       total_size = ts.size();
       querystring +=' limit :list_size offset :counter';
       filteredLead2=Database.query(querystring);
      if(filteredLead2 !=null && filteredLead2.size()>0){
            searchflag = true;
            
           }
      
       
       
   }
   
   
   
   public void colmnsorting(){
   sortFullExp = sortExpression  + ' ' + sortDirection;                  
   searchflag = true; 
   errormessage = false;
   errorname = false;
  
       filteredLead2 = new List<Lead>(); 
       string sname=Tname+'%';
       string querystring;
       querystring='select id,name,owner.name,status,Loan_Purpose__c,email,empower_lead_id__c,createddate,Rate_Lock_Expiration_Date__c from Lead where isconverted=false and empower_lead_id__c like \'E%\' ';
       
             
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
       
       if(SelectedU!='None'){
           if(Tname!=null || selectedstatus!='None' || selectedsource!='None' || selectedloanpurpose!='None' || TPropertyS!=null)
               querystring +=' and ';
           querystring +='ownerid=:SelectedU';
       } 
          
       querystring +=' Order by ' +sortFullExp+' Nulls last';
       querystring +=' limit :list_size offset :counter';
       filteredLead2=Database.query(querystring);
            
     }
      
    public void refresh(){
       
        searchflag = false;
        hide=true;
        selectedstatus='None';
        selectedloanpurpose='None';
        user temp = [select id,name from user where id =: UserInfo.getuserid() limit 1];
        selectedU=temp.name;
        selectedsource='None';
        Tname=null;
        TpropertyS=null;
    
    }
    
    
}