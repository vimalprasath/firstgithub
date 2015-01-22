<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>OPUS_ID_Update_Lead</fullName>
        <field>Empower_Lead_ID__c</field>
        <formula>Lead__r.Related_Opportunity__r.Empower_Lead_ID__c</formula>
        <name>OPUS ID Update-Lead</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OPUS_ID_Update_Opportunity</fullName>
        <field>Empower_Lead_ID__c</field>
        <formula>Related_Opportunity__r.Empower_Lead_ID__c</formula>
        <name>OPUS ID Update-Opportunity</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Page_layout_change</fullName>
        <field>RecordTypeId</field>
        <lookupValue>RB_Portal</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Page layout change</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>OPUS ID Update-lead</fullName>
        <actions>
            <name>OPUS_ID_Update_Opportunity</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>Related_Opportunity__c != null</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>OPUS ID-Opportunity</fullName>
        <actions>
            <name>OPUS_ID_Update_Lead</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>Related_Opportunity__c = null</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
