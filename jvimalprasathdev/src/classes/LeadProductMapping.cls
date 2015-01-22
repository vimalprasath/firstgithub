/*
Name: LeadProductMapping
Author: Vimal 
Description: This Class update the Product Preference field for the record which are coming from Sofi according to Custom Setting "Product Preference Mapping" Values
For the story #B493593
*/

public class LeadProductMapping {
	
	public void leadProductPreferenceMapping (List<Lead> Leads){
		
		try {
			
		for(Lead tmpLead: leads){
			String tmpProductPreference='';  
			
			for(String splitProductPreference : tmpLead.Product_Preferences__c.split(';')){ 
				Product_Preference_Mapping__C tmpProductMapping=Product_Preference_Mapping__C.getInstance(splitProductPreference.trim()); 
				
				if(tmpProductMapping!=null){                
				   tmpProductPreference=tmpProductPreference+tmpProductMapping.Mapping_Value__c+';'; 
				}            
				     
			}
			    
			if(tmpProductPreference!=''){         
			   TmpLead.Product_Preferences__c=tmpProductPreference.trim();             
			}
			
		}
		
	  }
	  Catch(Exception e){
	  system.debug('Exception thrown while performing Product Preference Mapping'+e);
	  }
	  
	}//End of Method LeadProductPreferenceMapping

}//End of Class LeadProductMapping