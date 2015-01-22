public class Portal_list_view_controller {
 Public String Borrower_Name {get;set;}
 Public List<Customer_Portal_Lead__c> SearchPortalLeadsList{get;set;}
    public boolean hide{get;set;}
    Public String Borrower_LoanNo {get;set;}
    Public String Borrower_Email {get;set;}
    Public String Borrower_propertyAdd {get;set;}
    Public String Borrower_Phone {get;set;}
    public boolean text_1{get;set;}
    public boolean text_2{get;set;}
    public boolean buttonnextequity{get;set;}
    public boolean errormessage{get;set;}
    private User user;
    public User portaluser; 
    public boolean showbrnchreg{get;set;}
   // public Contact[] portalcontact{get;set;}
    public string District {get;set;}
    public string region {get;set;}
    public string SelectedRegion {get;set;}
    public string SelectedBranch {get;set;}
    public string SelectedDistrict {get;set; }
    public List<selectOption> branchoption {get;set;}
    public list<SelectOption> districtoption{get;set;}
    public Decimal BranchCostCenter {get;set;}
    public String BranchNumber {get;set;}
    public string RB_EID {get;set;}
    Public String paramSelectedBr;
    Public String paramSelectedDist;
    Public boolean searchflag{get;set;}
    Public boolean listflag{get;set;}
    Id CpLeadid;
    private String sortDirection = 'DESC';
    public String pagesize {get;set;}
    public Integer noOfRecords{get;set;}
    private String sortExp = 'Application_number__c';
    public string sortFullExp;
    public Integer size{get;set;}
    public Static Integer temp=1;
    List<Customer_Portal_lead__c> RBList = new List<Customer_Portal_lead__c>();
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
         public Portal_list_view_controller(ApexPages.StandardController controller){
         hide=True;
       //  system.debug('hide12345'+hide);
         searchflag = false;
         listflag = true;
         system.debug('Listflag constructor'+listflag);
         system.debug('searchflag constructor'+listflag);
      //  appnumber = false;
        paramSelectedBr= System.currentPagereference().getParameters().get('branch');
        paramSelectedDist= System.currentPagereference().getParameters().get('district');
        
        system.debug('**parambranchInConstructor***'+paramSelectedBr);
        system.debug('**paramdistrictInConstructor***'+paramSelectedDist);

        Apexpages.currentPage().getHeaders().put('X-UA-Compatible', 'IE=EmulateIE8');

        text_1 = false;
        text_2 = false;
        buttonnextequity = false;
        errormessage = false;
        //Lead details page parameters
        CPLeadid = ApexPages.currentPage().getParameters().get('id');  
        

       /*******Piyush*****/
         
        
       paramSelectedBr= System.currentPagereference().getParameters().get('branch');
        paramSelectedDist= System.currentPagereference().getParameters().get('district');
        //paramSelectedCostCenter= System.currentPagereference().getParameters().get('costCenter'); 
        
        portaluser = [Select id,contactId from user where id =:UserInfo.getUserId()];
        if (portaluser.contactId != null) {
            showbrnchreg = true;
            Contact TCon = [Select id,Branch_Region__c,Branch__c,Branch_Name__c,Branch_District__c,RelationShip_Banker_EID__c from contact where Id =:portaluser.contactId];
            RB_EID = TCon.RelationShip_Banker_EID__c;
            If(tcon.Branch_Region__c != null) {
              SelectedRegion = TCon.Branch_Region__c;
             
              
              if(TCon.Branch_District__c != NULL){
                districtoption= new List<selectOption>();
                District__c dist = [Select id,Name from District__c where Name =:TCon.Branch_District__c];
                
               // checking if user had selected district earlier. 
               if(paramSelectedDist == NULL)
                SelectedDistrict = dist.Name;
               else
                SelectedDistrict = paramSelectedDist;
                
                districtoption.add(new SelectOption(SelectedDistrict,SelectedDistrict));                
                 districtoption.add(new SelectOption('-- Choose A District --','-- Choose A District --'));
                for (District__c cat : [select Id, Name from District__c Where Region__r.Name = :SelectedRegion AND Name != :SelectedDistrict Order By Name])
                 districtoption.add(new SelectOption(cat.Name,cat.Name)); 
              }
               
              if(TCon.Branch_Name__c != NULL){
                   branchoption= new List<selectOption>();
                   if(paramSelectedBr == NULL)
                    SelectedBranch = TCon.Branch_Name__c;  
                   else
                    SelectedBranch = paramSelectedBr;              
                   Branch__c bcc = [Select Cost_Center__c From Branch__c where Name = :SelectedBranch];
                   BranchCostCenter = bcc.Cost_Center__c; 
                   branchoption.add(new SelectOption(SelectedBranch,SelectedBranch));                                    
                   branchoption.add(new SelectOption('-- Choose A Branch --','-- Choose A Branch --'));
                   for (Branch__c cat : [select Id, Name from Branch__c Where District__r.Name = :SelectedDistrict  And Name != : SelectedBranch Order By Name])
                      branchoption.add(new SelectOption(cat.Name,cat.Name));
              }                                        
             }
             
             system.debug('*****regionoptionInConstructor *****'+SelectedRegion);
             system.debug('*****districtoptionInConstructor *****'+SelectedDistrict);
             system.debug('*****branchoptionInConstructor *****'+selectedBranch);
             system.debug('*****BranchCostCenterInConstructor *****'+BranchCostCenter);
             system.debug('*****RB_EIDInConstructor*****'+RB_EID);  
             
           }
       
       else {
        showbrnchreg =false;
       } 
       
       /******* Piyush*******/
            
    }
        Public PageReference CustomerAssessment(){
        
        system.debug('**SelectedBrInPageRef ***'+SelectedBranch);
        system.debug('**SelectedDistInPageRef ***'+SelectedDistrict);
        system.debug('**BranchCostCenterInPageRef***'+BranchCostCenter);
        if(SelectedBranch == null || SelectedBranch == '' || SelectedDistrict == null || SelectedDistrict == ''  || SelectedBranch == '-- Choose A Branch --') {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'A District and  Branch must be selected on the Relationship Banker Pipeline screen in order to continue'));
            return null;
        }
        else { 
            PageReference pageRef= new PageReference('/apex/CO_CustomerAssessment_VF');
            pageRef.getParameters().put('branch',SelectedBranch);
            pageRef.getParameters().put('district',SelectedDistrict);
            pageRef.getParameters().put('costCenter',String.ValueOf(BranchCostCenter));
            pageRef.setredirect(true);        
            return pageRef;
        }       
    }
    
        public PageReference getBranches() {
    
        if (SelectedDistrict != NULL && SelectedDistrict != '' ) {
            system.debug('*****SelectedDistrict *****'+SelectedDistrict);
            branchoption = new List<selectOption>();
            branchoption.add(new SelectOption('','-- Choose A Branch --'));
            for (Branch__c cat : [select Id, Name from Branch__c Where District__r.Name = :SelectedDistrict Order By Name])
                branchoption.add(new SelectOption(cat.Name,cat.Name));
        }
        if (SelectedDistrict == '-- Choose A District --'  ) {
             branchoption = new List<selectOption>();
             branchoption.add(new SelectOption('','-- Choose A Branch --'));
        }
        return null;
    }
    
    public PageReference saveBranches() {
        if(SelectedBranch != Null && SelectedBranch != ''){
            system.debug('*****SelectedBranch*****'+SelectedBranch);
            system.debug('*****SelectedDistrict *****'+SelectedDistrict );
            Branch__c bcc = [Select Cost_Center__c From Branch__c where Name = :SelectedBranch];
            BranchCostCenter = bcc.Cost_Center__c;
        }
        else
            system.debug('****Branch is still null****');
        
        return null;
    }
    
        Public void Search(){ 
        //searchflag = true;          
        system.debug('Listflag search'+listflag);
         system.debug('searchflag search'+listflag);
        SearchPortalLeadsList = new List<Customer_Portal_Lead__c>();                             
        List<Customer_Portal_Lead__c> PortalLeads_SearchList = new List<Customer_Portal_Lead__c>();
        /* Changes for B 327047 - Richard Joseph -Starts here */
        //String QueryString = 'select Lead_Loan__c,Name__c,Phone_number__c,Borrower_Name__c, Total_amount_finance_needed__c,Loan_Status__c,Borrowers_Home_Phone__c,Email__c,Property_State__c,id,CreatedDate,Submitted__c,Mortgage_Consultant_Name__c,Property_Address__c,RB_Branch__c,RB_District__c,RB_Region__c,RB_Cost_Center__c,RelationShip_Banker_EID__c,Closing_Fees__c, Branch_ID__c,Application_number__c,Empower_Lead_ID__c,Transfer_to_HLR__c,Lead_Status__c,Loan_Term__c,Loan_Interest__c,Closing_date__c,ApplicationNumber__c,LeadLoan__c,Current_Status__c,Term__c,Interest_rate__c,ClosingFees__c,Mortgage_Consultant__c,Created_Date__c,Submitted_formula__c from Customer_Portal_Lead__c';
        String QueryString = 'select Lead_Loan__c,Name__c,Phone_number__c,Borrower_Name__c, Total_amount_finance_needed__c,Loan_Status__c,Borrowers_Home_Phone__c,Email__c,Property_State__c,id,CreatedDate,Submitted__c,Mortgage_Consultant_Name__c,Property_Address__c,RB_Branch__c,RB_District__c,RB_Region__c,RB_Cost_Center__c,RelationShip_Banker_EID__c,Closing_Fees__c, Branch_ID__c,Application_number__c,Empower_Lead_ID__c,Transfer_to_HLR__c,Lead_Status__c,Loan_Term__c,Loan_Interest__c,Closing_date__c,ApplicationNumber__c,LeadLoan__c,Current_Status__c,Term__c,Interest_rate__c,ClosingFees__c,Mortgage_Consultant__c,Created_Date__c,Submitted_formula__c,Lead_Number__c from Customer_Portal_Lead__c';    
        /* Changes for B 327047 - Richard Joseph -Starts here */
        system.debug('*******Query1*****'+QueryString);
        system.debug('*******Borrower_LoanNo*****'+Borrower_LoanNo);
        system.debug('*******Borrower_Name*****'+Borrower_Name);
        
        String TBorrName = '%'+Borrower_Name+'%'; 
        String TBorrproperty = '%'+Borrower_PropertyAdd+'%';
        String TBorrEmail = '%'+Borrower_Email+'%';
        String TBorrLoanNo = '%'+Borrower_LoanNo+'%';
        String TBorrPhone = '%'+Borrower_Phone+'%';
        
        
        if ((Borrower_Name == '' || Borrower_Name == null) && (Borrower_PropertyAdd == '' || Borrower_PropertyAdd == null) && (Borrower_Email == '' || Borrower_Email == null) && (Borrower_LoanNo == '' || Borrower_LoanNo == null) && (Borrower_Phone == '' || Borrower_Phone == null)) {
        system.debug('%%%%%%%%%%%%%%%%%%%%% Entered If');
            errormessage = true;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please enter a search criteria'));
        }
        else {
        searchflag = true;
        errormessage = false;
            system.debug('%%%%%%%%%%%%%%%%%%%%% Entered Else');
        if(Borrower_LoanNo!= null || Borrower_Name!= null || Borrower_Email!= null || Borrower_PropertyAdd != null || TBorrPhone != null){
            QueryString+=' where ';
        }
        system.debug('*******Query2*****'+QueryString);
         system.debug('*******TBorrLoanNo*****'+TBorrLoanNo);
        if(Borrower_LoanNo != null && Borrower_LoanNo != ''){
            /* Changes for B 327047 - Richard Joseph -Starts here */
            QueryString +='(Lead_Number__c like: TBorrLoanNo or LeadLoan__c like: TBorrLoanNo)';
            
            //QueryString +='(Lead_Loan__c like: TBorrLoanNo or Application_number__c like: TBorrLoanNo or Empower_Lead_ID__c like: TBorrLoanNo)';
            /* Changes for B 327047 - Richard Joseph -Ends here*/
        }
        system.debug('*******Query3*****'+QueryString);
        
        if(Borrower_Name != null && Borrower_Name != ''){
            if(Borrower_LoanNo != null && Borrower_LoanNo != '')
                QueryString +=' and ';
            QueryString +=' Borrower_Name__c  like: TBorrName';  
        }
        system.debug('*******Query4*****'+QueryString);
       
        if(Borrower_Email != null && Borrower_Email != ''){
            if((Borrower_LoanNo != null && Borrower_LoanNo != '')|| (Borrower_Name != null && Borrower_Name != ''))
               QueryString +=' and ';
            QueryString +=' Email__c like: TBorrEmail';    
        }
        system.debug('*******Query5*****'+QueryString);
        
        if(Borrower_PropertyAdd != null && Borrower_PropertyAdd != '') {
            if((Borrower_LoanNo != null && Borrower_LoanNo != '') || (Borrower_Name != null && Borrower_Name != '') || (Borrower_Email != null && Borrower_Email != ''))
                QueryString +=' and ';
            QueryString +=' Property_Address__c like :TBorrproperty';
        }
        system.debug('*******Query6*****'+QueryString);
        if(TBorrPhone != null && TBorrPhone != ''){
            if((Borrower_LoanNo != '' && Borrower_LoanNo != null) || (Borrower_Name != null && Borrower_Name != '') || (Borrower_Email != null && Borrower_Email != '') || (Borrower_PropertyAdd != null && Borrower_PropertyAdd != ''))
                QueryString +=' and ';
            QueryString +=' (Borrowers_Home_Phone__c like :TBorrPhone OR Phone_number__c like :TBorrPhone) ';     
        }
        system.debug('*******Query*****'+QueryString); 
     //   try {
    
     try{
         if(QueryString!=null)
             {
                SearchPortalLeadsList = Database.query(QueryString);   
                system.debug('*******Query*****'+SearchPortalLeadsList);
             }
         }
       catch (exception e) {
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please Re-check with different values'));
        }  
 
       
      listflag = false;
      if(SearchPortalLeadsList.size()>=0)
      {      
          hide=false;          
          system.debug('hide12345'+hide);
      }  
      /*else
      {
       hide= false;       
      }*/
      
      }  
      
    }
        Public pagereference refresh(){
        Borrower_Name = '';
        Borrower_LoanNo = '';
        Borrower_Email = '';
        Borrower_propertyAdd = '';
        Borrower_Phone = ''; 
       // VFPortalLeadsList = PortalLeadsList; 
       pagereference pageref = new pagereference('/apex/RB_Portal_List_View') ;
       pageref.setredirect(true);
       return pageref;         
    }
    
    public void colmnsorting(){
        sortFullExp = sortExpression  + ' ' + sortDirection;                  
        searchflag = true;          
        system.debug('Listflag search'+listflag);
        system.debug('searchflag search'+listflag);
        SearchPortalLeadsList = new List<Customer_Portal_Lead__c>();                             
        List<Customer_Portal_Lead__c> PortalLeads_SearchList = new List<Customer_Portal_Lead__c>();
        //String QueryString = 'select Lead_Loan__c,Name__c,Phone_number__c,Borrower_Name__c, Total_amount_finance_needed__c,Loan_Status__c,Borrowers_Home_Phone__c,Email__c,Property_State__c,id,CreatedDate,Submitted__c,Mortgage_Consultant_Name__c,Property_Address__c,RB_Branch__c,RB_District__c,RB_Region__c,RB_Cost_Center__c,RelationShip_Banker_EID__c,Closing_Fees__c, Branch_ID__c,Application_number__c,Empower_Lead_ID__c,Transfer_to_HLR__c,Lead_Status__c,Loan_Term__c,Loan_Interest__c,Closing_date__c,ApplicationNumber__c,LeadLoan__c,Current_Status__c,Term__c,Interest_rate__c,ClosingFees__c,Mortgage_Consultant__c,Created_Date__c,Submitted_formula__c from Customer_Portal_Lead__c';    
       String QueryString = 'select Lead_Loan__c,Name__c,Phone_number__c,Borrower_Name__c, Total_amount_finance_needed__c,Loan_Status__c,Borrowers_Home_Phone__c,Email__c,Property_State__c,id,CreatedDate,Submitted__c,Mortgage_Consultant_Name__c,Property_Address__c,RB_Branch__c,RB_District__c,RB_Region__c,RB_Cost_Center__c,RelationShip_Banker_EID__c,Closing_Fees__c, Branch_ID__c,Application_number__c,Empower_Lead_ID__c,Transfer_to_HLR__c,Lead_Status__c,Loan_Term__c,Loan_Interest__c,Closing_date__c,ApplicationNumber__c,LeadLoan__c,Current_Status__c,Term__c,Interest_rate__c,ClosingFees__c,Mortgage_Consultant__c,Created_Date__c,Submitted_formula__c,Lead_Number__c from Customer_Portal_Lead__c';
        system.debug('*******Query1*****'+QueryString);
        system.debug('*******Borrower_LoanNo*****'+Borrower_LoanNo);
        system.debug('*******Borrower_Name*****'+Borrower_Name);
        
        String TBorrName = '%'+Borrower_Name+'%'; 
        String TBorrproperty = '%'+Borrower_PropertyAdd+'%';
        String TBorrEmail = '%'+Borrower_Email+'%';
        String TBorrLoanNo = '%'+Borrower_LoanNo+'%';
        String TBorrPhone = '%'+Borrower_Phone+'%';

        if(Borrower_LoanNo!= null || Borrower_Name!= null || Borrower_Email!= null || Borrower_PropertyAdd != null || TBorrPhone != null){
            QueryString+=' where ';
        }
        system.debug('*******Query2*****'+QueryString);
         system.debug('*******TBorrLoanNo*****'+TBorrLoanNo);
        if(Borrower_LoanNo != null && Borrower_LoanNo != ''){
        	
        	 /* Changes for B 327047 - Richard Joseph - here */
            
        	QueryString +='(Lead_Number__c like: TBorrLoanNo or LeadLoan__c like: TBorrLoanNo )';
            //QueryString +='(Lead_Loan__c like: TBorrLoanNo or Application_number__c like: TBorrLoanNo or Empower_Lead_ID__c like: TBorrLoanNo)';
        }
        system.debug('*******Query3*****'+QueryString);
        
        if(Borrower_Name != null && Borrower_Name != ''){
            if(Borrower_LoanNo != null && Borrower_LoanNo != '')
                QueryString +=' and ';
            QueryString +=' Borrower_Name__c  like: TBorrName';  
        }
        system.debug('*******Query4*****'+QueryString);
       
        if(Borrower_Email != null && Borrower_Email != ''){
            if((Borrower_LoanNo != null && Borrower_LoanNo != '')|| (Borrower_Name != null && Borrower_Name != ''))
               QueryString +=' and ';
            QueryString +=' Email__c like: TBorrEmail';    
        }
        system.debug('*******Query5*****'+QueryString);
        
        if(Borrower_PropertyAdd != null && Borrower_PropertyAdd != '') {
            if((Borrower_LoanNo != null && Borrower_LoanNo != '') || (Borrower_Name != null && Borrower_Name != '') || (Borrower_Email != null && Borrower_Email != ''))
                QueryString +=' and ';
            QueryString +=' Property_Address__c like :TBorrproperty';
        }
        system.debug('*******Query6*****'+QueryString);
        if(TBorrPhone != null && TBorrPhone != ''){
            if((Borrower_LoanNo != '' && Borrower_LoanNo != null) || (Borrower_Name != null && Borrower_Name != '') || (Borrower_Email != null && Borrower_Email != '') || (Borrower_PropertyAdd != null && Borrower_PropertyAdd != ''))
                QueryString +=' and ';
             QueryString +=' (Borrowers_Home_Phone__c like :TBorrPhone OR Phone_number__c like :TBorrPhone) Order by ' +sortFullExp+' Nulls last';    
        }
        system.debug('*******Query*****'+QueryString); 
        try {
        SearchPortalLeadsList = Database.query(QueryString);   
        system.debug('*******Query*****'+SearchPortalLeadsList);
        }
        catch (exception e) {
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please Re-check with different values'));
        }
      listflag = false;
      if(SearchPortalLeadsList.size()>0)
      {      
          hide=false;
          
          system.debug('hide12345'+hide);
      }        
                             
    }
}