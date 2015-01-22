global class CreateOpusid_Opp{
      
Webservice static string show(ID OppId) {       
 
 String xml = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:gw-headers-100" xmlns:urn1="urn:gw-loanserviceenvelope-100" xmlns:urn2="urn:gw-ingdirect-services-lendingservices-contracts-common-100" xmlns:urn3="urn:gw-loanapplication-common-100"><soapenv:Header>' +  
 '<urn:MajorVersion xmlns="urn:gw-headers-100">1</urn:MajorVersion><urn:MinorVersion xmlns="urn:gw-headers-100">13.03.100</urn:MinorVersion>' +     
 '<urn:Requester_IpAddress>10.152.82.70</urn:Requester_IpAddress><urn:Requester_Application>SalesForce</urn:Requester_Application><urn:Requester_SystemId>TS-E-1</urn:Requester_SystemId><urn:ClientTimeout>60000</urn:ClientTimeout><urn:SendTime>'+system.now()+'</urn:SendTime><urn:ResponseExpected>true</urn:ResponseExpected><urn:Service>loan.CreateLead</urn:Service><urn:RequestGroup/><urn:OnBehalfOf_UserId/><urn:OnBehalfOf_UserDomain/><urn:OnBehalfOf_CIF/><urn:Requester_SourcePreference/><urn:DeviceInfo/>'+   
 '</soapenv:Header>' ;
 
//Changed by Sunil > To add Extension field from user object to OPUS - B-369907   
User u = [Select FirstName,LastName,Email,Fax,Phone,NMLS_ID__c,Alias,Extension  from user where id = :userinfo.getuserid()limit 1];
Opportunity opp=[select id,Annual_Homeowner_s_Association_Dues__c,Annual_Homeowner_s_Insurance__c,Annual_Real_Estate_Taxes__c,Applicant_Type__c,Channel__c,Channel_Sources__c,Channel_Values__c,Value_of_Home__c,Requested_Loan_Amount__c,Loan_Purpose__c,Property_Address_1__c,Property_Address_2__c,Property_Apt__c,Property_City__c, Property_Country__c,Property_County__c,Property_House__c,Property_State__c,Property_Type__c,Property_Zip_Postal_Code__c, Account.id,Related_Lead__c,Shopping_Stage__c,Empower_Lead_ID__c,Will_this_be_a_joint_application__c from opportunity where id = :OppId limit 1];
Id Leadid = opp.Related_Lead__c;
Id Accid  =opp.account.id;

Account acc=[select Best_Contact_Time__c,Phone,FirstName,LastName,Address_1__c,Address_2__c,Apt__c,City__c,Country__c,County__c,Current_Residence_Type__c,House__c,Preferred_Contact_Method__c,State__c,Time_Zone__c,Work_Phone__c,How_would_you_describe_your_credit__c,Zip_Postal_Code__c,PersonMobilePhone from account where id = :accid limit 1];

/* Updated for B-339962,B-332433, B-339984  - Sunil Nautiyal -Starts here */ 
//Lead L = [Select id,Borrower_Had_Foreclosure_In_Last_7_Years__c,Empower_Lead_ID__c,Requested_Loan_Amount__c,Property_State__c,Best_Contact_Time__c,Other_Monthly_Debt__c,Annual_Homeowner_s_Insurance__c,Property_City__c,Jnt_Applcnt_Had_Foreclosure_In_Lst_7yrs__c,Joint_Applicant_Had_Bankruptcy__c,Property_County__c,JntApplicnt_Had_Bankruptcy_HwMnyYrsAgo__c,Channel_Sources__c,Borrowers_State__c,Unsupported_Detached_Type__c,Original_Purchase_Price__c,Joint_Applicant_Self_Employed__c,Phone,Annual_Home_Owner_s_Association_Dues__c,Proprty_lsted_fr_sale_in_last_3months__c,Occupancy_Code__c,Channel_Values__c,Email,What_type_do_you_have_2nd_Mortgage__c,Is_your_home_under_major_renovation__c,Property_Zip_Postal_Code__c,Unsupported_Attached_Type__c,Property_Is_A_Planned_Unit_Development__c,How_Would_You_Describe_Your_credit__c,Unsupported_Condominium_Type__c,BorrowerHadBankruptcy_How_Many_Years_ago__c,Time_Zone__c,Loan_Purpose__c,Do_You_Have_A_Purchase_Agreement__c,Property_Type__c,Borrowers_County__c,Annual_Income__c,Borrowers_Mobile_Phone__c,FirstName,LastName,Borrower_Had_Bankruptcy__c,Value_of_Home__c,Borrowers_Home_Phone__c,Are_you_Self_Employed__c,Intened_use_of_Cash_Out_funds__c,Borrowers_City__c,Borrowers_Country__c,Current_Mortgage_Balance__c,Existing_Second_Mortgage__c,Mortgage_Property_Greater_Than_10_Acres__c,Will_this_be_a_joint_application__c,Joint_Applicant_Self_Employed_Since__c,Loan_Amount__c,Monthly_payment_on_your_1st_mortgage__c,Preferred_Contact_Method__c,Annual_Real_Estate_Taxes__c,Borrower_Self_Employed_Since__c,Borrowers_Zip_Postal_Code__c from Lead where id = :Leadid];

/*  Updated for B-416744 - Sunil - Start here */

//Lead L = [Select id,Borrower_Had_Foreclosure_In_Last_7_Years__c,Empower_Lead_ID__c,Requested_Loan_Amount__c,Property_State__c,Best_Contact_Time__c,Other_Monthly_Debt__c,Annual_Homeowner_s_Insurance__c,Property_City__c,Jnt_Applcnt_Had_Foreclosure_In_Lst_7yrs__c,Joint_Applicant_Had_Bankruptcy__c,Property_County__c,JntApplicnt_Had_Bankruptcy_HwMnyYrsAgo__c,Channel_Sources__c,Borrowers_State__c,Unsupported_Detached_Type__c,Original_Purchase_Price__c,Joint_Applicant_Self_Employed__c,Phone,Annual_Home_Owner_s_Association_Dues__c,Proprty_lsted_fr_sale_in_last_3months__c,Occupancy_Code__c,Channel_Values__c,Email,What_type_do_you_have_2nd_Mortgage__c,Is_your_home_under_major_renovation__c,Property_Zip_Postal_Code__c,Unsupported_Attached_Type__c,Property_Is_A_Planned_Unit_Development__c,How_Would_You_Describe_Your_credit__c,Unsupported_Condominium_Type__c,BorrowerHadBankruptcy_How_Many_Years_ago__c,Time_Zone__c,Loan_Purpose__c,Do_You_Have_A_Purchase_Agreement__c,Property_Type__c,Borrowers_County__c,Annual_Income__c,Borrowers_Mobile_Phone__c,FirstName,LastName,Borrower_Had_Bankruptcy__c,Value_of_Home__c,Borrowers_Home_Phone__c,Are_you_Self_Employed__c,Intened_use_of_Cash_Out_funds__c,Borrowers_City__c,Borrowers_Country__c,Current_Mortgage_Balance__c,Existing_Second_Mortgage__c,Mortgage_Property_Greater_Than_10_Acres__c,Will_this_be_a_joint_application__c,Joint_Applicant_Self_Employed_Since__c,Loan_Amount__c,Monthly_payment_on_your_1st_mortgage__c,Preferred_Contact_Method__c,Annual_Real_Estate_Taxes__c,Borrower_Self_Employed_Since__c,Borrowers_Zip_Postal_Code__c,Relationship_to_Borrower__c,Foreclosure_Years_Ago__c,Property_Complete_Date__c,Is_the_property_under_construction__c from Lead where id = :Leadid];

    Lead L = null;
        If (Leadid == null){
            L = new Lead();
        }else{//changed by Vimal for the story B-571191, added RB_NMLS_ID__c statement in the below query + B- 569453
            L = [Select id,RB_NMLS_ID__c,Refi_First_Receive_Cash_Back__c,Borrower_Had_Foreclosure_In_Last_7_Years__c,Empower_Lead_ID__c,Requested_Loan_Amount__c,Property_State__c,Best_Contact_Time__c,Other_Monthly_Debt__c,Annual_Homeowner_s_Insurance__c,Property_City__c,Jnt_Applcnt_Had_Foreclosure_In_Lst_7yrs__c,Joint_Applicant_Had_Bankruptcy__c,Property_County__c,JntApplicnt_Had_Bankruptcy_HwMnyYrsAgo__c,Channel_Sources__c,Borrowers_State__c,Unsupported_Detached_Type__c,Original_Purchase_Price__c,Joint_Applicant_Self_Employed__c,Phone,Annual_Home_Owner_s_Association_Dues__c,Proprty_lsted_fr_sale_in_last_3months__c,Occupancy_Code__c,Channel_Values__c, What_type_do_you_have_2nd_Mortgage__c,Is_your_home_under_major_renovation__c,Property_Zip_Postal_Code__c,Unsupported_Attached_Type__c,Property_Is_A_Planned_Unit_Development__c,How_Would_You_Describe_Your_credit__c,Unsupported_Condominium_Type__c,BorrowerHadBankruptcy_How_Many_Years_ago__c,Time_Zone__c,Loan_Purpose__c,Do_You_Have_A_Purchase_Agreement__c,Property_Type__c,Borrowers_County__c,Annual_Income__c,Borrowers_Mobile_Phone__c,FirstName,LastName,Borrower_Had_Bankruptcy__c,Value_of_Home__c, Are_you_Self_Employed__c,Intened_use_of_Cash_Out_funds__c,Borrowers_City__c,Borrowers_Country__c,Current_Mortgage_Balance__c,Existing_Second_Mortgage__c,Mortgage_Property_Greater_Than_10_Acres__c,Will_this_be_a_joint_application__c,Joint_Applicant_Self_Employed_Since__c,Loan_Amount__c,Monthly_payment_on_your_1st_mortgage__c,Preferred_Contact_Method__c,Annual_Real_Estate_Taxes__c,Borrower_Self_Employed_Since__c,Borrowers_Zip_Postal_Code__c,Relationship_to_Borrower__c,Foreclosure_Years_Ago__c,Property_Complete_Date__c,Is_the_property_under_construction__c, RB_First_Name__c, RB_Last_Name__c, RelationShip_Banker_Name__c, RB_Email__c, RelationShip_Banker_EID__c, RB_Branch__c,RB_Cost_Center__c, Borrowers_Address_1__c, Borrowers_Address_2__c,Initial_OPUS_ID__c, What_Is_The_Annual_Co_Op_Maintenance_Fee__c, Property_Address_1__c, Property_Address_2__c, Borrowers_Home_Phone__c, MobilePhone, Email, BorrowersHouse__c, Borrowers_Apt__c, Monthly_Rental_Income__c, Financed_Properties_Amount__c, Total_Monthly_Primary__c from Lead where id = :Leadid];
        }
        
/*  Updated for B-416744 - Sunil - End here */

/* Updated for B-339962,B-332433, B-339984  - Sunil Nautiyal -End here */


System.debug('############################'+'MCDetial'+u.firstname+u.lastname+u.email+u.fax+u.phone+u.nmls_id__c+u.alias);


       
    System.Debug('%%%%%%%%%%%%%%%%%%%%%%%%%'+L.id);
    
   /* Added for B-339962  - Sunil Nautiyal -Starts here */ 
    Map<string,String> RelationshipToBorrower = new Map<String,String>{'Blood Relative, Marriage, or In-Law'=>'2','Parent Selling to Child'=>'3','None of the above'=>'4'};
   /* Added for B-339962  - Sunil Nautiyal -End here */
    
   
   /* Updated for B-339939  - Sunil Nautiyal -Starts here */ 
    Map<string,String> Describecredit = new Map<String,String>{'740-800'=>'1','720-739'=>'2','700-719'=>'3','680-699'=>'4','660-679'=>'5','Less than 660'=>'6','580-659'=>'6','Less than 580'=>'7'};
   /* Updated for B-339939  - Sunil Nautiyal -End here */
   
   /*  Updated for B-569453 -  Start here */ 
    Map<string,string> NumberofFinancedPropertiesPurchase = new Map<String,String>{'0'=>'1','1'=>'2','2'=>'3','3'=>'4','4 or More'=>'5'};
   /*  Updated for B-569453 -  End here */ 
      
    Map<string,string> Propertytype = new Map<String,String>{'SFR Detached'=>'1','SFR Attached'=>'2','Low-Rise (1-4)'=>'3','Mid-Rise (5-8)'=>'3','High-Rise (9+)'=>'3','Townhome'=>'3','2 Unit'=>'10','3 Unit'=>'10','4 Unit'=>'10','PUD'=>'10','Co-op' =>'9'};
    Map<String,String> PropertyPurpose = new Map<String,String>{'Owner Occupied'=>'1','Second Home'=>'2','Investment Property'=>'3'};
    Map<String,String> SubordinateFinacing = new Map<String,String>{'Mortgage'=>'1','Home Equity'=>'2'};
    Map<String,String> PreferredContactMethod = new Map<String,String>{'Standard Mail'=>'0','Home Phone'=>'1','Work Phone'=>'1','Mobile Phone'=>'1','Phone'=>'1','E-Mail'=>'2'};
    Map<String,String> TimeZone = new Map<String,String>{'None'=>'0','EST'=>'1','CST'=>'2','MST'=>'3','PST'=>'4'};
    Map<String,String> LoanPurpose = new Map<String,String>{'Purchase'=>'17','Cash-out Refinance'=>'19','Streamline Refinance'=>'19','IRRRL'=>'19','Rate & Term Refinance'=>'19','HEL – 1st Lien'=>'35','HEL – 2nd Lien'=>'35','HELOC – 1st Lien'=>'35','HELOC – 2nd Lien'=>'35'};
    Map<String,String> TimetoContact = new Map<String,String>{'08:00 am'=>'800','09:00 am'=>'900','10:00 am'=>'1000','11:00 am'=>'1100','12:00 pm'=>'1200','01:00 pm'=>'1300','02:00 pm'=>'1400','03:00 pm'=>'1500','04:00 pm'=>'1600','05:00 pm'=>'1700','06:00 pm'=>'1800','07:00 pm'=>'1900','08:00 pm'=>'2000','09:00 pm'=>'2100'}; 
   
   
   /* Added for B-339962  - Sunil Nautiyal -Starts here */ 
    String Relationship_to_Borrower = (string.isblank(String.valueof(L.Relationship_to_Borrower__c))?'':RelationshipToBorrower.get(String.valueof(L.Relationship_to_Borrower__c)));
   /* Added for B-339962  - Sunil Nautiyal -End here */
   
   /* Added for B-332433  - Sunil Nautiyal -Starts here */ 
     String Foreclosure_Years_Ago = (string.isblank(String.valueOf(L.Foreclosure_Years_Ago__c))?'':String.valueOf(L.Foreclosure_Years_Ago__c));
   /* Added for B-332433  - Sunil Nautiyal -End here */
    
   /* Added for B-339984  - Sunil Nautiyal -Starts here */ 
    String Property_Complete_Date = (string.isblank(String.valueOf(L.Property_Complete_Date__c))?'':String.valueOf(L.Property_Complete_Date__c));
    String Property_UnderConstruction = (string.isblank(String.valueOf(L.Is_the_property_under_construction__c))?'':String.valueOf(L.Is_the_property_under_construction__c));
   /* Added for B-339984  - Sunil Nautiyal -End here */
   
   
   /* Added for B-362313 - Start here */
   
    String RB_Name =  (string.isblank(String.valueOf(L.RelationShip_Banker_Name__c))?'':String.valueOf(L.RelationShip_Banker_Name__c));
    String RB_fName =  (string.isblank(String.valueOf(L.RB_First_Name__c))?'':String.valueOf(L.RB_First_Name__c));
    String RB_lName =  (string.isblank(String.valueOf(L.RB_Last_Name__c))?'':String.valueOf(L.RB_Last_Name__c));
    String RB_Email =  (string.isblank(String.valueOf(L.RB_Email__c))?'':String.valueOf(L.RB_Email__c));
    String RB_EID =  (string.isblank(String.valueOf(L.RelationShip_Banker_EID__c))?'':String.valueOf(L.RelationShip_Banker_EID__c));
    String RB_Branch_Name  =  (string.isblank(String.valueOf(L.RB_Branch__c))?'':String.valueOf(L.RB_Branch__c));
    String RB_Cost_Center =  (string.isblank(String.valueOf(L.RB_Cost_Center__c))?'':String.valueOf(L.RB_Cost_Center__c));
    
    String Borrowers_StreetAddress1 = (string.isblank(String.valueOf(L.Borrowers_Address_1__c))?'':String.valueOf(L.Borrowers_Address_1__c));
    String Borrowers_StreetAddress2 = (string.isblank(String.valueOf(L.Borrowers_Address_2__c))?'':String.valueOf(L.Borrowers_Address_2__c));
    String Borrowers_City = (string.isblank(String.valueOf(L.Borrowers_City__c))?'':String.valueOf(L.Borrowers_City__c));
    String Borrowers_State = (string.isblank(String.valueOf(L.Borrowers_State__c))?'':String.valueOf(L.Borrowers_State__c));
    String Borrowers_Zip = (string.isblank(String.valueOf(L.Borrowers_Zip_Postal_Code__c))?'':String.valueOf(L.Borrowers_Zip_Postal_Code__c));
    
   /* Added for B-362313 - End here */
   
   
   /* Added for B-454894  - Sunil Nautiyal -Starts here */ 
    String Initial_OPUS_ID = (string.isblank(String.valueOf(L.Initial_OPUS_ID__c))?'':String.valueOf(L.Initial_OPUS_ID__c));
   /* Added for B-454894  - Sunil Nautiyal -End here */
   
    
    /* Added for B-487310  - Starts here */
        String PropertyAdd1 = (string.isblank(String.valueOf(L.Property_Address_1__c))?'':String.valueOf(L.Property_Address_1__c));
        String PropertyAdd2 = (string.isblank(String.valueOf(L.Property_Address_2__c))?'':String.valueOf(L.Property_Address_2__c));
        String BorrHPhone = (string.isblank(String.valueOf(L.Borrowers_Home_Phone__c))?'':String.valueOf(L.Borrowers_Home_Phone__c));
        String BorrMPhone = (string.isblank(String.valueOf(L.Borrowers_Mobile_Phone__c))?'':String.valueOf(L.Borrowers_Mobile_Phone__c));
        String BorrEmail = (string.isblank(String.valueOf(L.Email))?'':String.valueOf(L.Email));
        String BorrHouse = (string.isblank(String.valueOf(L.BorrowersHouse__c))?'':String.valueOf(L.BorrowersHouse__c));
        String BorrApt = (string.isblank(String.valueOf(L.Borrowers_Apt__c))?'':String.valueOf(L.Borrowers_Apt__c));
    /* Added for B-487310  - Ends here */
     
      
    String Describe_Credit = (string.isblank(String.valueof(acc.How_Would_You_Describe_Your_Credit__c))?'':Describecredit.get(String.valueof(L.How_Would_You_Describe_Your_Credit__c)));
    String Property_type =  (string.isblank(Propertytype.get(String.valueof(opp.Property_Type__c)) )?'':Propertytype.get(String.valueof(opp.Property_Type__c)));
    String Property_Purpose = PropertyPurpose.get(string.valueof(L.Occupancy_Code__c)); 
    String Subordinare_Financing = SubordinateFinacing.get(string.valueof(L.What_type_do_you_have_2nd_Mortgage__c));
    String Predferred_ContactMethod = PreferredContactMethod.get(string.valueof(acc.Preferred_Contact_Method__c));
    String Time_Zone = (string.isblank(TimeZone.get(string.valueof(acc.Time_Zone__c)))?'':TimeZone.get(string.valueof(acc.Time_Zone__c)));
    String Loan_Purpose =(string.isblank(LoanPurpose.get(string.valueof(opp.Loan_Purpose__c)))?'':LoanPurpose.get(string.valueof(opp.Loan_Purpose__c))) ;
    String Time_contact = (string.isblank(TimetoContact.get(string.valueof(acc.Best_Contact_Time__c)))?'':TimetoContact.get(string.valueof(acc.Best_Contact_Time__c)));
    
     
     String MCEmail = (string.isblank(String.valueOf(u.Email))?'':String.valueOf(u.Email));
     String MCFax = (string.isblank(String.valueOf(u.fax))?'':String.valueOf(u.fax));
     String MCFirstName = (string.isblank(String.valueOf(u.FirstName))?'':String.valueOf(u.FirstName));
     String MCLastName = (string.isblank(String.valueOf(u.LastName))?'':String.valueOf(u.LastName));
     String MCPhone = (string.isblank(String.valueOf(u.Phone))?'':String.valueOf(u.Phone));
     // Added by Sunil > To add Extension field from user object to OPUS - B-369907      
     String MCExtension = (string.isblank(String.valueOf(u.Extension))?'':String.valueOf(u.Extension));
     String NMLS_id = (string.isblank(String.valueOf(u.NMLS_ID__c))?'':String.valueOf(u.NMLS_ID__c));
     String Alias = (string.isblank(String.valueOf(u.Alias))?'':String.valueOf(u.Alias));
     String AnnualIncome = (string.isblank(String.valueOf(L.Annual_Income__c))?'':String.valueOf(L.Annual_Income__c));
     String MobilePhone = (string.isblank(String.valueOf(acc.PersonMobilePhone))?'':String.valueOf(acc.PersonMobilePhone));
     String Email = (string.isblank(String.valueOf(L.Email))?'':String.valueOf(L.Email));
     String Firstname = (string.isblank(String.valueOf(acc.FirstName))?'':String.valueOf(acc.FirstName));
     String Lastname = (string.isblank(String.valueOf(acc.LastName))?'':String.valueOf(acc.LastName));
     String BBankruptcy = (string.isblank(String.valueOf(L.Borrower_Had_Bankruptcy__c))?'':String.valueOf(L.Borrower_Had_Bankruptcy__c));
     String HomePhone = (string.isblank(String.valueOf(acc.phone))?'':String.valueOf(acc.phone));
     String SelfEmployed = (string.isblank(String.valueOf(L.Are_you_Self_Employed__c))?'':String.valueOf(L.Are_you_Self_Employed__c));
     String BBankruptcyyears = (string.isblank(String.valueOf(L.BorrowerHadBankruptcy_How_Many_Years_ago__c))?'':String.valueOf(L.BorrowerHadBankruptcy_How_Many_Years_ago__c));
     String Cashout =(string.isblank(String.valueOf(L.Intened_use_of_Cash_Out_funds__c))?'':String.valueOf(L.Intened_use_of_Cash_Out_funds__c));
     String PropertyCity = (string.isblank(String.valueOf(opp.Property_City__c))?'':String.valueOf(opp.Property_City__c));
     String PropertyCounty =(string.isblank(String.valueOf(opp.Property_County__c))?'':String.valueOf(opp.Property_County__c));
     String JointAppSelfEmployed =(string.isblank(String.valueOf(L.Joint_Applicant_Self_Employed__c))?'':String.valueOf(L.Joint_Applicant_Self_Employed__c));
     String JointAppForeclosure = (string.isblank(String.valueOf(L.Jnt_Applcnt_Had_Foreclosure_In_Lst_7yrs__c))?'':String.valueOf(L.Jnt_Applcnt_Had_Foreclosure_In_Lst_7yrs__c));
     String JointAppBruptcy = (string.isblank(String.valueof(L.Joint_Applicant_Had_Bankruptcy__c))?'':String.valueof(L.Joint_Applicant_Had_Bankruptcy__c));
     String JointAppBruptyears =(string.isblank(String.valueOf(L.JntApplicnt_Had_Bankruptcy_HwMnyYrsAgo__c))?'':String.valueOf(L.JntApplicnt_Had_Bankruptcy_HwMnyYrsAgo__c));
     String Greaterthan10acre = (string.isblank(String.valueOf(L.Mortgage_Property_Greater_Than_10_Acres__c))?'':String.valueOf(L.Mortgage_Property_Greater_Than_10_Acres__c));
     String AssociationDue = (string.isblank(String.valueOf(opp.Annual_Homeowner_s_Association_Dues__c))?'':String.valueOf(opp.Annual_Homeowner_s_Association_Dues__c));
     String AnnualInsurance = (string.isblank(String.valueOf(opp.Annual_Homeowner_s_Insurance__c))?'':String.valueOf(opp.Annual_Homeowner_s_Insurance__c));
     String MajorRenovation = (string.isblank(String.valueOf(L.Is_your_home_under_major_renovation__c))?'':String.valueOf(L.Is_your_home_under_major_renovation__c));
     String JointApp = (string.isblank(String.valueOf(opp.Will_this_be_a_joint_application__c))?'':String.valueOf(opp.Will_this_be_a_joint_application__c)); // Updated for B-520276
     String JointAppSelfEmp = (string.isblank(String.valueOf(L.Joint_Applicant_Self_Employed_Since__c))?'':String.valueOf(L.Joint_Applicant_Self_Employed_Since__c));
     String LoanAmout = (string.isblank(String.valueOf(opp.Requested_Loan_Amount__c))?'':String.valueOf(opp.Requested_Loan_Amount__c));
     String Last3months = (string.isblank(String.valueOf(L.Proprty_lsted_fr_sale_in_last_3months__c))?'':String.valueOf(L.Proprty_lsted_fr_sale_in_last_3months__c));
     String ExistingSecMortgage = (string.isblank(String.valueOf(L.Existing_Second_Mortgage__c))?'':String.valueOf(L.Existing_Second_Mortgage__c));
     String Mortgage_Bal = (string.isblank(String.valueof(L.Current_Mortgage_Balance__c))?'':String.valueof(L.Current_Mortgage_Balance__c));
     String MonthlyPay = (string.isblank(String.valueOf(L.Monthly_payment_on_your_1st_mortgage__c))?'':String.valueOf(L.Monthly_payment_on_your_1st_mortgage__c));
     String Monthly_Debt = (string.isblank(String.valueof(L.Other_Monthly_Debt__c))?'':String.valueof(L.Other_Monthly_Debt__c));
     String Contact_method = (string.isblank(String.valueOf(acc.Preferred_Contact_Method__c))?'':String.valueOf(acc.Preferred_Contact_Method__c));
     String Purchase_Agreement = (string.isblank(String.valueOf(L.Do_You_Have_A_Purchase_Agreement__c))?'':String.valueOf(L.Do_You_Have_A_Purchase_Agreement__c));
     String RealEstateTax = (string.isblank(String.valueOf(L.Annual_Real_Estate_Taxes__c))?'':String.valueOf(L.Annual_Real_Estate_Taxes__c));
     String PUD = (string.isblank(String.valueOf(L.Property_Is_A_Planned_Unit_Development__c))?'':String.valueOf(L.Property_Is_A_Planned_Unit_Development__c));
     String Channel_Source = (string.isblank(String.valueOf(opp.Channel_Sources__c))?'':String.valueOf(opp.Channel_Sources__c));
     String Channel_Value = (string.isblank(String.valueOf(opp.Channel_Values__c))?'':String.valueOf(opp.Channel_Values__c));
     String BSelfEmployed = (string.isblank(String.valueOf(L.Borrower_Self_Employed_Since__c))?'':String.valueOf(L.Borrower_Self_Employed_Since__c));
     String UnSupported_Detached = (string.isblank(String.valueOf(L.Unsupported_Detached_Type__c))?'':String.valueOf(L.Unsupported_Detached_Type__c));
     String UnSupported_Attached = (string.isblank(String.valueOf(L.Unsupported_Attached_Type__c))?'':String.valueOf(L.Unsupported_Attached_Type__c));
     String UnSupported_Con = (string.isblank(String.valueOf(L.Unsupported_Condominium_Type__c))?'':String.valueOf(L.Unsupported_Condominium_Type__c));
     String ZipCode = (string.isblank(String.valueOf(opp.Property_Zip_Postal_Code__c))?'':String.valueOf(opp.Property_Zip_Postal_Code__c));
     String PropertyValue = (string.isblank(String.valueOf(L.Original_Purchase_Price__c))?'':String.valueOf(L.Original_Purchase_Price__c));
     String StateCode = (string.isblank(String.valueOf(opp.Property_State__c))?'':String.valueOf(opp.Property_State__c));
     String SubordinateFinanceType =  (string.isblank(SubordinateFinacing.get(string.valueof(L.What_type_do_you_have_2nd_Mortgage__c)))?'':SubordinateFinacing.get(string.valueof(L.What_type_do_you_have_2nd_Mortgage__c)));
     String BorrowerForeclosure = (string.isblank(String.valueOf(L.Borrower_Had_Foreclosure_In_Last_7_Years__c))?'':String.valueOf(L.Borrower_Had_Foreclosure_In_Last_7_Years__c));
     String Property_Value = (string.isblank(String.valueOf(L.Value_of_Home__c))?'':String.valueOf(L.Value_of_Home__c));
   
    
    /*Added for the story B-571191 starts here*/
      String RB_NMLS_id = (string.isblank(String.valueOf(L.RB_NMLS_ID__c))?'':String.valueOf(L.RB_NMLS_ID__c));
    /*Added for the story B-571191 ends here*/
      
    /* Added for B-501991  - Starts here */ 
        if(Property_type.equals('9'))
            AssociationDue = (string.isblank(String.valueOf(L.What_Is_The_Annual_Co_Op_Maintenance_Fee__c))?'':String.valueOf(L.What_Is_The_Annual_Co_Op_Maintenance_Fee__c));
    /* Added for B-501991  - Ends here */  
    
     /*  Updated for B-569453 -  Start here */  
        
           String MonthlyRentalIncome = (string.isblank(String.valueOf(L.Monthly_Rental_Income__c))?'':String.valueOf(L.Monthly_Rental_Income__c));
           String TotalMonthlyPrimary = (string.isblank(String.valueOf(L.Total_Monthly_Primary__c))?'':String.valueOf(L.Total_Monthly_Primary__c));
           String FinancedPropertiesAmount = (string.isblank(NumberofFinancedPropertiesPurchase.get(String.valueof(L.Financed_Properties_Amount__c)))?'':NumberofFinancedPropertiesPurchase.get(String.valueof(L.Financed_Properties_Amount__c)));
       /*  Updated for B-569453 -  Start here */ 
       
    
       System.debug('#######################'+L.Loan_Purpose__c);         
       
       /*  Updated for B-416744 - Sunil - Start here */     
      
       //String LP = String.valueof(L.Loan_Purpose__c);
       String LP = (Leadid == null)?Loan_Purpose:String.valueof(L.Loan_Purpose__c);
       
       /*  Updated for B-416744 - Sunil - End here */       
       
        //Added by Vimal for the story B-603197 Starts here
        
      // String ReceivedCashBackOnRefiFirstMortgage = (string.isblank(String.valueOf(L.Refi_First_Receive_Cash_Back__c))?'':String.valueOf(L.Refi_First_Receive_Cash_Back__c));
      
        String ReceivedCashBackOnRefiFirstMortgage = String.valueOf(L.Refi_First_Receive_Cash_Back__c);    
       
       //Added by Vimal for the story B-603197 Ends here
       
       System.debug('#######################'+Loan_Purpose+'@@@@@@@@@@@@@@@@@@@@@@@'+Property_Purpose);
       
   if (String.isNotBlank(LP))
   {
    
   /* Updated for B-339962  - Sunil Nautiyal  */ 
    /* Updated for B-509721 - RB details move to RelationshipBanker section,stop populating the MortgageConsultant section, and populate the event info with the LO information, as that is the source of the request - Sunil Nautiyal  */ 
   /* Updated for B-487310 - Added AdditionalLeadDetails sections */
   
    String xml2 = '<soapenv:Body wsu:Id="id-1" xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd">'+
      '<urn1:LoanCreateLeadRequest><urn2:EventInfoRequest><urn2:ApplicationView>RetailConsultantCentralized</urn2:ApplicationView>'+
            '<urn2:EventName>CREATE_LEAD</urn2:EventName><urn2:MLONumber>'+NMLS_id+'</urn2:MLONumber>'+
           '<urn2:EmailAddress>'+MCEmail+'</urn2:EmailAddress><urn2:FaxNumber>'+MCFax+'</urn2:FaxNumber><urn2:FirstName>'+MCFirstName+'</urn2:FirstName><urn2:LastName>'+MCLastName+'</urn2:LastName><urn2:PhoneNumber>'+MCPhone+'</urn2:PhoneNumber><urn2:Extension>'+MCExtension+'</urn2:Extension>'+           
         '</urn2:EventInfoRequest>' +
         '<urn2:AdditionalLeadDetails><urn2:BorrowerApartmentNumber>'+BorrApt+'</urn2:BorrowerApartmentNumber><urn2:BorrowerHouseNumber>'+BorrHouse+'</urn2:BorrowerHouseNumber><urn2:EmailAddress>'+BorrEmail+'</urn2:EmailAddress><urn2:HomePhone>'+BorrHPhone+'</urn2:HomePhone>' +
         '<urn2:MobilePhone>'+BorrMPhone+'</urn2:MobilePhone><urn2:SubjectPropertyAddress1>'+PropertyAdd1+'</urn2:SubjectPropertyAddress1><urn2:SubjectPropertyAddress2>'+PropertyAdd2+'</urn2:SubjectPropertyAddress2></urn2:AdditionalLeadDetails>' +
        '<urn2:SolutionsFinderData><urn2:AnnualIncome>'+AnnualIncome+'</urn2:AnnualIncome><urn2:ApplicationDate xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">'+system.today()+'</urn2:ApplicationDate>'+
             '<urn2:BorrowerAlternatePhone xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">'+MobilePhone+'</urn2:BorrowerAlternatePhone><urn2:BorrowerEmail xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">'+Email+'</urn2:BorrowerEmail>'+
              '<urn2:BorrowerFirstName>'+Firstname+'</urn2:BorrowerFirstName><urn2:BorrowerLastName>'+Lastname+'</urn2:BorrowerLastName><urn2:BorrowerForeclosureOrLieuInd>'+BorrowerForeclosure+'</urn2:BorrowerForeclosureOrLieuInd><urn2:BorrowerPersonalBankruptcyInd>'+BBankruptcy+'</urn2:BorrowerPersonalBankruptcyInd>'+    
            '<urn2:BorrowerPhone xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">'+HomePhone+'</urn2:BorrowerPhone><urn2:BorrowerSelfEmployed>'+SelfEmployed+'</urn2:BorrowerSelfEmployed><urn2:BorrowerPersonalBankruptcyYearsAgo>'+BBankruptcyyears+'</urn2:BorrowerPersonalBankruptcyYearsAgo>'+   
         '<urn2:CashOut>'+Cashout+'</urn2:CashOut><urn2:City>'+PropertyCity+'</urn2:City><urn2:County>'+PropertyCounty+'</urn2:County><urn2:CountyFipsCode></urn2:CountyFipsCode>'+
         '<urn2:CoBorrowerSelfEmployed>'+JointAppSelfEmployed+'</urn2:CoBorrowerSelfEmployed><urn2:CoborrowerForeclosureOrLieuInd>'+JointAppForeclosure+'</urn2:CoborrowerForeclosureOrLieuInd><urn2:CoborrowerPersonalBankruptcyInd>'+JointAppBruptcy+'</urn2:CoborrowerPersonalBankruptcyInd><urn2:CoborrowerPersonalBankruptcyYearsAgo>'+JointAppBruptyears+'</urn2:CoborrowerPersonalBankruptcyYearsAgo><urn2:CreditType>'+Describe_Credit+'</urn2:CreditType><urn2:GreaterThan10Acres>'+ Greaterthan10acre+'</urn2:GreaterThan10Acres>'+   
         '<urn2:HomeEquityRequested></urn2:HomeEquityRequested><urn2:HomeOwnersAssociationDues>'+AssociationDue+'</urn2:HomeOwnersAssociationDues><urn2:HazardInsurance>'+AnnualInsurance+'</urn2:HazardInsurance><urn2:HomeUnderRenovation>'+MajorRenovation+'</urn2:HomeUnderRenovation>'+ 
            '<urn2:JointApplication>'+JointApp+'</urn2:JointApplication><urn2:JointSelfEmployedSince>'+JointAppSelfEmp+'</urn2:JointSelfEmployedSince><urn2:KeepingSubordinateLoan></urn2:KeepingSubordinateLoan><urn2:SubordinateFinancingType>'+SubordinateFinanceType+'</urn2:SubordinateFinancingType><urn2:Last6Months></urn2:Last6Months>'+   
              '<urn2:LoanNumber xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/><urn2:LoanPromotionInfo xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>'+ 
               '<urn2:LoanPurpose>'+Loan_Purpose+'</urn2:LoanPurpose><urn2:MortgageAmount>'+LoanAmout+'</urn2:MortgageAmount><urn2:ListedInTheLast3Months>'+LAst3months+'</urn2:ListedInTheLast3Months><urn2:ExistingSecondMortgage>'+ExistingSecMortgage+'</urn2:ExistingSecondMortgage><urn2:ExistingMortgageAmount>'+Mortgage_Bal+'</urn2:ExistingMortgageAmount><urn2:ExistingMortgagePayment>'+MonthlyPay+'</urn2:ExistingMortgagePayment><urn2:PropertyType>'+Property_type+'</urn2:PropertyType><urn2:OtherMonthlyDebt>'+Monthly_Debt+'</urn2:OtherMonthlyDebt><urn2:PropertyValue>'+PropertyValue+'</urn2:PropertyValue><urn2:PreferredContactMethod>'+Contact_method+'</urn2:PreferredContactMethod><urn2:PropertyPurpose>'+Property_Purpose+'</urn2:PropertyPurpose><urn2:PurchaseAgreementInd>'+Purchase_Agreement+'</urn2:PurchaseAgreementInd>'+ 
       '<urn2:RateSheetDate xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/><urn2:RealEstateTaxes>'+RealEstateTax+'</urn2:RealEstateTaxes>'+
       //Added by Vimal for the story B-603197 Starts here
       '<urn2:ReceivedCashBackOnRefiFirstMortgage>'+ReceivedCashBackOnRefiFirstMortgage+'</urn2:ReceivedCashBackOnRefiFirstMortgage>'+
       //Added by Vimal for the story B-603197 Ends here
       '<urn2:PlannedUnitDevelopment>'+PUD+'</urn2:PlannedUnitDevelopment><urn2:PropertyValue>'+ Property_Value+'</urn2:PropertyValue>'+
        '<urn2:ReferralId xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/><urn2:ReferralMedium xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>'+
              '<urn2:ReferralSource xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">'+Channel_Source+'</urn2:ReferralSource><urn2:ReferralTerm xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">'+Channel_Value+'</urn2:ReferralTerm>'+
               '<urn2:RouteName></urn2:RouteName><urn2:StateCode>'+StateCode+'</urn2:StateCode><urn2:SelfEmployedSince>'+BSelfEmployed+'</urn2:SelfEmployedSince><urn2:StateFipsCode xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>'+
       '<urn2:ContactTime>'+Time_contact+'</urn2:ContactTime><urn2:UnsupportedDetachedResidenceType>'+UnSupported_Detached+'</urn2:UnsupportedDetachedResidenceType><urn2:UnsupportedAttachedResidenceType>'+UnSupported_Attached+'</urn2:UnsupportedAttachedResidenceType><urn2:UnsupportedCondoType>'+UnSupported_Con+'</urn2:UnsupportedCondoType><urn2:ZipCode>'+ZipCode+'</urn2:ZipCode>'+
       '<urn2:NonOccupantRelationShip>'+Relationship_to_Borrower+'</urn2:NonOccupantRelationShip><urn2:BorrowerForeclosureOrLieuIndYearsAgo>'+Foreclosure_Years_Ago+'</urn2:BorrowerForeclosureOrLieuIndYearsAgo><urn2:Estimatedpropertycompletiondate>'+Property_Complete_Date+'</urn2:Estimatedpropertycompletiondate><urn2:HomeUnderConstruction>'+Property_UnderConstruction+'</urn2:HomeUnderConstruction>'+
       '<urn2:RentalIncomeAmount>'+MonthlyRentalIncome+'</urn2:RentalIncomeAmount><urn2:NumberofFinancedProperties>'+FinancedPropertiesAmount+'</urn2:NumberofFinancedProperties><urn2:MonthlyHousePayment>'+TotalMonthlyPrimary+'</urn2:MonthlyHousePayment>'+
        '</urn2:SolutionsFinderData>'+
        '<urn2:Address><urn2:StreetAddress>' + Borrowers_StreetAddress1 + '</urn2:StreetAddress><urn2:StreetAddress2>' + Borrowers_StreetAddress2 + '</urn2:StreetAddress2><urn2:City>' + Borrowers_City + '</urn2:City><urn2:State>' + Borrowers_State + '</urn2:State><urn2:Zipcode>' + Borrowers_Zip + '</urn2:Zipcode></urn2:Address>' +
        '<urn3:OriginalLeadNumber>'+Initial_OPUS_ID+'</urn3:OriginalLeadNumber>' +
        '<urn2:RelationshipBanker>' +  
        //changed by Vimal for the story B-571191, added RB_NMLS_ID__c statement in the below query
        '<urn2:MLONumber>'+RB_NMLS_id+'</urn2:MLONumber>'+
            '<urn2:FirstName>'+RB_Name+'</urn2:FirstName><urn2:EmailAddress>'+RB_Email+'</urn2:EmailAddress><urn2:OperatorId>'+RB_EID+'</urn2:OperatorId><urn2:BranchName>'+RB_Branch_Name+'</urn2:BranchName><urn2:BranchCostCenter>'+RB_Cost_Center+'</urn2:BranchCostCenter>' +            
        '</urn2:RelationshipBanker>' +        
      '</urn1:LoanCreateLeadRequest>'+
   '</soapenv:Body></soapenv:Envelope>';
     String xml3=xml+xml2;
     
    
 HttpRequest req = new HttpRequest();    
 req.setEndpoint(Label.OPUS_URL); 
 try {       
 req.setClientCertificateName(Label.OPUS_Certificate);    
 } catch (System.CalloutException e) {  
           System.debug('Certificate Error: ' + e);   
                                     }
 req.setMethod('POST');
 req.setHeader('SOAPAction','Invoke');      
 req.setHeader('Content-Type','text/xml;charset=UTF-8');     
 req.setHeader('User-Agent','Jakarta Commons-HttpClient/3.1');   
 req.setBody(xml3);              
 Http http = new Http();     
 String bodyRes = '';            
 try {           
 System.debug('CALL Lead Service');
  HttpResponse res;
  
 if(!Test.isRunningTest())
 {
     res = http.send(req);
 }
 else
 {
     res = MockHttpResponseGenerator.respond(req);
 }
 
 bodyRes = res.getBody();            
 System.debug('Response Received' + bodyRes);    
     }  catch(System.CalloutException e) {            
                System.debug('CALLOUT error: '+ e);     
                                         }     
 System.debug('Soap request:' + xml3);    
 System.debug('Soap response:' + bodyRes);   
 
  string loannumber = bodyRes.substringBetween('D','<');  
  system.debug('$$$$$$$$$$$$$$$$$$$$'+loannumber);
  if(loannumber.length() == 7 && loannumber.containsOnly('0123456789')){
   
  string updatedloannumber = 'D'+loannumber;  
  opp.Empower_Lead_ID__c = updatedloannumber;
  update opp;
  

    
  }
    return opp.Empower_Lead_ID__c;
  
        }
      else
  {
         string r = 'false';
         return r;
  }  
   
      }
   }