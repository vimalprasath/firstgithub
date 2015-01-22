trigger CreateLead_OnSubmit on Customer_Portal_Lead__c (After insert) {
Contact TContact; 
 // try{    
        user loggerInUser = [select contactid,Profile.name from user where id =: userinfo.getuserid() and (Profile.name =: 'Authenticated Portal Website' OR Profile.name =: 'System Administrator') limit 1];
        system.debug('$$$$$$$$$$$$$$$$$$$$'+loggerInUser);
        if(loggerInUser.Profile.name == 'Authenticated Portal Website') {
        TContact = [select Branch_Region__c,Branch__r.District__r.Region__r.Parent_Region__c,Branch__r.RB_Branch_Type__c,Branch_Number__c,Branch_Name__c,Branch_District__c,RelationShip_Banker_EID__c,FirstName,LastName,Name from Contact where id =: loggerInUser.contactid];
        system.debug('$$$$$$$$$$$$$$$$$$$$'+TContact );
        }
        Lead NewLead_inst;
        List<Lead> Newleads_List = new List<lead>();
        
        //Added for RRv2
        Database.DMLOptions dmo = new Database.DMLOptions();
        dmo.assignmentRuleHeader.useDefaultRule = true;

        Lead NewLead_CustomerPortal;
        if(trigger.isAfter){
            if(trigger.isinsert) {                    
                for(Customer_Portal_Lead__c TCustomPortal : trigger.new){
                    NewLead_CustomerPortal = new Lead();                
                    if(TCustomPortal.Create_Lead__c == true){                                            
                        NewLead_CustomerPortal.Suffix__c = TCustomPortal.Suffix__c;
                        NewLead_CustomerPortal.FirstName = TCustomPortal.First_Name__c;
                        NewLead_CustomerPortal.LastName =  TCustomPortal.Last_Name__c;
                        NewLead_CustomerPortal.Status = 'New - Not Opened';
                        NewLead_CustomerPortal.Applicant_Type__c = TCustomPortal.Applicant_Type__c;
                        NewLead_CustomerPortal.Channel__c =  'Centralized Retail';
                        NewLead_CustomerPortal.Channel_Sources__c = 'Bank';
                        NewLead_CustomerPortal.Channel_Values__c = 'RB Portal';
                        NewLead_CustomerPortal.Company = 'N/A'; 
                        NewLead_CustomerPortal.Occupancy_Code__c = TCustomPortal.Occupancy_Code__c;
                        NewLead_CustomerPortal.Property_State__c = TCustomPortal.Property_State__c;
                        NewLead_CustomerPortal.Internal_Referral__c = 'N/A';
                        NewLead_CustomerPortal.Borrowers_Current_Residence__c = TCustomPortal.Borrowers_Current_Residence__c;
                        if(TCustomPortal.Loan_Purpose__c == 'Refinance') {
                        NewLead_CustomerPortal.Loan_Purpose__c = 'Cash-out Refinance';  
                        }
                        else {
                        NewLead_CustomerPortal.Loan_Purpose__c = TCustomPortal.Loan_Purpose__c;
                        }
                        system.debug('@@@@3@@@'+TCustomPortal.Preferred_Contact_Method__c);
                        NewLead_CustomerPortal.Preferred_Contact_Method__c = TCustomPortal.Preferred_Contact_Method__c;
                        NewLead_CustomerPortal.Loan_Type__c = 'Conventional';
                        if(TCustomPortal.Property_Use__c == 'Primary') {
                            NewLead_CustomerPortal.Occupancy_Code__c = 'Owner Occupied';
                        }
                        else if (TCustomPortal.Property_Use__c == 'Vacation or Second Home') {
                            NewLead_CustomerPortal.Occupancy_Code__c = 'Second Home';   
                        }
                        else {
                            NewLead_CustomerPortal.Occupancy_Code__c = TCustomPortal.Property_Use__c;
                        }
                        if(TCustomPortal.Property_Type__c == 'Hi-Rise Condominium') {
                            NewLead_CustomerPortal.Property_Type__c = 'High-Rise (9+)';
                        }
                        else if(TCustomPortal.Property_Type__c == 'Single-Family Home Attached') {
                            NewLead_CustomerPortal.Property_Type__c = 'SFR Attached';
                        }
                        else if(TCustomPortal.Property_Type__c == 'Single-Family Home Detached') {
                            NewLead_CustomerPortal.Property_Type__c = 'SFR Detached';
                        }
                        else if(TCustomPortal.Property_Type__c == 'Low-Rise Condominium') {
                            NewLead_CustomerPortal.Property_Type__c = 'Low-Rise (1-4)';
                        }
                        else {
                        NewLead_CustomerPortal.Property_Type__c = TCustomPortal.Property_Type__c;
                        }
                        NewLead_CustomerPortal.Value_of_Home__c = TCustomPortal.Approximate_value_of_your_property__c;
                        NewLead_CustomerPortal.Notes__c = TCustomPortal.Additional_Information__c;
                        NewLead_CustomerPortal.Time_zone__c = TCustomPortal.Time_zone__c;
                        NewLead_CustomerPortal.Best_contact_time__c = TCustomPortal.Best_contact_time__c;
                        NewLead_CustomerPortal.Requested_Loan_Amount__c = TCustomPortal.Total_amount_finance_needed__c;
                        NewLead_CustomerPortal.Email = TCustomPortal.Email__c;
                        //-----------Address                       
                        NewLead_CustomerPortal.BorrowersHouse__c = TCustomPortal.Borrowers_Address_1__c;
                        NewLead_CustomerPortal.Borrowers_Address_1__c = TCustomPortal.Borrowers_Address_2__c;
                        NewLead_CustomerPortal.Borrowers_City__c = TCustomPortal.Borrowers_City__c ;
                        NewLead_CustomerPortal.Borrowers_State__c = TCustomPortal.Borrower_State_2__c;
                        NewLead_CustomerPortal.Borrowers_County__c = TCustomPortal.Borrowers_County__c;
                        NewLead_CustomerPortal.Borrowers_Country__c = TCustomPortal.Borrowers_Country__c;
                        NewLead_CustomerPortal.Borrowers_Zip_Postal_Code__c = TCustomPortal.Borrowers_Zip_Postal_Code__c;
                        
                        if(TCustomPortal.Preferred_Contact_Method__c == 'Mobile Phone'){
                        NewLead_CustomerPortal.Borrowers_Mobile_Phone__c = TCustomPortal.Borrowers_Home_Phone__c;
                        NewLead_CustomerPortal.Borrowers_Work_Phone__c  = TCustomPortal.Daytime_Phone__c;
                        }
                        else if(TCustomPortal.Preferred_Contact_Method__c == 'Work Phone'){
                        NewLead_CustomerPortal.Borrowers_Work_Phone__c = TCustomPortal.Borrowers_Home_Phone__c;
                        
                        }
                         
                        else if(TCustomPortal.Preferred_Contact_Method__c == 'Home Phone'){
                        NewLead_CustomerPortal.Borrowers_Home_Phone__c = TCustomPortal.Borrowers_Home_Phone__c;
                        NewLead_CustomerPortal.Borrowers_Work_Phone__c  = TCustomPortal.Daytime_Phone__c;
                        
                        }
                        system.debug('@@@@4@@@@'+NewLead_CustomerPortal.Borrowers_Mobile_Phone__c);
                        system.debug('@@@@5@@@@'+NewLead_CustomerPortal.Borrowers_Work_Phone__c);
                        system.debug('@@@@6@@@@'+NewLead_CustomerPortal.Borrowers_Home_Phone__c);
                        
                        
                        //-------------Branch Details from Contact
                        //
                        if(loggerInUser.Profile.name == 'Authenticated Portal Website') {
                        NewLead_CustomerPortal.Department__c = TContact.Branch__r.District__r.Region__r.Parent_Region__c;
                        NewLead_CustomerPortal.RB_First_Name__c = TContact.FirstName;
                        NewLead_CustomerPortal.RB_Last_Name__c = TContact.LastName;
                        NewLead_CustomerPortal.RelationShip_Banker_Name__c = TContact.Name;
                        NewLead_CustomerPortal.RelationShip_Banker_EID__c = TContact.RelationShip_Banker_EID__c;
                        NewLead_CustomerPortal.RB_Branch_Type__c=TContact.Branch__r.RB_Branch_Type__c;
                        //system.debug('RB Branch Type'+ NewLead_CustomerPortal.RB_Branch_Type__c);
                        }
                        //-------------
                        NewLead_CustomerPortal.Notes_Type__c ='Relationship Banker';
                        NewLead_CustomerPortal.Submitted__c = 'Submitted';
                        
                        //--------------RB Portal Customers Details
                         NewLead_CustomerPortal.Branch_Details__c = TCustomPortal.RB_Branch__c;
                         NewLead_CustomerPortal.RB_Branch__c = TCustomPortal.RB_Branch__c;
                         NewLead_CustomerPortal.RB_District__c = TCustomPortal.RB_District__c;
                         NewLead_CustomerPortal.RB_Region__c = TCustomPortal.RB_Region__c;
                         //NewLead_CustomerPortal.RelationShip_Banker_EID__c = TCustomPortal.RelationShip_Banker_EID__c;
                         NewLead_CustomerPortal.RB_Cost_Center__c = TCustomPortal.RB_Cost_Center__c;
                         //NewLead_CustomerPortal.Branch_ID__c = TCustomPortal.Branch_ID__c;
                        
                        //NewLead_CustomerPortal.DU_Response__c = TCustomPortal.DU_Response__c;               
                      //  NewLead_CustomerPortal.Customer_Portal_Lead__c = TCustomPortal.id;
                        NewLead_CustomerPortal.setOptions(dmo);// Added for RRv2
                        Newleads_List.add(NewLead_CustomerPortal);
                        system.debug('&&&&&&&&&&&&&&&&&&&&&&&&'+NewLead_CustomerPortal);
                        system.debug('&&&&&&&&&&&&&&&&&&&&&&&&'+Newleads_List);
                    }                                              
                }   
               
                insert Newleads_List;    
      }
        }
    // }
  // catch(Exception e){ 
  //  system.debug('Error is in expression '+e);
  //     }
    }