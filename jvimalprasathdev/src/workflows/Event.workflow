<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Event_Created_Timestamp</fullName>
        <field>created_timestamp__c</field>
        <formula>now()</formula>
        <name>Update Event Created Timestamp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Set Event Created Timestamp</fullName>
        <actions>
            <name>Update_Event_Created_Timestamp</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Event.created_timestamp__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Set event created timestamp to current date and time</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
