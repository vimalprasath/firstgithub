/* 
Description: Need a report that is the same as today's MDW report when Lead Conversion launches.
 Author - Richard Joseph
 Created Date- March 20th, 2014            
 User Story - B-316184 
 
 **** Change Log *****
 Changed by Richard for User Story B364350 
*/
public class MDWReportGenerator {

public String ReportGenerator(List<sObject> ScopeOppList) 
{

     //Gets List fo fields from custome setting.
     List<MDW_Report_Fields__c> MDWFieldsList= [Select id, Name,Field_API_Name__c from MDW_Report_Fields__c ];
     Map<integer,String> MDWFieldsMap= new Map<integer,String>();
     Map<Id,String> UserMap = new  Map<Id,String>();
    
    
    List<Opportunity> OppList=new List<Opportunity>();
        
        Map<Id,Opportunity> OppLeadMap = New Map<Id,Opportunity>();
        Map<Id,Opportunity> OppNoLeadMap = New Map<Id,Opportunity>();
        Set<Id> LeadId = new Set<Id> ();
  
         //Opp which are converted from lead and new opp
        for(sObject SobjectRec : ScopeOppList){
           
           Opportunity OppRec = (Opportunity) SobjectRec ;
           
           if (OppRec.Related_Lead__c != null)
           {
               OppLeadMap.put(OppRec .Id,OppRec );
               LeadId.add(OppRec.Related_Lead__c);
               }
            else
                OppNoLeadMap.put(OppRec.Id,OppRec);         
           
           UserMap.put(OppRec.OwnerId,OppRec.Owner.Name );
           UserMap.put(OppRec.CreatedById,OppRec.CreatedBy.Name );
           UserMap.put(OppRec.LastModifiedbyId,OppRec.LastModifiedby.Name );
           
        }  
    
////////////// Converted Leads///////////////////////////////   
    // Query Leads of the converted opp to get Lead, Opp and Accounts data
    String Query = null;
    
    If(MDWFieldsList.size()>0){
    Query = 'Select id ';
     
    for (MDW_Report_Fields__c MDWFieldRec: MDWFieldsList){
        
            if (MDWFieldRec.Field_API_Name__c != null)
            {
            Query = Query +' , '+ MDWFieldRec.Field_API_Name__c ;
            MDWFieldsMap.put(Integer.ValueOf(MDWFieldRec.name),MDWFieldRec.Field_API_Name__c );
            }
    } 
     /* Updated for user story B-548183 - Vimal - Added "createdby.name" field in the below query */
     Query = Query + ',Account_name__c,Related_Opportunity__c,Co_Borrower__c,Internal_Referral_Name__c,createdby.name From Lead where RecordType.Name =\'IsConverted\'  AND ID in :LeadId';
     
     List<Sobject> LeadList = Database.Query(Query);
     
     string header = null;
     //string finalstr = header ;
     string finalstr = null;
     Pattern PatternRemoveOthers = Pattern.compile('[,\n\r]');
     
     // Build the Report data string  for each lead . The column position and field names are derived from custom setting.
     string FieldName = null; 
     for (Sobject SobjectRec:LeadList){
        Lead LeadRec = (Lead)SobjectRec;         
        string recordString =null;
        Integer ColumnPosion = 0;
        for (MDW_Report_Fields__c MDWFieldRec: MDWFieldsList){
            ColumnPosion++;
            FieldName= MDWFieldsMap.get(ColumnPosion);
            If (FieldName != null){              
                If( FieldName.contains('.')){
                    FieldName=FieldName.replaceAll('\\.', ':');
                    String[] RelatedFields = FieldName.split(':',5);            
                    If (String.valueOf(LeadRec.getSObject(RelatedFields[0]))!= null && RelatedFields[0] != null && RelatedFields[1] != null ){
                        If( String.valueOf(LeadRec.getSObject(RelatedFields[0]).get(RelatedFields[1]))!=null)   {
                            If (RelatedFields[1]== 'OwnerId'|| RelatedFields[1]== 'CreatedById' || RelatedFields[1]== 'LastModifiedbyId')
                            {   
                                
                                If(UserMap.get((Id)LeadRec.getSObject(RelatedFields[0]).get(RelatedFields[1])) != null)
                                recordString= String.valueOf(UserMap.get((Id)LeadRec.getSObject(RelatedFields[0]).get(RelatedFields[1]))) +',';
                                else
                                recordString= ',';
                                
                            }
                            else if (RelatedFields[1]== 'Transfer_To_HLR__c')
                            {   
                                If (String.valueOf(LeadRec.getSObject(RelatedFields[0]).get(RelatedFields[1])) != null)
                                recordString = (Boolean.valueOf(LeadRec.getSObject(RelatedFields[0]).get(RelatedFields[1]))?'1':'0')+',';
                                else
                                recordString= ',';
                            }
                            else if  (RelatedFields[1]== 'Lead_Opp_Created_Timestamp__c'){
                                If (String.valueOf(LeadRec.getSObject(RelatedFields[0]).get(RelatedFields[1])) != null)
                                //recordString = String.valueOf(DateTime.valueOf(LeadRec.getSObject(RelatedFields[0]).get(RelatedFields[1])).format('MM/dd/YYYY hh:mm a')) +',';
                                recordString = String.valueOf(DateTime.valueOf(LeadRec.getSObject(RelatedFields[0]).get(RelatedFields[1])).format('MM/dd/yyyy hh:mm a')) +',';
                                else
                                recordString= ',';
                            }
                            else
                            recordString= PatternRemoveOthers.matcher(String.valueOf(LeadRec.getSObject(RelatedFields[0]).get(RelatedFields[1]))).replaceall(' ') +',';
                        }
                        else
                            recordString= ',';
                    }
                    else
                        recordString= ',';
                }
                else{
                    
                     If (String.valueOf(LeadRec.get(FieldName))!= null)
                     {  
                        if (FieldName == 'Active_Timestamp__c' )
                        {
                            /* Updated for user story B-446278 - Sunil - Start here */
                            
                            //recordString = String.valueOf(DateTime.valueOf(LeadRec.get(FieldName)).format('MM/dd/YYYY hh:mm a'))+','; 
                            recordString = String.valueOf(DateTime.valueOf(LeadRec.get(FieldName)).format('MM/dd/yyyy hh:mm a'))+',';   
                            
                            /* Updated for user story B-446278 - Sunil - End here */
                        
                        }
                        else if (FieldName == 'Notes__c')
                        {
                            try{
                                
                            recordString = PatternRemoveOthers.matcher(String.valueOf(LeadRec.get(FieldName))).replaceall(' ')+',';
                            }
                            catch(exception ex)
                            {
                                recordString= ',';  
                            }
                        }
                        /* Updated for user story B-548183 - Vimal - Start here */
                        else if (FieldName == 'CreatedById')
                        {
                        	recordString = String.valueOf(LeadRec.CreatedBy.Name)+',';
                        }
                          /* Updated for user story B-548183 - Vimal - End here */
                    else
                        recordString = PatternRemoveOthers.matcher(String.valueOf(LeadRec.get(FieldName))).replaceall(' ')+',';
                     }
                    else
                        recordString= ',';      
                }       
                If (recordString!= null){
                    If (finalstr == null)
                        finalstr = recordString;
                    else
                        finalstr = finalstr +recordString;
                }
            }
        }
        finalstr = finalstr.removeEnd(',')  +'\n';
     }
///////////Non Converted Leads//////////////////////     
    if (OppNoLeadMap.size() >0)
    {
    
        String OppConFieldName = null;
         Map<string,OpportunityContactRole > AccountMap = new Map<string,OpportunityContactRole > ();
         
         Set <Id> PersonAcct = new Set<Id>();
         Map<Id,Id> OppBorrAccMap = New Map<Id,Id>();
         Map<Id,Id> OppCoBorrAccMap = New Map<Id,Id>();
         Map<Id,Account> BorrAccMap = New Map<Id,Account>();
         Map<Id,Account> CoBorrAccMap = New Map<Id,Account>();
         ////Query Opp Contact Role data for Opp with contact roles.
         /* Updated for user story B-559251 - Vimal - changed where condition "ID" to "OpportunityId" in the below query */
         For (OpportunityContactRole OppContRec : [Select Id,OpportunityId,ContactId,Contact.AccountId,Role  From OpportunityContactRole where OpportunityId in :OppNoLeadMap.keySet()])
         {
         	
            PersonAcct.add(OppContRec.Contact.AccountId);  /* Updated for user story B-559251 - Vimal*/
            If(OppContRec.ROle=='Borrower' && OppContRec.OpportunityId != null)
            OppBorrAccMap.Put(OppContRec.Contact.AccountId,OppContRec.OpportunityId);
            Else If(OppContRec.ROle=='Co-Borrower' && OppContRec.OpportunityId != null )
              OppCoBorrAccMap.Put(OppContRec.Contact.AccountId,OppContRec.OpportunityId);
         }
         ///Query Person Accounts which are related to Opportunity via Opp Contact Role.
   If(MDWFieldsList.size()>0){
    String StrQuery = 'Select id ';
    
    for (MDW_Report_Fields__c MDWFieldRec: MDWFieldsList){
        
        OppConFieldName= MDWFieldRec.Field_API_Name__c;
        
            if (OppConFieldName.contains('Account_Name__r'))
            {
            
            If( OppConFieldName.contains('.'))
            {
                OppConFieldName=OppConFieldName.replaceAll('\\.', ':');
                String[] RelatedFields = OppConFieldName.split(':',5);
            
             If (RelatedFields[0] != null && RelatedFields[1] != null )
             {
                 StrQuery = StrQuery + ' , '+ RelatedFields[1] ;
             }
             
            }
            
            
            }
    } 
    
     
     StrQuery = StrQuery + '  From Account  where ID in :PersonAcct';
     
     List<sobject> SobjectList = database.Query(StrQuery);
     
    
     //Map for Opp and Related Contact Roles(Accounts)
     for (Sobject SobjectContRoleRec:SobjectList)
     {
            Account AccountRec= (Account)SobjectContRoleRec;
            If(OppBorrAccMap.containsKey(AccountRec.id)) 
                BorrAccMap.put(OppBorrAccMap.get(AccountRec.id),AccountRec);
            if(OppCoBorrAccMap.containsKey(AccountRec.id)) 
                CoBorrAccMap.put(OppCoBorrAccMap.get(AccountRec.id),AccountRec);
        
     }
   }
        ///Build report string for opp with out leads.
    For (Opportunity OppRec: OppNoLeadMap.Values())
     {
            
        string OppRecordString =null;
        String OppFieldName = null;
        Integer ColumnPosion = 0;
        for (MDW_Report_Fields__c MDWFieldRec: MDWFieldsList){
            ColumnPosion++;
            OppFieldName= MDWFieldsMap.get(ColumnPosion);
            If ((OppFieldName.contains('Related_Opportunity__r'))){              
                If( OppFieldName.contains('.')){
                    OppFieldName=OppFieldName.replaceAll('\\.', ':');
                    String[] RelatedFields = OppFieldName.split(':',5);         
                    If (RelatedFields[1] != null && String.valueOf(OppRec.get(RelatedFields[1])) != null ){ 
                        If (RelatedFields[1]== 'OwnerId'|| RelatedFields[1]== 'CreatedById' || RelatedFields[1]== 'LastModifiedbyId')
                        {                   
                            If(UserMap.get((Id)OppRec.get(RelatedFields[1]))!= null) 
                                OppRecordString= String.valueOf(UserMap.get((id)OppRec.get(RelatedFields[1]))) +',';
                            else
                                OppRecordString= ',';
                        }
                        else if (RelatedFields[1]== 'Transfer_To_HLR__c')
                            {   
                                If (String.valueOf(OppRec.get(RelatedFields[1])) != null)
                                OppRecordString = (Boolean.valueOf(OppRec.get(RelatedFields[1]))?'1':'0')+',';
                                else
                                OppRecordString= ',';
                            }
                            else if  (RelatedFields[1]== 'Lead_Opp_Created_Timestamp__c'){
                                If (String.valueOf(OppRec.get(RelatedFields[1])) != null)
                                //OppRecordString = String.valueOf(DateTime.Valueof(OppRec.get(RelatedFields[1])).format('MM/dd/YYYY hh:mm a')) +',';
                                OppRecordString = String.valueOf(DateTime.Valueof(OppRec.get(RelatedFields[1])).format('MM/dd/yyyy hh:mm a')) +',';
                                else
                                OppRecordString= ',';
                            }
                        else
                        OppRecordString= PatternRemoveOthers.matcher(String.valueOf(OppRec.get(RelatedFields[1]))).replaceall(' ') +',';
                    }
                    else
                        OppRecordString= ',';
                }
                else{
                    OppRecordString= ',';       
                }       
                
            }
            else if  ((OppFieldName.contains('Account_Name__r'))){
                
                             
                If( OppFieldName.contains('.')){
                    OppFieldName=OppFieldName.replaceAll('\\.', ':');
                    String[] RelatedFields = OppFieldName.split(':',5);         
                    If (RelatedFields[1] != null && BorrAccMap.size()>0 && BorrAccMap.Containskey(OppRec.id) && BorrAccMap.get(OppRec.id).get(RelatedFields[1])!=null ){    
                        
                        OppRecordString= PatternRemoveOthers.matcher(String.valueOf(BorrAccMap.get(OppRec.id).get(RelatedFields[1]))).replaceall(' ') +',';
                    }
                    else
                        OppRecordString= ',';
                }
                else{
                    OppRecordString= ',';       
                }       
                
            
                
            
                
            }
            /* For User Story B-461181 By Sunil ---- Start Here  */
            
            else if(OppFieldName.contains('Lead_Owner_EID__c')){
                OppRecordString = OppRec.owner.EmployeeNumber +',';
            }
            
            /* For User Story B-461181 By Sunil ---- End Here */
            
            /* Updated for user story B-548183 - Vimal - Start here */
            else if (OppFieldName.contains('CreatedById'))
            {
               	OppRecordString = String.valueOf(UserMap.get((id)OppRec.get(OppFieldName)))+',';
            }
            /* Updated for user story B-548183 - Vimal - End here */
            else if  ((OppFieldName.contains('Co_Borrower__r'))){
                
                             
                If( OppFieldName.contains('.')){
                    OppFieldName=OppFieldName.replaceAll('\\.', ':');
                    String[] RelatedFields = OppFieldName.split(':',5);         
                    If (RelatedFields[1] != null && CoBorrAccMap.size()>0 && CoBorrAccMap.containsKey(OppRec.id) && CoBorrAccMap.get(OppRec.id).get(RelatedFields[1]) != null ){    
                        
                        OppRecordString= PatternRemoveOthers.matcher(String.valueOf(CoBorrAccMap.get(OppRec.id).get(RelatedFields[1]))).replaceall(' ') +',';
                    }
                    else
                        OppRecordString= ',';
                }
                else{
                    OppRecordString= ',';       
                }       
                
            
                
            
                
            }
            else
                OppRecordString= ',';
             
            If (OppRecordString!= null){
                If (finalstr == null)
                    finalstr = OppRecordString;
                else
                    finalstr = finalstr +OppRecordString;
                }
        }
        finalstr = finalstr.removeEnd(',') +'\n';
     } 
    
    }

return finalstr;
    
    
    }
    

        return null;
        
    
}
// Build report header string.
public String ReportHeaderGenerator()
{
    string header = null;
     List<MDW_Report_Fields__c> MDWFieldsList= [Select id, Name,Field_API_Name__c from MDW_Report_Fields__c ];
     
     
     Map<integer,String> MDWFieldsMap= new Map<integer,String>();
     
     If(MDWFieldsList.size()>0){
        for (MDW_Report_Fields__c MDWFieldRec: MDWFieldsList){
        
        MDWFieldsMap.put(Integer.ValueOf(MDWFieldRec.name),MDWFieldRec.Field_API_Name__c );
        }
        
        Integer ColumnPosion = 0;
        for (MDW_Report_Fields__c MDWFieldRec: MDWFieldsList){
         ColumnPosion++;
            String FieldName= MDWFieldsMap.get(ColumnPosion);
            If (FieldName != null){
                 
                If (header!= null)      
                header = header+FieldName+',';
                else
                header = FieldName +',';
                
                
            }
        }
        header = header.removeEnd(',')+'\n';
     }
     
     return  header;
    
    
}

}