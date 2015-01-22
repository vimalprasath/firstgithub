/*
Description: 
1. When a Realtor Contact is deleted also delete record from Realtor Contact Management.
2. When new Realtor is created or Existing Realtor Contact is edited, the parent realtor id is found and Updated. 
Created By: Leena (Wipro Technologies)
Last Modified By: Yunus (Wipro Technologies) 14/11/2012

*/

trigger Realtor_BD_trg on Realtor_Contacts__c (before Insert, before update, before delete) {
    List<Realtor_Contact_Management__c> listrcmdel = new List<Realtor_Contact_Management__c>(); 
    set<string> setrcids = new set<string>();           
    //map<Id, List<Realtor_Contacts__c>> parentAndChildren = new map<Id, List<Realtor_Contacts__c>>();   
    //List<Realtor_Contacts__c> children;
    map<Id, List<Realtor_Contacts__c>> parentAndChildren = new map<Id, List<Realtor_Contacts__c>>();   
    List<Realtor_Contacts__c> children;
    List<Realtor_Contacts__c> listParent= new List<Realtor_Contacts__c>();
    List<Realtor_Contacts__c> listChildren = new List<Realtor_Contacts__c>();
    List<Realtor_Contacts__c> listUpdate = new List<Realtor_Contacts__c>();
    set<string> setrcids1 = new set<string>();  
    
    If(Trigger.isdelete){
        for(Realtor_Contacts__c rc:trigger.old){
            setrcids.add(rc.id);
        }
        if(setrcids!=null && setrcids.size()>0){
            listrcmdel = [select id from Realtor_Contact_Management__c where realtor_contact__c in:setrcids];
        }
        if(listrcmdel!=null && listrcmdel.size()>0){
            delete listrcmdel;
        }
    }

    if(trigger.isUpdate || Trigger.isInsert){
    
        try{
            map<string,Realtor_Contacts__c> temp1 = new Map<String,Realtor_Contacts__c>();
            map<string,Realtor_Contacts__c> temp2 = new Map<String,Realtor_Contacts__c>();
            map<string,Realtor_Contacts__c> temp3 = new Map<String,Realtor_Contacts__c>();
            map<string,Realtor_Contacts__c> temp4 = new Map<String,Realtor_Contacts__c>();
            
            Realtor_Contacts__c tttt;
            Realtor_Contacts__c tttd;
            Realtor_Contacts__c tttHP;
            Realtor_Contacts__c tttMP;
            
            system.debug('***************Trigger.new***************'+Trigger.new);
            
            if(Trigger.isInsert){
                for(Realtor_Contacts__c tt: [select Phone__c,Email__c,id,New_Realtor__c,Realtor_id__c,Home_Phone__c,Mobile_Phone__c from Realtor_Contacts__c order by createddate]){
                    system.debug('******************************'+tt);
                    temp2.put(tt.Phone__c,tt);
                    temp1.put(tt.Email__c,tt);
                    temp3.put(tt.Home_Phone__c,tt);
                    temp4.put(tt.Mobile_Phone__c,tt);
                }
            }
            if(Trigger.isUpdate){
                for(Realtor_Contacts__c tt: [select Phone__c,Email__c,id,New_Realtor__c,Realtor_id__c,Home_Phone__c,Mobile_Phone__c from Realtor_Contacts__c where id not in: trigger.new order by createddate]){
                    system.debug('******************************'+tt);
                    temp2.put(tt.Phone__c,tt);
                    temp1.put(tt.Email__c,tt);
                    temp3.put(tt.Home_Phone__c,tt);
                    temp4.put(tt.Mobile_Phone__c,tt);
                }
            }
            system.debug('********1**********'+temp2);
            system.debug('********1**********'+temp1);
            system.debug('********1**********'+temp3);
            system.debug('********1**********'+temp4);
            
            for(Realtor_Contacts__c te : Trigger.new){              
                String ttt = te.Phone__c;
                String ttd = te.Email__c;
                String ttHP = te.Home_Phone__c;
                String ttMP = te.Mobile_Phone__c;
                
                system.debug('********1**********'+ttt);
                system.debug('********1**********'+ttd);
                system.debug('********1**********'+ttHP);
                system.debug('********1**********'+ttMP);
                
                boolean newRCPhone = true;
                boolean newRCEmail = true;
                boolean newRCHomeP = true;
                boolean newRCMobileP = true;
                

                if(ttt != null){
                    if(temp2.containsKey(ttt) && te.New_Realtor__c == false){
                        system.debug('********1**********');                 
                        tttt = temp2.get(ttt);
                        if(tttt != null && tttt.Phone__c != null ){
                           if (tttt.New_Realtor__c == true)
                               te.Realtor_Id__c = tttt.id;
                            else
                               te.Realtor_Id__c = tttt.Realtor_id__c; 
                            te.New_Realtor__c = False; 
                            newRCPhone = false;
  
                        }
                    }                    
                }
                if(ttd != null ){
                  //  if(temp1.containsKey(ttd)&& te.New_Realtor__c == false){ 
                   if(temp1.containsKey(ttd) && te.New_Realtor__c == false){ 

                        system.debug('********2**********');                
                        tttd = temp1.get(ttd);                        
                        if(tttd!=null && tttd.Email__c != null ){
                            if (tttd.New_Realtor__c == true)
                               te.Realtor_Id__c = tttd.id;
                            else
                               te.Realtor_Id__c = tttd.Realtor_id__c; 
                            te.New_Realtor__c = False;
                            newRCEmail = false;
                        }
                    }                   
                }
                if(ttHP != null){
                    if(temp3.containsKey(ttHP)&& te.New_Realtor__c == false){
                        system.debug('********3**********');                 
                        tttHP = temp3.get(ttHP);
                        if(tttHP != null && tttHP.Home_Phone__c != null ){
                            if (tttHP.New_Realtor__c == true)
                               te.Realtor_Id__c = tttHP.id;
                            else
                               te.Realtor_Id__c = tttHP.Realtor_id__c; 

                            te.New_Realtor__c = False; 
                            newRCHomeP = false;
  
                        }
                    }                    
                }
                
                if(ttMP != null){
                    if(temp4.containsKey(ttMP)&& te.New_Realtor__c == false){
                        system.debug('********3**********');                 
                        tttMP = temp4.get(ttMP);
                        if(tttMP!= null && tttMP.Mobile_Phone__c != null ){
                            if (tttMP.New_Realtor__c == true)
                               te.Realtor_Id__c = tttMP.id;
                            else
                               te.Realtor_Id__c = tttMP.Realtor_id__c; 


                            te.Realtor_Id__c = tttMP.id;
                            te.New_Realtor__c = False; 
                            newRCMobileP = false;
  
                        }
                    }                    
                }
                System.debug('****************************'+newRCEmail+newRCPhone+newRCHomeP+newRCMobileP);
                if(newRCEmail == true && newRCPhone == true && newRCHomeP == true && newRCMobileP == true){                    
                    te.New_Realtor__c = true;                 
                }
                system.debug('ttttttttttttttttttttttt'+te.New_Realtor__c);
              
            }
           // if(trigger.isUpdate)  
           // countofLeads_CL.CountofLeads_method(trigger.new);                    
        }Catch(Exception e){       
        } 
    } 
}