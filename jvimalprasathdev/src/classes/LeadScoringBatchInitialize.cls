/*
Copyright (c) 2012, salesforce.com, Inc.
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, 
are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, 
    this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice, 
    this list of conditions and the following disclaimer in the documentation 
    and/or other materials provided with the distribution.
    * Neither the name of the salesforce.com, Inc. nor the names of its contributors 
    may be used to endorse or promote products derived from this software 
    without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, 
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, 
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE 
OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED 
OF THE POSSIBILITY OF SUCH DAMAGE.

*/
public class LeadScoringBatchInitialize{

    // Constructor - this only really matters if the autoRun function doesn't work right
    public LeadScoringBatchInitialize() {
    }
    // Code we will invoke on button click.
    public void autoRun() {
        autoRunLeads(null);
        autoRunCampaignMembers(null);
    }
 
    public Id autoRunCampaignMembers(Integer qryLimit) {
        
        //get the field names from here next, and then do the same for the other query, check exceptions
        LeadScoringRule__c[] Rules=leadScoring.activeLeadScoringRuleDetails('Lead');
        List<String> fieldNames=new List<String>();
        
        //Then invoke the campaign member updates
        Map<String, Schema.SObjectField> cmMap=Schema.SObjectType.CampaignMember.fields.getMap();
        Map<String,DisplayType> cmTypeMap=new Map<String,DisplayType>(); //this will hold the field type for all the fields in the LeadScoringRule__c

        //gets the field types for each rule, needed for formula's later
        cmTypeMap=leadScoring.getRuleFieldInfo(cmMap, Rules);

        for (Integer i=0;i<Rules.size();i++){
            if(cmTypeMap.containsKey(Rules[i].Field_Name__c)==True){
                fieldNames.add(Rules[i].Field_Name__c);
            } else {
                Rules.remove(i);//remove the rule if that field name isn't a valid field on Lead or Campaign Member
            }//if 1
        }//for 1
        String qrySOQL=leadScoring.getRuleFieldNames(fieldNames);
        qrySOQL='SELECT ' + qrySOQL +'Id,Campaign_Score__c,LeadId,CampaignId,ContactId FROM CampaignMember WHERE contactId=NULL';

        if(qryLimit != null && qryLimit > 0){
            qrySOQL = qrySOQL + ' LIMIT ' + qryLimit;
        }
        
        LeadCampaignScoreInitialize initCMs= new LeadCampaignScoreInitialize ();
        initCMs.cmQuery = qrySOQL;
        Id cmProcessId;
        if(qryLimit != null && qryLimit <= 100) {
            cmProcessId = Database.executeBatch(initCMs, qryLimit);
        } else {                
            cmProcessId = Database.executeBatch(initCMs, 100);
        } 
        return cmProcessId;
    }//autoRunCampaignMembers
    
    
    public Id autoRunLeads(Integer qryLimit) {
         //First invoke the lead initialization.  
        LeadScoringInitialize initLeads= new LeadScoringInitialize();
        
        //get the field names from here next, and then do the same for the other query, check exceptions
        LeadScoringRule__c[] Rules=leadScoring.activeLeadScoringRuleDetails('Lead');
        List<String> fieldNames=new List<String>();

        //Then invoke the campaign member updates
        Map<String, Schema.SObjectField> leadMap=Schema.SObjectType.Lead.fields.getMap();
        Map<String,DisplayType> leadTypeMap=new Map<String,DisplayType>(); //this will hold the field type for all the fields in the LeadScoringRule__c

        //gets the field types for each rule, needed for formula's later
        leadTypeMap=leadScoring.getRuleFieldInfo(leadMap, Rules);

        for (Integer i=0;i<Rules.size();i++){
            if(leadTypeMap.containsKey(Rules[i].Field_Name__c)==True){
                fieldNames.add(Rules[i].Field_Name__c);
            } else {
                Rules.remove(i);//remove the rule if that field name isn't a valid field on Lead or Campaign Member
            }//if 1
        }//for 1
        String qrySOQL=leadScoring.getRuleFieldNames(fieldNames);
        qrySOQL='SELECT ' + qrySOQL +'Id,Lead_Score__c FROM Lead WHERE isConverted=FALSE';
        
        if(qryLimit != null && qryLimit > 0){
            qrySOQL = qrySOQL + ' LIMIT ' + qryLimit;
        }
        initLeads.leadQuery=qrySOQL;
        
        Id leadProcessId;
        if(qryLimit != null && qryLimit <= 200) {
            leadProcessId = Database.executeBatch(initLeads, qryLimit);
        } else {
            leadProcessId = Database.executeBatch(initLeads);
        } 
        return leadProcessId;   
    }//autoRunLeads
    
}