/*
Description: Get the lead details for Site form and Insert Lead.
Created by: Hari
Last Modified: 8/17/2013 
*/

public with sharing class HomeLoanWTLController_CLS {

    public lead TLead ;
    public Recordtype WebRecordType;
    
    
    public HomeLoanWTLController_CLS(){
        try{
            TLead = new Lead();        
            if(ApexPages.currentPage().getParameters().get('Utm_campaign') != null)
                TLead.utm_campaign__c = ApexPages.currentPage().getParameters().get('Utm_campaign');
            if(ApexPages.currentPage().getParameters().get('Utm_content') != null)
                TLead.utm_content__c = ApexPages.currentPage().getParameters().get('Utm_content');
            if(ApexPages.currentPage().getParameters().get('Utm_medium') != null)
                TLead.utm_medium__c = ApexPages.currentPage().getParameters().get('Utm_medium');
            if(ApexPages.currentPage().getParameters().get('Utm_source') != null)
                TLead.utm_source__c = ApexPages.currentPage().getParameters().get('Utm_source');
            if(ApexPages.currentPage().getParameters().get('Utm_term') != null)
                TLead.utm_term__c = ApexPages.currentPage().getParameters().get('Utm_term');
            if(ApexPages.currentPage().getParameters().get('Utm_formversion') != null)
                TLead.Utm_FormVersion__c = ApexPages.currentPage().getParameters().get('Utm_formversion');                                                            
            //system.debug('&&&&&&&&&&&&&&'+TLead);
         }Catch(Exception e){
             //Error
         }
    }
    

    
    public PageReference SaveLead(){
        try
        {
        
        system.debug('&&&&&&&&&&&&&&'+ApexPages.currentPage().getUrl());
            //get the lead Record type - Web. Needs to be assigned to Lead.
            WebRecordType = [select id from recordtype where name = 'Web' limit 1];        
            
            //Set default assignment rule to True
            Database.DMLOptions dmo = new Database.DMLOptions();
            dmo.assignmentRuleHeader.useDefaultRule= true;
            
            // fetch the values from visualforce page form.
            //Mapping Loan Purpose
            if(ApexPages.currentPage().getParameters().get('loan_type') == 'Buy a Home')
                TLead.Loan_Purpose__c = 'Purchase' ;
            if(ApexPages.currentPage().getParameters().get('loan_type') == 'Mortgage Refinance')
                TLead.Loan_Purpose__c = 'Rate & Term Refinance' ;
            if(ApexPages.currentPage().getParameters().get('loan_type') == 'Cash-Out Refinance')
                TLead.Loan_Purpose__c = 'Cash-out Refinance' ; 
                             
            //TLead.Loan_Amount1__c = '$' + ApexPages.currentPage().getParameters().get('hidden_loan_amount');                
            //TLead.Requested_Loan_Amount__c = decimal.valueOf(ApexPages.currentPage().getParameters().get('hidden_loan_amount'));
            //TLead.Estimated_property_value__c ='$' + ApexPages.currentPage().getParameters().get('hidden_estimated_value');
            TLead.Requested_Loan_Amount__c = decimal.valueOf(ApexPages.currentPage().getParameters().get('hidden_loan_amount'));
            TLead.Value_of_Home__c = decimal.valueOf(ApexPages.currentPage().getParameters().get('hidden_estimated_value'));
            //TLead.Estimated_property_value__c ='$' + ApexPages.currentPage().getParameters().get('hidden_estimated_value');
            
            TLead.Loan_Type__c = 'Conventional';
            //Mapping Credit Scores.
            if(ApexPages.currentPage().getParameters().get('credit_score') == 'Excellent (740+)')
                TLead.How_Would_you_Describe_Your_Credit__c = '740-800' ;
            else if(ApexPages.currentPage().getParameters().get('credit_score') == 'Very Good (720-739)')
                TLead.How_Would_you_Describe_Your_Credit__c = '720-739' ; 
            else if(ApexPages.currentPage().getParameters().get('credit_score') == 'Good (700-719)')
                TLead.How_Would_you_Describe_Your_Credit__c = '700-719' ;  
            else if(ApexPages.currentPage().getParameters().get('credit_score') == 'Fair (680-699)')
                TLead.How_Would_you_Describe_Your_Credit__c = '680-699' ;  
            else if(ApexPages.currentPage().getParameters().get('credit_score') == 'Less than 680')
                    TLead.How_Would_you_Describe_Your_Credit__c = 'Less than 660' ;                                                             
            
            
            TLead.Shopping_Stage__c = ApexPages.currentPage().getParameters().get('when_apply');
            TLead.Property_Zip_Postal_Code__c = ApexPages.currentPage().getParameters().get('zip_code');
            TLead.FirstName = ApexPages.currentPage().getParameters().get('first_name');
            TLead.LastName = ApexPages.currentPage().getParameters().get('last_name');
            TLead.Phone = ApexPages.currentPage().getParameters().get('phone');
            TLead.Email = ApexPages.currentPage().getParameters().get('email');         
            TLead.RecordTypeId = WebRecordType.id;
            TLead.Channel__c = 'Centralized Retail';
            TLead.Company = 'N/A';
            TLead.Property_State__c = 'NA';
            TLead.Channel_Values__c = 'Lead Aggregator';
            
            if(ApexPages.currentPage().getParameters().get('Source_URL') != null)
            TLead.Utm_SourceURL__c = ApexPages.currentPage().getParameters().get('source_url');  
            //system.debug('&&&&&&&&&&&&&&'+TLead);
            TLead.setOptions(dmo);        
            //system.debug('&&&&&&&&&&&&&&'+ApexPages.currentPage().getUrl());
            insert TLead;
            
            //Redirect to Confirmation screen on Complete
            PageReference page = new PageReference('/apex/Confirmation');
            page.setRedirect(true);
            return page;
            }catch(Exception e)
            {
                return null;
            }
            
        
    }
    
}