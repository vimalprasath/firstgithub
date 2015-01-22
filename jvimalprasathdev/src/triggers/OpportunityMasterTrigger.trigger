trigger OpportunityMasterTrigger on Opportunity (after insert,after update, before insert,before Update) {
   
   // Story # B628492 start 
   if(Trigger.isBefore){
   		try{
        	UpdateRatings.getOppRatings(Trigger.new);
   		}catch(Exception e){
   			System.debug('Error during update Opp Rating '+ e);
   		}
   // Story # B628492 End		
   }else {
        
	    if(trigger.isinsert)
	    {
	        transient List<Opportunity> oppList=new List<Opportunity>();
	        transient List<Id> noteID=new List<Id>();
	        for(Opportunity opp:trigger.new)
	        {
	            if(opp.Related_Lead__c!=null)
	            {      
	                oppList.add(opp);
	                noteID.add(opp.Related_Lead__c);
	            }      
	            //oppList.add(opp);
	            //noteID.add(opp.Related_Lead__c);
	        } 
	        List<Notes__c> noteList=new List<Notes__c>();
	        transient List<Notes__c> nList=[Select Id, Lead__c FROM Notes__c WHERE Lead__c=:noteID ];
	        
	        if(nList.size()>0)
	        {
	            for(Notes__c n:nList)
	            {
	                if(oppList.size()>0)
	                {
	                    for(Opportunity o:oppList)
	                    {
	                        if(o.Related_Lead__c==n.Lead__c)
	                        {
	                            //noteList.add()
	                            transient Notes__c notes=new Notes__c();
	                            notes.Id=n.Id;
	                            notes.Opportunity__c=o.Id;
	                            noteList.add(notes);
	                        }
	                    }
	                }
	            }
	        }
	        
	        update noteList;
	        
	        
	    /* Changes done by Richard to comment this logic out
	    Customer_Portal_Lead__c newCusPorLead = new Customer_Portal_Lead__c();
	  try{  
	    for(Opportunity Opp:trigger.new)
	    {
	       if(Opp.Related_Lead__c == null )
	          {
	             Id Accid  =opp.accountid;
	             system.debug('Accout id:'+accid);
	             Account acc=[select Best_Contact_Time__c,Phone,FirstName,LastName,Address_1__c,Address_2__c,Apt__c,City__c,Country__c,County__c,Current_Residence_Type__c,House__c,Preferred_Contact_Method__c,State__c,Time_Zone__c,Work_Phone__c,How_would_you_describe_your_credit__c,Zip_Postal_Code__c,PersonMobilePhone,Marital_Status__c from account where id = :accid limit 1];
	             newCusPorLead.Applicant_Type__c = Opp.Applicant_Type__c;  
	             newCusPorLead.Channel__c = Opp.Channel__c;  
	             newCusPorLead.Channel_Sources__c = Opp.Channel_Sources__c;  
	             newCusPorLead.Channel_Values__c = Opp.Channel_Values__c;  
	             newCusPorLead.Closing_Fees__c = String.valueof(Opp.Closing_Fees__c);  
	             newCusPorLead.Total_amount_finance_needed__c = Opp.Requested_Loan_Amount__c;  
	             newCusPorLead.Loan_Purpose__c = Opp.Loan_Purpose__c;  
	             newCusPorLead.Loan_Status__c = Opp.Loan_Status__c;  
	             newCusPorLead.Loan_Term__c = Opp.Loan_Term__c;  
	             newCusPorLead.Empower_Lead_ID__c = Opp.Empower_Lead_ID__c;  
	             newCusPorLead.Property_State__c = Opp.Property_State__c;  
	             newCusPorLead.Property_Type__c = Opp.Property_Type__c;
	             newCusPorLead.Transfer_To_HLR__c = Opp.Transfer_To_HLR__c;
	             newCusPorLead.Best_Contact_Time__c = acc.Best_Contact_Time__c;
	             newCusPorLead.First_Name__c = acc.FirstName;
	             newCusPorLead.Last_Name__c = acc.LastName;  
	             newCusPorLead.Borrowers_Country__c = acc.Country__c;  
	             newCusPorLead.Borrowers_Address_1__c = acc.Address_1__c;  
	             newCusPorLead.Borrowers_Address_2__c = acc.Address_2__c;  
	             newCusPorLead.Borrowers_City__c = acc.City__c;  
	             newCusPorLead.Borrowers_County__c = acc.County__c;  
	             newCusPorLead.Borrowers_Current_Residence__c = acc.Current_Residence_Type__c;  
	             newCusPorLead.Borrower_State_2__c = acc.State__c;  
	             newCusPorLead.Borrowers_Zip_Postal_Code__c = acc.Zip_Postal_Code__c;  
	             newCusPorLead.Marrital_Status__c = acc.Marital_Status__c; 
	             newCusPorLead.Preferred_Contact_Method__c = acc.Preferred_Contact_Method__c; 
	             newCusPorLead.Related_Opportunity__c = opp.id;
	             
	            insert newCusPorLead;
	            }
	     }   
	   } catch(Exception e){system.debug('Error is:'+e);}   
	   */
	  } 
	    if(trigger.isupdate){
	    
	    
	         try{
	            
	            list<id> ids = new list<id>();
	            
	            for(opportunity opp:trigger.new)
	            {ids.add(opp.id);}
	                    
	            list<Customer_Portal_Lead__c> newCusPorLead =new list<Customer_Portal_Lead__c>([select id,Lead__r.Related_Opportunity__c from  Customer_Portal_Lead__c where Related_Opportunity__c = :ids or lead__r.Related_Opportunity__c = :ids ]);
	            if(newCusPorLead.size()> 0)
	            {update newCusPorLead;}
	            
	            
	     /* Updated for User Story B411330 to upload LO information to OPUS when owner ID is changed  -  Start Here */
	     
	            if(!UpdateOPUSInfo.hasAlreadyDone()){               
	            	UpdateOPUSInfo.setAlreadyDone();               
	            	Map<Id,Opportunity> oppMap = new Map<Id,Opportunity>();              
	            	for(Id id : trigger.newMap.keySet()){          
	            		System.debug(Trigger.newMap.get(id).OwnerId + ' <<< owner IDs>>> ' + Trigger.oldMap.get(id).OwnerId );          
	            		if(Trigger.newMap.get(id).Empower_Lead_ID__c != null && trigger.newMap.get(id).OwnerId != Trigger.oldMap.get(id).OwnerId){            
	            			oppMap.put(id,Trigger.newMap.get(id));          
	            		}        
	            	}                            
	            	if(oppMap.size()>0)                
	            	UpdateOPUSInfo.updateLOService(oppMap.keySet());                                      
	            } 
	                               
	     /* Updated for User Story B411330 to upload LO information to OPUS when owner ID is changed  -  End Here*/
	            
	            
	            
	            
	            } catch(Exception e){system.debug('Error is:'+e);}   
	  } 
   }
}