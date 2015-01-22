public class CO_CustomerPortalController {

   
    //For creating Customer portal Lead.
    Public Customer_Portal_Lead__c CPLead {set;get;}
    //for lead detail page
    Public Customer_Portal_Lead__c CPLead2 {set;get;}
    Id CpLeadid;
    Public Boolean Lead_check {get;set;}
    
    
    Public String paramSelectedBr;
    Public String paramSelectedDist;
    public string SelectedRegion {get;set;}
    public string SelectedBranch {get;set;}
    public string SelectedDistrict {get;set; }
    public List<selectOption> branchoption {get;set;}
    public list<SelectOption> districtoption{get;set;}
    public Decimal BranchCostCenter {get;set;}
    public String BranchNumber {get;set;}
    public string RB_EID {get;set;}
   
  
    Public String createdlead_firstName {get;set;}
    Public String createdlead_lastName {get;set;}
   

    
    public CO_CustomerPortalController(ApexPages.StandardController controller){
      
        paramSelectedBr= System.currentPagereference().getParameters().get('branch');
        paramSelectedDist= System.currentPagereference().getParameters().get('district');
       
        CPLead = new Customer_Portal_Lead__c(); 
      
        CPLeadid = ApexPages.currentPage().getParameters().get('id');  
        
        if(CPLeadid!=null) {
        CPLead2 = [Select ownerId,Comments__c,Loan_Interest__c,Loan_Term__c,Closing_date__c,Lead_Status__c,Create_Lead__c,Applicant_Type__c,Borrowers_Country__c,Borrowers_Address_1__c,Borrowers_Address_2__c,Borrowers_City__c,Borrowers_County__c,Borrowers_Home_Phone__c,Borrower_State_2__c,Borrowers_Zip_Postal_Code__c,Daytime_Phone__c,DU_Response__c,Email__c,First_Name__c,Last_Name__c,Loan_Status__c,Name__c,Occupancy_Code__c,Property_State__c,Suffix__c,Submitted__c,Loan_Number__c,Mortgage_Consultant_Name__c,Property_Address__c,RB_Branch__c,RB_District__c,RB_Region__c,RB_Cost_Center__c,RelationShip_Banker_EID__c,Closing_Fees__c,Branch_ID__c,Application_number__c,Empower_Lead_ID__c,Transfer_to_HLR__c  from Customer_Portal_Lead__c where id=:CPLEadid limit 500]; 
        // Added for B-142315 (12B).
        createdlead_firstName = CPLead2.First_Name__c;
        createdlead_lastName = CPLead2.Last_Name__c;    
        }
        
    }
    
 
    public PageReference submit() {
    
        system.debug('*******CPlead'+CPLead);
        Lead_check = false;
        boolean InsertL;
        string zipcode = CPLead.Borrowers_Zip_Postal_Code__c; 
        try{

            if(CPLead.First_Name__c == null || CPLead.Last_Name__c == null ||CPLead.Borrowers_Home_Phone__c == null  || CPLead.Daytime_Phone__c == null ||
            CPLead.Marrital_Status__c == null || CPLead.Applicant_Type__c == null || CPLead.Borrowers_Address_1__c == null || CPLead.Borrower_State_2__c == null ||
            CPLead.Borrowers_Zip_Postal_Code__c == null || CPLead.Preferred_Contact_Method__c == null || CPLead.Time_Zone__c == null || CPLead.Best_Contact_Time__c == null
            || CPLead.How_did_you_hear_about_us__c == null || CPLead.Loan_Purpose__c == null || CPLead.Total_amount_finance_needed__c == null || CPLead.Property_State__c == null
            || CPLead.Property_Use__c == null || CPLead.Property_Type__c == null) {
            
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Enter the details in Mandatory fields(*)'));
                InsertL = false;
            }
            
            if (CPLead.Property_State__c != 'TX' && CPLead.Property_State__c != 'MD' && CPLead.Property_State__c != 'LA'
            && CPLead.Property_State__c != 'DE' && CPLead.Property_State__c != 'NY' && CPLead.Property_State__c != 'NJ'
            && CPLead.Property_State__c != 'CT' && CPLead.Property_State__c != 'VA' && CPLead.Property_State__c != 'DC') {
            system.debug('%%%%%%%%%%%CPLead.Property_State__c%%%%%%%%'+CPLead.Property_State__c);
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Please enter a correct state'));
                InsertL = false;
                //system.debug('########################test 1####################'+InsertL );
            }
            else if(zipcode.Length() != 5) {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Please enter a correct Zip code'));
                InsertL = false;
            }
            else{
                CPLead.Create_Lead__c = true;
                
                 CPLead.RB_Branch__c = paramSelectedBr;
                 CPLead.RB_District__c = paramSelectedDist;
                 CPLead.RB_Region__c = SelectedRegion;
                 CPLead.RelationShip_Banker_EID__c = RB_EID;
                 Branch__c bcc = [Select Cost_Center__c,Branch_Number__c From Branch__c where Name = :paramSelectedBr];
                 BranchCostCenter = bcc.Cost_Center__c; 
                 BranchNumber = bcc.Branch_Number__c;
                 CPLead.RB_Cost_Center__c = String.ValueOf(BranchCostCenter) ;
                 //CPLead.Branch_ID__c = BranchNumber; 
 

               //system.debug('**paramSelectedBr ***'+paramSelectedBr);
               //system.debug('**paramSelectedDist ***'+paramSelectedDist); 
               //system.debug('**paramSelectedCostCenter***'+paramSelectedCostCenter);
               //system.debug('*****SelectedRegion*****'+SelectedRegion);
               //system.debug('*****RB_EID*****'+RB_EID);
               
               
                InsertL = true;
            }
                system.debug('########################test 2#####################'+InsertL );     
            if(InsertL == true){
              //system.debug('########################insrerting#####################');
              //   CPLead.District__c = string.valueOf(districtoption[0].getvalue());
                insert CPLead ;
                InsertL = false;   
                PageReference pageRef= new PageReference('/apex/CO_successfullysubmitted_VF?id='+CPLead.id);
                 pageRef.getParameters().put('branch',paramSelectedBr);
                 pageRef.getParameters().put('district',paramSelectedDist);
                pageRef.setredirect(true);        
                return pageRef;       
            }
            return null; 
    }catch (exception e) {
         CPLead.Create_Lead__c = false;
         ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Please check the values entered'));
         System.debug('*******Following error occured'+e);
         return null;
    }
    }
    
    public void onload() {
    
    CPLead.Borrowers_Home_Phone__c = '()-';
    CPLead.Daytime_phone__c = '()-';
    CPLead.Sales_price__c = 0.00;
    CPLead.Approximate_value_of_your_property__c = 0.00;
    
    }
    
    
    public PageReference Close(){
        
               system.debug('**paramSelectedBr ***'+paramSelectedBr);
               system.debug('**paramSelectedDist ***'+paramSelectedDist); 
              // system.debug('**paramSelectedCostCenter***'+paramSelectedCostCenter);
        PageReference pageRef= new PageReference('/apex/RB_Portal_List_View');          
        pageRef.getParameters().put('branch',paramSelectedBr);
        pageRef.getParameters().put('district',paramSelectedDist);
      //  pageRef.getParameters().put('costCenter',paramSelectedCostCenter);
        pageRef.setredirect(true);        
        return pageRef;
    }  
    
    public PageReference Previous(){
        
        PageReference pageRef= new PageReference('/apex/CO_CustomerAssessment_VF');
        pageRef.getParameters().put('branch',paramSelectedBr);
        pageRef.getParameters().put('district',paramSelectedDist);
      //  pageRef.getParameters().put('costCenter',paramSelectedCostCenter);
        pageRef.setredirect(true);        
        return pageRef;
    }
  
   }