public with sharing class LeadExtension {
public void init () {
}
     public Lead l {get;set;}
    public LeadExtension(Apexpages.standardController stdController) {
        this.l = (Lead)stdController.getRecord(); 
    }
   /* public void init () {
    system.debug('88888888888888');
    
        Lead ld = [select Channel_Sources__c,Channel_Values__c,id,ref_id__c,firstname,status,recordtypeid,recordtype.name,Empower_Lead_ID__c,VFUpdate__c,New_to_Active__c,Is_Sofi_Lead__c,My_Lead__c,Transfer_To_HLR__c,My_Lead_to_Sofi__c,owner.firstname,owner.lastname from lead where id =:l.id limit 1];
        recordtype rt = [select Id,Name from RecordType where Name Like: 'No_Send_to_empower' and SobjectType = 'Lead' limit 1];
        system.debug('++++++++++'+ld.recordtype.Name);
        system.debug('++++++++++'+rt.Name);
        system.debug('++++++++++'+ld.owner.firstname);
        system.debug('============='+ld.My_Lead_to_Sofi__c);
        system.debug('&&&&&&&&&&&&&&&&&&&&&1111'+ld.VFUpdate__c+'&&&&&&&&&&&&&&&&&&&&&11111'+ld.New_to_Active__c);
        try{
        //added for web RecordType
        if(ld.ref_id__c != null && ld.status == 'New - Not Opened'){
        
         RecordType rt1 = [select Id,Name from RecordType where Name Like: 'Web' and SobjectType = 'Lead' limit 1];
            ld.VFUpdate__c = 'YES'; 
            ld.recordtypeId = rt1.Id;
            system.debug('@@@+++++++'+ld.recordtype.Name);
            system.debug('============='+ld.status+'#################New - not opened');
            system.debug('&&&&&&&&&&&&&&&&&&&&&222222'+ld.VFUpdate__c+'&&&&&&&&&&&&&&&&&&&&&222222'+ld.New_to_Active__c);
            update ld;
         }
         
         //added for "web for send to opus" Recordtype
         else if(ld.ref_id__c != null && ld.status != 'New - Not Opened' && (ld.Empower_Lead_ID__c == null || ld.Empower_Lead_ID__c == '')){
            RecordType rt1 = [select Id,Name from RecordType where Name Like: 'Web for Send to Opus' and SobjectType = 'Lead' limit 1];
            ld.VFUpdate__c = 'YES'; 
            ld.recordtypeId = rt1.Id;
            system.debug('@@@+++++++'+ld.recordtype.Name);
            system.debug('============='+ld.My_Lead_to_Sofi__c);
            system.debug('============='+ld.status+'################# NOTTTT New - not opened');
            system.debug('&&&&&&&&&&&&&&&&&&&&&222222'+ld.VFUpdate__c+'&&&&&&&&&&&&&&&&&&&&&222222'+ld.New_to_Active__c);
            update ld;
         }
            
            
         else{    
                if(ld.owner.firstname == null && ld.owner.lastname == null && (ld.Empower_Lead_ID__c == null || ld.Empower_Lead_ID__c == '')){
                RecordType rt1 = [select Id,Name from RecordType where Name Like: 'Queue Lead' and SobjectType = 'Lead' limit 1];
                ld.VFUpdate__c = 'YES'; 
                ld.recordtypeId = rt1.Id;
                system.debug('@@@+++++++'+ld.recordtype.Name);
                system.debug('============='+ld.owner.firstname);
                system.debug('&&&&&&&&&&&&&&&&&&&&&222222'+ld.VFUpdate__c+'&&&&&&&&&&&&&&&&&&&&&222222'+ld.New_to_Active__c);
                update ld;
            }
            else if(ld.status == 'New - Not Opened' && (ld.Empower_Lead_ID__c == null || ld.Empower_Lead_ID__c == '')) {
            if (( ld.Channel_Sources__c =='Bank' && ld.Channel_Values__c =='RB Portal') || ( ld.Channel_Sources__c =='Direct 360' &&( ld.Channel_Values__c =='Inbound' ||ld.Channel_Values__c =='Outbound' ))) {
                RecordType rt1 = [select Id,Name from RecordType where Name Like: 'RB No Send to empower' and SobjectType = 'Lead' limit 1];
                ld.VFUpdate__c = 'YES'; 
                ld.recordtypeId = rt1.Id;
                system.debug('@@@+++++++'+ld.recordtype.Name);
                system.debug('============='+ld.My_Lead_to_Sofi__c);
                system.debug('&&&&&&&&&&&&&&&&&&&&&222222'+ld.VFUpdate__c+'&&&&&&&&&&&&&&&&&&&&&222222'+ld.New_to_Active__c);
                update ld;
                }
               else{
                ld.recordtypeid =rt.Id;
                ld.VFUpdate__c = 'YES';  //Added for sprint 6B 
                system.debug('++++++++++'+ld);
                system.debug('============='+ld.My_Lead_to_Sofi__c);
                update ld;
                system.debug('++++++++++'+ld.recordtype.Name); 
                system.debug('&&&&&&&&&&&&&&&&&&&&&333333'+ld.VFUpdate__c+'&&&&&&&&&&&&&&&&&&&&&333333'+ld.New_to_Active__c);
                }
            }
           
           
            
             else if(ld.status != 'New - Not Opened' && (ld.Empower_Lead_ID__c == null || ld.Empower_Lead_ID__c == '') && ld.Transfer_To_HLR__c == true) { 
             if (( ld.Channel_Sources__c =='Bank' && ld.Channel_Values__c =='RB Portal') || ( ld.Channel_Sources__c =='Direct 360' &&( ld.Channel_Values__c =='Inbound' ||ld.Channel_Values__c =='Outbound' ))) {
                RecordType rt1 = [select Id,Name from RecordType where Name Like: 'RB No Send to empower Unlock HLR Lead Id' and SobjectType = 'Lead' limit 1];
                ld.VFUpdate__c = 'YES'; 
                ld.recordtypeId = rt1.Id;
                system.debug('@@@+++++++'+ld.recordtype.Name);
                system.debug('============='+ld.My_Lead_to_Sofi__c);
                update ld;
                }
             else{  
                RecordType rt1 = [select Id,Name from RecordType where Name Like: 'No Send to empower Unlock HLR Lead Id' and SobjectType = 'Lead' limit 1]; 
                ld.recordtypeid = rt1.Id;
                ld.VFUpdate__c = 'YES';  //Added for sprint 6B 
                system.debug('++++++++++'+ld.recordtype.Name);
                system.debug('============='+ld.My_Lead_to_Sofi__c);
                update ld;
                }
            }
          
               
            else if(ld.status != 'New - Not Opened' && (ld.Empower_Lead_ID__c == null || ld.Empower_Lead_ID__c == '' ) && ld.Transfer_To_HLR__c == false) {  // new logic added for New lead 
               if (( ld.Channel_Sources__c =='Bank' && ld.Channel_Values__c =='RB Portal') || ( ld.Channel_Sources__c =='Direct 360' &&( ld.Channel_Values__c =='Inbound' ||ld.Channel_Values__c =='Outbound' ))) {
                RecordType rt1 = [select Id,Name from RecordType where Name Like: 'RB MC Send to empower when HLR true' and SobjectType = 'Lead' limit 1];
                ld.VFUpdate__c = 'YES'; 
                ld.recordtypeId = rt1.Id;
                system.debug('@@@+++++++'+ld.recordtype.Name);
                system.debug('============='+ld.My_Lead_to_Sofi__c);
                update ld;
                }
               else{
                RecordType rt1 = [select Id,Name from RecordType where Name Like: 'MC_Send_to_empower_when_HLR_true' and SobjectType = 'Lead' limit 1];
                ld.VFUpdate__c = 'YES';  //Added for sprint 6B 
                ld.recordtypeId = rt1.Id;
                system.debug('++++++++++'+ld.recordtype.Name);
                system.debug('============='+ld.My_Lead_to_Sofi__c);
                update ld;
                }
            }
       }
       }
       catch(Exception e){
       system.debug('Error is found in the following line'+e);
     }

      try{
       string emp = ld.Empower_Lead_ID__c;
        if (emp != null ) {
        System.debug('++Test' + ld.status +'Test1'+ ld.Empower_Lead_ID__c + 'Test2' +ld.Is_Sofi_Lead__c);
        
        
        //added for "web for view in opus" Recordtype
        if(ld.ref_id__c != null && ld.status != 'New - Not Opened'){
            RecordType rt1 = [select Id,Name from RecordType where Name Like: 'Web for View in Opus' and SobjectType = 'Lead' limit 1];
            ld.VFUpdate__c = 'YES'; 
            ld.recordtypeId = rt1.Id;
            system.debug('@@@+++++++'+ld.recordtype.Name);
            system.debug('============='+ld.My_Lead_to_Sofi__c);
            system.debug('&&&&&&&&&&&&&&&&&&&&&222222'+ld.VFUpdate__c+'&&&&&&&&&&&&&&&&&&&&&222222'+ld.New_to_Active__c);
            update ld;
         }


        else if(ld.status == 'New - Not Opened' && emp.startswith('D') && ld.Is_Sofi_Lead__c == false) { // Removed  || emp.startswith('E')
        if (( ld.Channel_Sources__c =='Bank' && ld.Channel_Values__c =='RB Portal') || ( ld.Channel_Sources__c =='Direct 360' &&( ld.Channel_Values__c =='Inbound' ||ld.Channel_Values__c =='Outbound' ))) {
         system.debug('@@@++++++++entered if');
            RecordType rt1 = [select Id,Name from RecordType where Name Like: 'RB No Send to empower1' and SobjectType = 'Lead' limit 1];
            ld.VFUpdate__c = 'YES'; 
            ld.recordtypeId = rt1.Id;
            system.debug('@@@+++++++'+ld.recordtype.Name);
            system.debug('============='+ld.My_Lead_to_Sofi__c);
            update ld;
           system.debug('@@@+++++++'+ld.recordtype.Name);
            }
        else{  
            RecordType rt1 = [select Id,Name from RecordType where Name Like: 'No_Send_to_empower1' and SobjectType = 'Lead' limit 1];
            ld.recordtypeId = rt1.Id;
            ld.VFUpdate__c = 'YES';  //Added for sprint 6B 
           // ld.Is_Sofi_Lead__c = true;
            system.debug('+++++entered 1+++++'+ld.recordtype.Name);
            system.debug('============='+ld.My_Lead_to_Sofi__c);
            update ld;     
            }       
            }
          //Added for sprint 6B  
        else if(ld.status == 'New - Not Opened' && emp.startswith('D') && ld.Is_Sofi_Lead__c == true ) { // Removed  || emp.startswith('E')
        if (( ld.Channel_Sources__c =='Bank' && ld.Channel_Values__c =='RB Portal') || ( ld.Channel_Sources__c =='Direct 360' &&( ld.Channel_Values__c =='Inbound' ||ld.Channel_Values__c =='Outbound' ))) {
            system.debug('@@@enterdif');
            RecordType rt1 = [select Id,Name from RecordType where Name Like: 'RB No send to empower in  My Sofi Leads' and SobjectType = 'Lead' limit 1];
            ld.VFUpdate__c = 'YES'; 
            ld.recordtypeId = rt1.Id;
            system.debug('@@@+++++++'+ld.recordtype.Name);
            system.debug('============='+ld.My_Lead_to_Sofi__c);
            update ld;
            system.debug('@@@+++++++'+ld.recordtype.Name);
            }
         else{   
            RecordType rt1 = [select Id,Name from RecordType where Name Like: 'No send to empower in My Sofi Leads' and SobjectType = 'Lead' limit 1];
            ld.recordtypeId = rt1.Id;
            ld.VFUpdate__c = 'YES';  //Added for sprint 6B 
           // ld.Is_Sofi_Lead__c = true;
            system.debug('+++++entered 1+++++'+ld.recordtype.Name);
            system.debug('============='+ld.My_Lead_to_Sofi__c);
            update ld;       
            }     
            }
            
        else if(ld.status != 'New - Not Opened' && emp.startswith('D') && ld.Is_Sofi_Lead__c == false && ld.My_Lead__c == false) { // Removed  || emp.startswith('E')
        if (( ld.Channel_Sources__c =='Bank' && ld.Channel_Values__c =='RB Portal') || ( ld.Channel_Sources__c =='Direct 360' &&( ld.Channel_Values__c =='Inbound' ||ld.Channel_Values__c =='Outbound' ))) {
             system.debug('@@@Entered if+++++++');
            RecordType rt1 = [select Id,Name from RecordType where Name Like: 'RB No send to empower in  My Sofi Leads' and SobjectType = 'Lead' limit 1];
            ld.VFUpdate__c = 'YES'; 
            ld.recordtypeId = rt1.Id;
            system.debug('@@@+++++++'+ld.recordtype.Name);
            system.debug('============='+ld.My_Lead_to_Sofi__c);
            update ld;
            }
         else{
            system.debug('+++++ entered 2+++++'+ld.recordtype.Name);
            RecordType rt2 = [select Id,Name from RecordType where Name Like: 'No send to empower in My Sofi Leads' and SobjectType = 'Lead' limit 1]; // Changed from No_Send_to_empower2
            ld.recordtypeId = rt2.Id;
            ld.VFUpdate__c = 'YES';  //Added for sprint 6B 
           // ld.Is_Sofi_Lead__c = true;
            system.debug('+++++ entered 2+++++'+ld.recordtype.Name);
            system.debug('+++++ entered 2+++++'+rt2.Name);
            system.debug('============='+ld.My_Lead_to_Sofi__c);
            update ld;   
            }   
        } 
        
        else if(ld.status != 'New - Not Opened' && emp.startswith('D') && ld.Is_Sofi_Lead__c == true && ld.Transfer_to_HLR__c == true) { // Removed  || emp.startswith('E')
        
            if (( ld.Channel_Sources__c =='Bank' && ld.Channel_Values__c =='RB Portal') || ( ld.Channel_Sources__c =='Direct 360' &&( ld.Channel_Values__c =='Inbound' ||ld.Channel_Values__c =='Outbound' ))) {
            system.debug('@@@entered if');
            RecordType rt1 = [select Id,Name from RecordType where Name Like: 'RB No Send To Empower for My Sofi leads with HLR ID Unlocked' and SobjectType = 'Lead' limit 1];
            ld.VFUpdate__c = 'YES'; 
            ld.recordtypeId = rt1.Id;
            system.debug('@@@+++++++'+ld.recordtype.Name);
            system.debug('============='+ld.My_Lead_to_Sofi__c);
            update ld;
            }
            else{
            system.debug('+++++ entered 2+++++'+ld.recordtype.Name);
            RecordType rt2 = [select Id,Name from RecordType where Name Like: 'No Send To Empower for My Sofi leads with HLR ID Unlocked' and SobjectType = 'Lead' limit 1];
            ld.recordtypeId = rt2.Id;
            ld.VFUpdate__c = 'YES';  //Added for sprint 6B 
           // ld.Is_Sofi_Lead__c = true;
            system.debug('@@@entered 2+++++'+ld.recordtype.Name);
            system.debug('+++++ entered 2+++++'+rt2.Name);
            system.debug('============='+ld.My_Lead_to_Sofi__c);
            update ld;   
            }   
        }
        
        else if(ld.status != 'New - Not Opened' && emp.startswith('D') && ld.Is_Sofi_Lead__c == false && ld.My_Lead__c == true && ld.Transfer_To_HLR__c == true) { // Removed  || emp.startswith('E')
        if (( ld.Channel_Sources__c =='Bank' && ld.Channel_Values__c =='RB Portal') || ( ld.Channel_Sources__c =='Direct 360' &&( ld.Channel_Values__c =='Inbound' ||ld.Channel_Values__c =='Outbound' ))) {
            system.debug('@@@entered if');
            RecordType rt1 = [select Id,Name from RecordType where Name Like: 'RB No Send To Empower for My Sofi leads with HLR ID Unlocked' and SobjectType = 'Lead' limit 1];
            ld.VFUpdate__c = 'YES'; 
            ld.recordtypeId = rt1.Id;
            system.debug('@@@+++++++'+ld.recordtype.Name);
            system.debug('============='+ld.My_Lead_to_Sofi__c);
            update ld;
            }
          else{
            system.debug('+++++ entered 2+++++'+ld.recordtype.Name);
            RecordType rt2 = [select Id,Name from RecordType where Name Like: 'No Send To Empower for My Sofi leads with HLR ID Unlocked' and SobjectType = 'Lead' limit 1];
            ld.recordtypeId = rt2.Id;
            ld.VFUpdate__c = 'YES';  //Added for sprint 6B 
           // ld.Is_Sofi_Lead__c = true;
            system.debug('+++++ entered 2+++++'+ld.recordtype.Name);
            system.debug('+++++ entered 2+++++'+rt2.Name);
            system.debug('============='+ld.My_Lead_to_Sofi__c);
            update ld;  
            }    
        }  
        else if(ld.status != 'New - Not Opened' && emp.startswith('D') && ld.Is_Sofi_Lead__c == false && ld.My_Lead__c == true && ld.Transfer_To_HLR__c == false && ld.My_Lead_to_Sofi__c == true) { // Removed  || emp.startswith('E')
        if (( ld.Channel_Sources__c =='Bank' && ld.Channel_Values__c =='RB Portal') || ( ld.Channel_Sources__c =='Direct 360' &&( ld.Channel_Values__c =='Inbound' ||ld.Channel_Values__c =='Outbound' ))) {
            RecordType rt1 = [select Id,Name from RecordType where Name Like: 'RB No Send to empower2' and SobjectType = 'Lead' limit 1];
            ld.VFUpdate__c = 'YES'; 
            ld.recordtypeId = rt1.Id;
            system.debug('@@@+++++++'+ld.recordtype.Name);
            system.debug('============='+ld.My_Lead_to_Sofi__c);
            update ld;
            }
         else{
            system.debug('+++++ entered 2+++++'+ld.recordtype.Name);
            RecordType rt2 = [select Id,Name from RecordType where Name Like: 'No_Send_to_empower2' and SobjectType = 'Lead' limit 1];
            ld.recordtypeId = rt2.Id;
            ld.VFUpdate__c = 'YES';  //Added for sprint 6B 
           // ld.Is_Sofi_Lead__c = true;
            system.debug('+++++ entered 2+++++'+ld.recordtype.Name);
            system.debug('+++++ entered 2+++++'+rt2.Name);
            system.debug('============='+ld.My_Lead_to_Sofi__c);
            update ld;    
            }  
        }
        
        else if(ld.status != 'New - Not Opened' && emp.startswith('D') && ld.Is_Sofi_Lead__c == false && ld.My_Lead__c == true && ld.Transfer_To_HLR__c == false && ld.My_Lead_to_Sofi__c == false) { // Removed  || emp.startswith('E')
        if (( ld.Channel_Sources__c =='Bank' && ld.Channel_Values__c =='RB Portal') || ( ld.Channel_Sources__c =='Direct 360' &&( ld.Channel_Values__c =='Inbound' ||ld.Channel_Values__c =='Outbound' ))) {
            RecordType rt1 = [select Id,Name from RecordType where Name Like: 'RB No send to empower in  My Sofi Leads without HLR' and SobjectType = 'Lead' limit 1];
            ld.VFUpdate__c = 'YES'; 
            ld.recordtypeId = rt1.Id;
            system.debug('@@@+++++++'+ld.recordtype.Name);
            system.debug('============='+ld.My_Lead_to_Sofi__c);
            update ld;
            }
         else{
            system.debug('+++++ entered 2+++++'+ld.recordtype.Name);
            RecordType rt2 = [select Id,Name from RecordType where Name Like: 'No send to empower in My Sofi Leads without HLR' and SobjectType = 'Lead' limit 1]; // changed  back from 'No send to empower in My Sofi Leads'
            ld.recordtypeId = rt2.Id;
            ld.VFUpdate__c = 'YES';  //Added for sprint 6B 
           // ld.Is_Sofi_Lead__c = true;
            system.debug('+++++ entered 2+++++'+ld.recordtype.Name);
            system.debug('+++++ entered 2+++++'+rt2.Name);
            system.debug('============='+ld.My_Lead_to_Sofi__c);
            update ld;   
            }   
        }
        
        else if(emp.startswith('E')) {
            system.debug('+++++ entered 2+++++'+ld.recordtype.Name);
            RecordType rt2 = [select Id,Name from RecordType where Name Like: 'For_My_loans' and SobjectType = 'Lead' limit 1];
            ld.recordtypeId = rt2.Id;
            ld.VFUpdate__c = 'YES';  //Added for sprint 6B 
           // ld.Is_Sofi_Lead__c = true;
            system.debug('+++++ entered 2+++++'+ld.recordtype.Name);
            system.debug('+++++ entered 2+++++'+rt2.Name);
            system.debug('============='+ld.My_Lead_to_Sofi__c);
            update ld;   
             
        }
        }
       }
 catch(Exception e){
      system.debug('Error is found in the following line'+e);
     }
    }*/
}