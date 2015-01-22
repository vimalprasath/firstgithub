@isTest
public class HomeLoanWTLController_TestCLS {

    public static testMethod void TestmethodHomeLoanWTLController() {
        
        PageReference pageRef = Page.HomeloansWTL_v1;
        Test.setCurrentPage(pageRef);
        
        Apexpages.currentpage().getparameters().put('Utm_campaign','TestCampaign');
        ApexPages.currentPage().getParameters().put('Utm_content','TestContent');
        ApexPages.currentPage().getParameters().put('Utm_medium','TestMedium');
        ApexPages.currentPage().getParameters().put('Utm_source','TestSource');
        ApexPages.currentPage().getParameters().put('Utm_term','Testterm');
        ApexPages.currentPage().getParameters().put('Source_URL','TestURL');
        ApexPages.currentPage().getParameters().put('Utm_formversion','testform');
         
        HomeLoanWTLController_CLS TestCall = new HomeLoanWTLController_CLS();              
        
        ApexPages.currentPage().getParameters().put('loan_type', 'Buy a Home');
        //ApexPages.currentPage().getParameters().put('loan_amount', '123456');
        ApexPages.currentPage().getParameters().put('hidden_loan_amount', '123456');
        //ApexPages.currentPage().getParameters().put('estimated_value', '1234');
        ApexPages.currentPage().getParameters().put('hidden_estimated_value', '1234');
        ApexPages.currentPage().getParameters().put('credit_score', 'Very Good (720-739)');
        ApexPages.currentPage().getParameters().put('when_apply', 'Immediately');
        ApexPages.currentPage().getParameters().put('zip_code', '12345');
        ApexPages.currentPage().getParameters().put('first_name', 'TestFirstName');
        ApexPages.currentPage().getParameters().put('last_name', 'TestLastName');
        ApexPages.currentPage().getParameters().put('phone', '1112345678');
        ApexPages.currentPage().getParameters().put('email', 'Test@test.com');
        TestCall.SaveLead();
        
        ApexPages.currentPage().getParameters().put('credit_score', 'Excellent (740+)');
        TestCall.SaveLead();
        ApexPages.currentPage().getParameters().put('credit_score', 'Very Good (720-739)');
        TestCall.SaveLead();
        ApexPages.currentPage().getParameters().put('credit_score', 'Fair (680-699)');
        TestCall.SaveLead();
        ApexPages.currentPage().getParameters().put('credit_score', 'Less than 680');        
        TestCall.SaveLead();
        ApexPages.currentPage().getParameters().put('credit_score', 'Good (700-719)');        
        TestCall.SaveLead();        
        ApexPages.currentPage().getParameters().put('credit_score', 'ABCD');
        TestCall.SaveLead(); 
        ApexPages.currentPage().getParameters().put('loan_type', 'Mortgage Refinance');
        TestCall.SaveLead();
        ApexPages.currentPage().getParameters().put('loan_type', 'Cash-Out Refinance');
        TestCall.SaveLead();
                              
        
    }
}