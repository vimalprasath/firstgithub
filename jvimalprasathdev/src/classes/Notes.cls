/*
Name: CO_ContactManagement_CL
Author: Leena N
Description: This Class is used for creating a new note on lead creation and Notes Updation.
Last modified by: Leena N
*/
public class Notes{
    public void createNotes(List<Lead> New_Leads,list<Lead> Old_Leads){
        Notes__c NewNote1;
        user CreatedbyName ;
        Recordtype NotesRecordtype =  [select Id,name  from RecordType where Name = 'Prequal' and SobjectType = 'Lead' limit 1];
        
        List<Notes__c> insertNotes = new List<Notes__c>();
        List<Lead> UpdateLeadN = new List<Lead>();
        for(integer i = 0 ; i< New_Leads.size(); i++){                           
            if((New_Leads[i].Notes__c != null || New_Leads[i].Notes__c != '' || New_Leads[i].Notes_Type__c != null) &&(New_Leads[i].Notes_Type__c != Old_Leads[i].Notes_Type__c || New_Leads[i].Notes__c !=  Old_Leads[i].Notes__c) ){
                NewNote1 = new Notes__c(
                Lead__c = New_Leads[i].id,               
                Comments__c = New_Leads[i].Notes__c,
                Comments_List__c = New_Leads[i].Notes_Type__c                                    
                );   
                insertNotes.add(NewNote1); 
            } 
        }
        if(insertNotes.size()>0)
            insert insertNotes;           
    }
    public void createInsertNotes(List<Lead> New_Leads){
        Notes__c NewNote1;
        user CreatedbyName ;
        Recordtype NotesRecordtype =  [select Id,name  from RecordType where Name = 'Prequal' and SobjectType = 'Lead' limit 1];       
        List<Notes__c> insertNotes = new List<Notes__c>();
        for(Lead NotesLead : New_Leads){ 
            if((NotesLead.Notes__c != null || NotesLead.Notes__c != '') && NotesLead.Notes_Type__c != null ){
                NewNote1 = new Notes__c(
                Lead__c = NotesLead.id,               
                Comments__c = NotesLead.Notes__c,
                Comments_List__c = NotesLead.Notes_Type__c                                    
                );   
                insertNotes.add(NewNote1);
            }                                                       
        } 
        if(insertNotes.size()>0)
            Insert insertNotes;             
    }
}