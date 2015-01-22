<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Set_User_Active_Date</fullName>
        <description>Set the Active Date on the User object to Today&apos;s date</description>
        <field>Active_Date__c</field>
        <formula>today()</formula>
        <name>Set User Active Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_User_Deactivate_Date</fullName>
        <description>Set the Deactive Date on the User Object to todays date</description>
        <field>Deactivate_Date__c</field>
        <formula>today()</formula>
        <name>Set User Deactivate Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>User set to Active</fullName>
        <actions>
            <name>Set_User_Active_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.IsActive</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>User Active field has been set to true</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>User set to Inactive</fullName>
        <actions>
            <name>Set_User_Deactivate_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.IsActive</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>The Active field on the User object is set to False</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
