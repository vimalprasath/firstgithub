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
global class LeadScoring {
    //Managed packages can't delete global methods, so deprecating them instead
    
    public  static boolean leadScoringClassAlreadyCalled(){
        return null;
    }
    
    public  static void evaluateCMs(Set<Id> leadIds){
    }//evaluateCMs
    
    public static void evaluateCMs2(Set<Id> CampaignMemberIds){
    }//evaluateCMs2
     
    public  static void deletedCMs(Set<Id> campaignMemberIds){
    }//deleteCMs
    
    public static void evaluateLeads(Set<Id> leadIds){
    }//evaluateLeads    
   
    public static void evaluateLeads2(Set<Id> leadIds){
    }//evaluateLeads
    
    public static Boolean evaluateLeadsAlreadyCalled=FALSE;

    public static boolean evaluateLeadsAlreadyCalled(){
        return evaluateLeadsAlreadyCalled;
    }

    //If you are using code to insert Leads's multiple times synchronously in the same class, only the first
    //batch will be scored unless you set this variable to false in between inserts
    //This method exists primarily for my negative test cases to run properly
    public static void setEvaluateLeadsAlreadyCalled(Boolean alreadyCalled){
        evaluateLeadsAlreadyCalled=alreadyCalled;
    }

    private static Boolean evaluateCMsAlreadyCalled=FALSE;

    public static boolean evaluateCMsAlreadyCalled(){
        return evaluateCMsAlreadyCalled;
    }

    //If you are using code to insert CM's multiple times synchronously in the same class, only the first
    //batch will be scored unless you set this variable to false in between inserts
    public static void setEvaluateCMsAlreadyCalled(Boolean alreadyCalled){
        evaluateCMsAlreadyCalled=alreadyCalled;
    }
    public static List<Lead> evaluateLeads(List<Lead> triggerLeads, Boolean batchUpdate){
        Integer i,j;
        Double scoreChange;//safer to define as a double in case anyone tries to change the field's # decimals
        Schema.DescribeFieldResult cmFieldDescribe;
        Map<Id,Double> leadOldScores=new Map<Id,Double>();
        Map<Id,Double> leadNewScores=new Map<Id,Double>();
        Map<Id,Double> leadScores = new Map<Id,Double>();
        String qrySOQL='';
        Integer LeadCount=0;        
        LeadScoringRule__c[] Rules=activeLeadScoringRuleDetails('Lead');
        //only do work if there are active rules
        if (Rules.size()>0){
            //These maps house the field list as well as field types of the fields of Lead
            Map<String, Schema.SObjectField> leadMap=Schema.SObjectType.Lead.fields.getMap();
            Map<String,DisplayType> leadTypeMap=new Map<String,DisplayType>(); //this will hold the field type for all the fields in the LeadScoringRule__c
            
            leadTypeMap=getRuleFieldInfo(leadMap, Rules);//check back here
            List<String> fieldNames=new List<String>();//could change to set to not require "contains key" check; check if sets gack on dupes
            LeadScoringRule__c[] rulesCopy=new List<LeadScoringRule__c>();
            for (i=0;i<Rules.size();i++){
                if(leadTypeMap.containsKey(Rules[i].Field_Name__c)==True){
                    fieldNames.add(Rules[i].Field_Name__c);
                    //this effectively removes bad fieldname rules from the list 
                    rulesCopy.add(Rules[i]);
                }//if 
            }//for 2
            Rules=rulesCopy;
            For (i=0;i<triggerLeads.size();i++){
            //Evaluate criteria here for each lead
                triggerLeads[i].Lead_Score__c=0;
                For(LeadScoringRule__c currentRule:Rules){
                    if (evaluateCriteria(currentRule.Value__c, 
                                         currentRule.Operator__c,
                                         String.ValueOf(triggerLeads.get(i).get(currentRule.Field_Name__c)),
                                         leadTypeMap.get(currentRule.Field_Name__c))){
    
                         triggerLeads[i].Lead_Score__c+=currentRule.Score_change__c;
                    }//if 4
                }//for 3
            }//for 2
           
            If(batchUpdate==TRUE){
                try{
                    evaluateLeadsAlreadyCalled=FALSE;
                    Database.update(triggerLeads,false);                    
                } catch (Exception e){
    //            system.debug('Leads were not updated: '+e);
                }//catch
            }//if 2
            evaluateLeadsAlreadyCalled=TRUE;
        }//if 1
        return triggerLeads;
    }//evaluateLeads
    
    //this method is called from the trigger.  It's an asynch method so the trigger call has high governor limits
    public static void evaluateCMs(List<CampaignMember> triggerCMs){
        Integer i,j;
        Double scoreChange = 0;//safer to define as a double in case anyone tries to change the field's # decimals
        String cmFieldValue;
        String ruleFieldValue;
        Schema.DescribeFieldResult cmFieldDescribe;
        DisplayType cmFieldType;
        Set<Id> leadIDs=new Set<Id>();        
        Map<Id,Double> cmOldScores=new Map<Id,Double>();
        Map<Id,Double> cmNewScores=new Map<Id,Double>();
        Map<Id,Double> leadScores = new Map<Id,Double>();
        Set<String> RuleFieldNames=new Set<String>();
        String qrySOQL;
        List<CampaignMember> cms=new List<CampaignMember>();//Stores a list of the campaign members from this trigger along with all fields needed for evaluating criteria
        List<CampaignMember> cmsToUpdate=new List<CampaignMember>();//Stores a list of the campaign members to be updated.
        Integer CMCount=0;
        
        //Get all of the lead rules & store them
        LeadScoringRule__c[] Rules=activeLeadScoringRuleDetails('Campaign Member');
        //only do work if there are active rules
        if (Rules.size()>0){
            //these maps house the field list as well as field types of the fields of CampaignMember
            Map<String, Schema.SObjectField> cmMap=Schema.SObjectType.CampaignMember.fields.getMap();
            Map<String,DisplayType> cmTypeMap=new Map<String,DisplayType>(); //this will hold the field type for all the fields in the LeadScoringRule__c
    
            //gets the field types for each rule, needed for formula's later
            cmTypeMap=getRuleFieldInfo(cmMap, Rules);
            List<String> fieldNames=new List<String>();
            for (i=0;i<Rules.size();i++){
                if(cmTypeMap.containsKey(Rules[i].Field_Name__c)==True){
                    fieldNames.add(Rules[i].Field_Name__c);
                } else {
                    Rules.remove(i);//remove the rule if that field name isn't a valid field on Lead or Campaign Member
                }//if 
            }//for
            qrySOQL=getRuleFieldNames(fieldNames);
            qrySOQL='SELECT ' + qrySOQL +'Id,Campaign_Score__c,LeadId,CampaignId,ContactId FROM CampaignMember WHERE Id IN : triggerCMs';
            //adding this line to account for double scoring when a workflow updates a campaign member, which doubles the score.
            //This should lock the row (and hoepfully not throw an error)
            qrySOQL+=' FOR UPDATE';
    
            cms=Database.query(qrySOQL);

            //Now need to create a loop of the rules to get the CMs in each rule, then loop through the CM's and update ScoreChange for that CM            
            for (i=0;i<cms.size();i++){
                //Evaluate criteria here for each Campaign Member
                //Only evaluate members for leads
                if(cms[i].LeadId == null) continue;
                
                cms[i].Campaign_Score__c=0;
//              system.debug('num rules: '+rules.size());
//              system.debug('Campaign Score before: '+triggerCMs[i].Campaign_Score__c);
    
                for(LeadScoringRule__c currentRule:Rules){
                    //default it in case the campaign isn't found
                    if (!(currentRule.Campaign__c!=null&&(currentRule.Campaign__c!=cms[i].CampaignId))){//if 1
                        //if metCriteria==True, then add this score to ScoreChange    
                        if (evaluateCriteria(currentRule.Value__c, 
                                             currentRule.Operator__c,
                                             String.valueOf(cms.get(i).get(currentRule.Field_Name__c)), 
                                             cmTypeMap.get(currentRule.Field_Name__c))==TRUE){//if 2
                            system.debug('Score Change value is: '+currentRule.Score_change__c);
                            cms[i].Campaign_Score__c+=currentRule.Score_change__c;
                            system.debug('Campaign Score value is: '+cms[i].Campaign_Score__c);
                            
                        }//if 2 
                    }//if 1
                }//for 2

//Clean Up Below
//Clean Up Below
//Clean Up Below
//Clean Up Below
//Clean Up Below
//Clean Up Below
//Clean Up Below
//Clean Up Below
    
                //if that lead already has a score, increment it instead of overwriting it
                if (leadScores.containsKey(cms[i].LeadId)){    
                    scoreChange+=leadScores.get(cms[i].LeadId);
                    Double removedScore=leadScores.remove(cms[i].LeadId);//remove it so we can readd it with the incremented value
                }//if 1    
                leadScores.put(cms[i].LeadId,cms[i].Campaign_Score__c);                    
                
                cmNewScores.put(cms[i].Id,cms[i].Campaign_Score__c);  //this stores the campaign score for this campaign member, for tracking if the CM is updated or deleted
                leadIDs.add(cms[i].LeadId);
    //            system.debug('CM Count Successfully Processed: '+cmCount++ + ' with Script statement count at: '+limits.getScriptStatements());               
                cmsToUpdate.add(cms[i]);            
            }//for 1   
    
            //Now update the leads & campaign members with the new scores!  Note this fires all platform features for leads (workflow, triggers, validation rules)
            evaluateCMsAlreadyCalled=TRUE;
            
            if(cmsToUpdate.size() > 0) {          
                updateCMs (cms);
            }
            if(leadIDs.size() > 0) {
                //CCWS updateLeads (leadIDs,leadScores);
                updateLeads (leadIDs);              
            } 
        }//if
    }//evaluateCMs2

    public static void updateLeads (Set<Id> leadIDs) {
        Map<Id,Lead> leadMap = new Map<Id,Lead>();
        for (Id eachLeadId : leadIDs) {
            Lead l = new Lead(Id = eachLeadId);
            l.Campaign_Score__c = 0;
            leadMap.put(l.Id,l);
        }//if
        
        AggregateResult[] groupedResults = [SELECT LeadId, SUM(Campaign_Score__c) sumScore
                                                FROM CampaignMember
                                                WHERE LeadId IN :leadIDs
                                                GROUP BY LeadId];
                                                                    
        for (AggregateResult ar : groupedResults) {
            Id leadId = (ID)ar.get('LeadId');
            if(leadMap.containsKey(leadId)) {
                leadMap.get(leadId).Campaign_Score__c = (Decimal)ar.get('sumScore');
            }//if
        }//for

        try{
            //This method only fails the problem records, not the whole batch
            Database.update(leadMap.values(),false);
        } catch (DMLException e) {
//btw-this only populates if the whole batch fails miserably
//           System.debug('Leads were not all updated properly: ' + e);
        }//try
    }//updateLeads

    public static void updateLeads (Set<ID> leadIDs,Map<Id,Double> leadScores){
        List<Lead> leads=[SELECT Id, Lead_Score__c,Campaign_Score__c  FROM Lead WHERE Id IN :leadIDs AND IsConverted = FALSE];
        //Loop through the leads & add the campaign score to each lead
        For (Lead eachLead : leads){
          //handle null values by replacing them with zero
            if (eachLead.Campaign_Score__c==null){//if 2
                eachLead.Campaign_Score__c=0;
            }//if 
                
            eachLead.Campaign_Score__c+=leadScores.get(eachLead.ID);
        }//for
        
        //finally, update the leads!  Note this will trigger lead workflow rules, triggers, etc
        Try{
            Database.update(leads,false);
        } catch (DMLException e) {
//            system.debug('Leads were not all updated properly: ' + e);
        }//try
    }//updateLeads
    
    public static String getRuleFieldNames(List<String> fieldNames){
        String ruleFieldNameString='';
        Set<String> ruleFieldNames=new Set<String>();
        
        //Loop through the rules & get the field names possibly needed for criteria verification
        for (String fieldName:fieldNames){
            system.debug('Field added :'+fieldName);
            if (ruleFieldNames.contains(fieldName.toLowerCase())==False){//note that a set.Contains() doesn't match "Email" and "email"
                ruleFieldNames.add(fieldName.toLowerCase());
                ruleFieldNameString+=fieldName+',';
            }//if
        }//for
        return ruleFieldNameString;
    }//getRuleFieldNames;
    
     public static void updateCMs (CampaignMember[] cms){
        Try{
            Database.update(cms,false);
        } catch (DMLException e) {
//            system.debug('Campaign Members were not all updated properly: ' + e);
        }//try
    }//updatecms

    public static void deletedCMs(List<CampaignMember> campaignMembers){
        Set<Id> leadIDs=new Set<Id>();        
        Map<Id,Double> leadScores = new Map<Id,Double>();
        List<CampaignMember> cms=[SELECT Id, LeadId, Campaign_Score__c FROM CampaignMember WHERE Id IN: campaignMembers];
        for (CampaignMember eachCM: cms){
            if(eachCM.Campaign_Score__c!=0 &&eachCM.Campaign_Score__c!=null){                
                if(leadIds.contains(eachCM.LeadId)==FALSE){
                    leadIDs.add(eachCM.LeadId);
                    leadScores.put(eachCM.LeadId,-eachCM.Campaign_Score__c);
//system.debug('Score to be removed from the lead is: '+leadScores.get(eachCM.LeadId));                 
                }else{
                    Double scoreChange=leadScores.get(eachCM.LeadId);
                    leadScores.put(eachCM.LeadId, -scoreChange-eachCM.Campaign_Score__c);
                }//if 2
                
            }//if 1
        }//for    
        updateLeads (leadIDs,leadScores);
    }//deleteCMs
    
    public static LeadScoringRule__c[] activeLeadScoringRuleDetails(String ruleType){
        //Once all the active rules criteria are saved, return them as a list to wherever they were called from        
        return [Select Name, Campaign__c, Field_Name__c, Operator__c, Value__c, Score_Change__c FROM LeadScoringRule__c WHERE Active__c=TRUE AND Type__c=:ruleType];
    }
      
    public static Boolean evaluateCriteria(String ruleFieldValue, String operator, String recordFieldValue, DisplayType ruleFieldType){
                  
        Boolean metCriteria=false;
            if (operator=='equals'){//if 1
                if (recordFieldValue!=null&&(ruleFieldType==Schema.DisplayType.STRING || ruleFieldType==Schema.DisplayType.ComboBox ||ruleFieldType==Schema.DisplayType.Picklist ||ruleFieldType==Schema.DisplayType.email||ruleFieldType==Schema.DisplayType.encryptedString||ruleFieldType==Schema.DisplayType.Phone||ruleFieldType==Schema.DisplayType.url)){
                        metCriteria=(ruleFieldValue.equalsIgnoreCase(recordFieldValue));
                } else if (ruleFieldType==Schema.DisplayType.BOOLEAN){//if 2
                        metCriteria=(recordFieldValue.toLowerCase()==ruleFieldValue.toLowerCase());
                } else if (recordFieldValue!=null&&(ruleFieldType==Schema.DisplayType.Double||ruleFieldType==Schema.DisplayType.Currency||ruleFieldType==Schema.DisplayType.Percent ||ruleFieldType==Schema.DisplayType.Integer)){
                        metCriteria=(decimal.valueOf(recordFieldValue)==decimal.valueOf(ruleFieldValue));
                }//if 2                
            }else if (operator=='not equal to'){//if 1
                if (ruleFieldType==Schema.DisplayType.BOOLEAN){//if 2
                        metCriteria=!(ruleFieldValue.equalsIgnoreCase(recordFieldValue));
                } else if (recordFieldValue!=null&&(ruleFieldType==Schema.DisplayType.Double||ruleFieldType==Schema.DisplayType.Currency||ruleFieldType==Schema.DisplayType.Percent ||ruleFieldType==Schema.DisplayType.Integer)){
                        metCriteria=(decimal.valueOf(recordFieldValue)!=decimal.valueOf(ruleFieldValue));
                } else if (recordFieldValue!=null&&(ruleFieldType==Schema.DisplayType.STRING || ruleFieldType==Schema.DisplayType.ComboBox ||ruleFieldType==Schema.DisplayType.Picklist ||ruleFieldType==Schema.DisplayType.email||ruleFieldType==Schema.DisplayType.encryptedString||ruleFieldType==Schema.DisplayType.Phone||ruleFieldType==Schema.DisplayType.url)){
                        metCriteria=(recordFieldValue.toLowerCase()!=ruleFieldValue.toLowerCase());
                }//if 2                
           } else if (operator=='greater than'){//if 1
                if (recordFieldValue!=null&&(ruleFieldType==Schema.DisplayType.STRING || ruleFieldType==Schema.DisplayType.ComboBox ||ruleFieldType==Schema.DisplayType.Picklist ||ruleFieldType==Schema.DisplayType.email||ruleFieldType==Schema.DisplayType.encryptedString||ruleFieldType==Schema.DisplayType.Phone||ruleFieldType==Schema.DisplayType.url)){
                        metCriteria=(recordFieldValue.toLowerCase()>ruleFieldValue.toLowerCase());
                } else if (recordFieldValue!=null&&(ruleFieldType==Schema.DisplayType.Double||ruleFieldType==Schema.DisplayType.Currency||ruleFieldType==Schema.DisplayType.Percent ||ruleFieldType==Schema.DisplayType.Integer)){
                        metCriteria=(decimal.valueOf(recordFieldValue)>decimal.valueOf(ruleFieldValue));
                }//if 2  
           } else if (operator=='less than'){//if 1
                if (recordFieldValue!=null&&(ruleFieldType==Schema.DisplayType.STRING || ruleFieldType==Schema.DisplayType.ComboBox ||ruleFieldType==Schema.DisplayType.Picklist ||ruleFieldType==Schema.DisplayType.email||ruleFieldType==Schema.DisplayType.encryptedString||ruleFieldType==Schema.DisplayType.Phone||ruleFieldType==Schema.DisplayType.url)){
                        metCriteria=(recordFieldValue.toLowerCase()<ruleFieldValue.toLowerCase());
                } else if (recordFieldValue!=null&&(ruleFieldType==Schema.DisplayType.Double||ruleFieldType==Schema.DisplayType.Currency||ruleFieldType==Schema.DisplayType.Percent ||ruleFieldType==Schema.DisplayType.Integer)){
                        metCriteria=(decimal.valueOf(recordFieldValue)<decimal.valueOf(ruleFieldValue));
                }//if 2  
           } else if (operator=='greater or equal'){//if 1
                if (recordFieldValue!=null&&(ruleFieldType==Schema.DisplayType.STRING || ruleFieldType==Schema.DisplayType.ComboBox ||ruleFieldType==Schema.DisplayType.Picklist ||ruleFieldType==Schema.DisplayType.email||ruleFieldType==Schema.DisplayType.encryptedString||ruleFieldType==Schema.DisplayType.Phone||ruleFieldType==Schema.DisplayType.url)){
                        metCriteria=(recordFieldValue.toLowerCase()>=ruleFieldValue.toLowerCase());
                } else if (recordFieldValue!=null&&(ruleFieldType==Schema.DisplayType.Double||ruleFieldType==Schema.DisplayType.Currency||ruleFieldType==Schema.DisplayType.Percent ||ruleFieldType==Schema.DisplayType.Integer)){
                        metCriteria=(decimal.valueOf(recordFieldValue)>=decimal.valueOf(ruleFieldValue));
                }//if 2  
           }else if (operator=='less or equal'){//if 1
                if (recordFieldValue!=null&&(ruleFieldType==Schema.DisplayType.STRING || ruleFieldType==Schema.DisplayType.ComboBox ||ruleFieldType==Schema.DisplayType.Picklist ||ruleFieldType==Schema.DisplayType.email||ruleFieldType==Schema.DisplayType.encryptedString||ruleFieldType==Schema.DisplayType.Phone||ruleFieldType==Schema.DisplayType.url)){
                        metCriteria=(recordFieldValue.toLowerCase()<=ruleFieldValue.toLowerCase());
                } else if (recordFieldValue!=null&&(ruleFieldType==Schema.DisplayType.Double||ruleFieldType==Schema.DisplayType.Currency||ruleFieldType==Schema.DisplayType.Percent ||ruleFieldType==Schema.DisplayType.Integer)){
                        metCriteria=(decimal.valueOf(recordFieldValue)<=decimal.valueOf(ruleFieldValue));
                }//if 2  
             }else if (operator=='contains'){//if 1
                    if(recordFieldValue!=null){//if 3;  Checks for null values to avoid null pointer exception for blank lead or cm values
                        metCriteria=recordFieldValue.toLowerCase().contains(ruleFieldValue.toLowerCase());
                    }//if 3    
             }else if (operator=='does not contain'){//if 1
                    if(recordFieldValue!=null){//if 3;  Checks for null values to avoid null pointer exception for blank lead or cm values
                            metCriteria=!recordFieldValue.toLowerCase().contains(ruleFieldValue.toLowerCase());
                    }//if 3    
             }else if (operator=='starts with'){//if 1
            //took out the DisplayType check with the assumption that the controller code only allows string types to use Starts With
                if(recordFieldValue!=null){//if 3;  Checks for null values to avoid null pointer exception for blank lead or cm values
                    metCriteria=recordFieldValue.startsWith(ruleFieldValue);
                }//if 2 
           }//if 1        
        return metCriteria;
    }
    
    //this gets the field type for each LeadScoringRule__c.  The type is needed for comparison later    
    public static Map<String,DisplayType> getRuleFieldInfo(Map<String, Schema.SObjectField> objectMap, LeadScoringRule__c[] Rules){
        Set<String> RuleFieldNames=new Set<String>();
        Map<String,DisplayType> fieldTypeMap=new Map<String,DisplayType>();
        
        for (LeadScoringRule__c rule:Rules){
            if (RuleFieldNames.contains(rule.Field_Name__c)==FALSE){
                RuleFieldNames.add(rule.Field_Name__c);
                try{    //try to get the field type for this field for casting the object later.  
                        //This will fail if the rule.Field_Name__c doesn't match the API name for a field in CampaignMember
                    Schema.SObjectField fieldToken=objectMap.get(rule.Field_Name__c);
                    fieldTypeMap.put(rule.Field_Name__c,fieldToken.getDescribe().getType());
                } catch (Exception e){
//                    system.debug('The field name in this customers rule is likely invalid: '+ rule.Field_Name__c);
//                    system.debug('Error when trying to get the type of this field: '+ e);
                }//try    
            }//if
        }//for    
        
        return fieldTypeMap;
    }//getRuleFieldInfo
    
    
}//class