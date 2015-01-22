@isTest
Private Class TestClass_LeadOwnerChangePlugin{
static testMethod Void LeadOwnerChangePlugin(){
try{
LeadOwnerChangePlugin LOPlugin=new LeadOwnerChangePlugin();
Lead Ld = new lead();
Ld.status = 'Active';
Ld.Channel__c = 'Centralized Retail';
Ld.Channel_Sources__c = 'Bank';
Ld.Applicant_Type__c = 'Individual';
Ld.Channel_Values__c = 'RB Portal';
Ld.Internal_Referral__c = 'N/A';
Ld.Borrowers_Current_Residence__c =  'Own';
Ld.Company = 'None';
Ld.FirstName = 'Test';
Ld.LastName = 'Lead 1';
Ld.Borrowers_Home_Phone__c = '(111) 222-3333';
Ld.Property_State__c = 'TX';
Ld.Notes_Type__c = 'Called Home, Left Message – No Contact';
Ld.Loan_Purpose__c = 'Purchase';
insert Ld;
Lead L=[select id ,ownerid from lead where lastname='Lead 1' limit 1];

Map<string,id> inputParams = new Map<string,Id>();
Map<string,Id> inputParams1= new Map<string,Id>();
Map<string,Id> outputParams = new Map<string,Id>();

inputParams.put('leadId', L.id);
inputParams1.put('ownerId',L.ownerId);
Process.PluginRequest request = new Process.PluginRequest(inputParams);
Process.PluginRequest request1 = new Process.PluginRequest(inputParams1);  

       

Process.PluginResult result;
result = LOPlugin.invoke(request);

}Catch(exception e){}

}
static testMethod void Describetest() {

        LeadOwnerChangePlugin LOPlugin=new LeadOwnerChangePlugin();
        Process.PluginDescribeResult result = LOPlugin.describe();
}
}