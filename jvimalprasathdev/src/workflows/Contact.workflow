<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Change_to_ActiveContact_RecType</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Active_Contact_Layout</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change to ActiveContact RecType</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_to_InactiveContact_RecType</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Inactive_Contact_Layout</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change to InactiveContact RecType</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
</Workflow>
