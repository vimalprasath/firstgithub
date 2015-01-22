/*
Name: CO_DisplayLeadRate_CL
Author: Yunus H
Description: This Class displays the ratch watch functionlity
Last modified by: Leena N
*/
public with sharing class CO_DisplayLeadRate_CL 
{
    public Decimal currentrate1 {get;set;}
    public Decimal currentrate2 {get;set;}
    public Decimal currentrate3 {get;set;}
    public Boolean showmesg {get;set;}
    public Boolean showtable {get;set;}
    public String messg {get;set;}
    public List<Lead> CurrentrateLeads {get;set;}
    Public CO_DisplayLeadRate_CL()
    {
        CurrentrateLeads = new List<Lead>();                        
    }  
    //method to find the leads with different current rate and loan term  
    public void findLead()
    {        
         CurrentrateLeads = [select id,Name,email,status,Current_Rate__c,Loan_Term__c,Rate_Loan_type__c from Lead where Rate_Loan_type__c = 'Conforming' and ((Current_Rate__c >=: currentrate3 and Loan_Term__c = '30') OR (Current_Rate__c >=: currentrate2 and Loan_Term__c = '20') OR (Current_Rate__c >=: currentrate1 and Loan_Term__c = '15')) limit 1000 ];
         if(CurrentrateLeads!=null && CurrentrateLeads.size()>0){
             showtable=true;
             showmesg=false;            
         } 
         else{
             showmesg=true;
             showtable=false;
             messg = 'No records found with given criteria';   
         }  
    }
}