public with sharing class CO_SearchRealtorContacts_CL {
    public List<Realtor_contacts__c> Realtorcons {get;set;}
    public string zipcode {get;set;}
    public Boolean showmesg {get;set;}
    public Boolean showtable {get;set;}
    public String messg {get;set;}
    List<ContactWrapper> actualContacts = new List<ContactWrapper>();
    
    public CO_SearchRealtorContacts_CL(){
        Realtorcons = new List<Realtor_contacts__c>();
    }
    public void findRealtorCons()
    {        
         Realtorcons = [select id,Name,phone__c,email__c,Mailing_ZIP_Postal_Code__c,createddate,Total_no_of_Leads__c from Realtor_Contacts__c where New_Realtor__c =:true and Mailing_ZIP_Postal_Code__c=:zipcode  order by phone__c,email__c,createddate limit 1000 ];
         if(Realtorcons!=null && Realtorcons.size()>0){                         
             ContactWrappermethod(Realtorcons);
             showtable=true;
             showmesg=false; 
                    
         }else{
             showmesg=true;
             showtable=false;
             messg = 'No records found with given Zip/Postal code';  
              
         }  
    }
    public void ContactWrappermethod(List<Realtor_Contacts__c> Contacts){
        actualContacts = new List<ContactWrapper>();
        for(integer i=0; i<Contacts.size(); i++){
            ContactWrapper wrapclass = new ContactWrapper(Contacts[i]);
            actualContacts.add(wrapclass);
        }
    }
    public class ContactWrapper{
        public string createddate{get; set;}
        public Realtor_Contacts__c Con{get; set;}
        public ContactWrapper(Realtor_Contacts__c conObj){
            createddate=conObj.createddate.format();
            Con=conObj;        
        }
    }
    public List<ContactWrapper> getVFContacts(){
        return actualContacts;
    }
}