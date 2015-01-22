<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Application</fullName>
        <description>Date when Campaign Member status  = &quot;Application&quot;</description>
        <field>Application__c</field>
        <formula>NOW()</formula>
        <name>Application</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Contacted_Call_Back</fullName>
        <description>Date when Campaign Member status  = &quot;Contacted - Requested Call Back&quot;</description>
        <field>Contacted_Call_Back__c</field>
        <formula>NOW()</formula>
        <name>Contacted - Call Back</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Contacted_LM</fullName>
        <description>Date when Campaign Member status  = &quot;Contacted - Left Message&quot;</description>
        <field>Contacted_LM__c</field>
        <formula>NOW()</formula>
        <name>Contacted - LM</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Contacted_Made_Offer</fullName>
        <description>Date when Campaign Member status  = &quot;Contacted - Made Offer&quot;</description>
        <field>Contacted_Made_Offer__c</field>
        <formula>NOW()</formula>
        <name>Contacted - Made Offer</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Does_Not_Qualify</fullName>
        <description>Date when Campaign Member status  = &quot;Does Not Qualify&quot;</description>
        <field>Does_Not_Qualify__c</field>
        <formula>NOW()</formula>
        <name>Does Not Qualify</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Follow_Up</fullName>
        <description>Date when Campaign Member status = &quot;Follow Up&quot;</description>
        <field>Follow_Up__c</field>
        <formula>NOW()</formula>
        <name>Follow Up</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Last_Modified_By</fullName>
        <field>Last_Modified_By__c</field>
        <formula>IF(ISCHANGED(Status), $User.FirstName + &quot; &quot; + $User.LastName, &quot;&quot;)</formula>
        <name>Last Modified By</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Left_Voicemail</fullName>
        <description>Date when Campaign Member status  = &quot;Left Voicemail&quot;</description>
        <field>Left_Voicemail__c</field>
        <formula>NOW()</formula>
        <name>Left Voicemail</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>No_Answer</fullName>
        <description>Date when Campaign Member status  = &quot;No Answer&quot;</description>
        <field>No_Answer__c</field>
        <formula>NOW()</formula>
        <name>No Answer</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Not_Interested</fullName>
        <description>Date when Campaign Member status  = &quot;Not Interested&quot;</description>
        <field>Not_Interested__c</field>
        <formula>NOW()</formula>
        <name>Not Interested</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Wrong_Number</fullName>
        <description>Date when Campaign Member status  = &quot;Wrong Number&quot;</description>
        <field>Wrong_Number__c</field>
        <formula>NOW()</formula>
        <name>Wrong Number</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Last Modified By</fullName>
        <actions>
            <name>Last_Modified_By</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Captures User Name when Campaign Member status changes</description>
        <formula>ISCHANGED(Status)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Status %3D Application</fullName>
        <actions>
            <name>Application</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>CampaignMember.Status</field>
            <operation>equals</operation>
            <value>Application</value>
        </criteriaItems>
        <description>Date when Campaign Member status  = &quot;Application&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Status %3D Contacted - LM</fullName>
        <actions>
            <name>Contacted_LM</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>CampaignMember.Status</field>
            <operation>equals</operation>
            <value>Contacted - LM w/ 3rd Party</value>
        </criteriaItems>
        <description>Date when Campaign Member status  = &quot;Contacted - LM w/ 3rd Party&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Status %3D Contacted - Made Offer</fullName>
        <actions>
            <name>Contacted_Made_Offer</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>CampaignMember.Status</field>
            <operation>equals</operation>
            <value>Contacted - Made Offer</value>
        </criteriaItems>
        <description>Date when Campaign Member status  = &quot;Contacted - Made Offer&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Status %3D Contacted - Requested Call Back</fullName>
        <actions>
            <name>Contacted_Call_Back</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>CampaignMember.Status</field>
            <operation>equals</operation>
            <value>Contacted - Requested Call Back</value>
        </criteriaItems>
        <description>Date when Campaign Member status  = &quot;Contacted - Requested Call Back&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Status %3D Does Not Qualify</fullName>
        <actions>
            <name>Does_Not_Qualify</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>CampaignMember.Status</field>
            <operation>equals</operation>
            <value>Does Not Qualify</value>
        </criteriaItems>
        <description>Date when Campaign Member status  = &quot;Does Not Qualify&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Status %3D Follow Up</fullName>
        <actions>
            <name>Follow_Up</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>CampaignMember.Status</field>
            <operation>equals</operation>
            <value>Follow Up</value>
        </criteriaItems>
        <description>Date when Campaign Member status = &quot;Follow Up&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Status %3D Left Voicemail</fullName>
        <actions>
            <name>Left_Voicemail</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>CampaignMember.Status</field>
            <operation>equals</operation>
            <value>Left Voicemail</value>
        </criteriaItems>
        <description>Date when Campaign Member status  = &quot;Left Voicemail&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Status %3D No Answer</fullName>
        <actions>
            <name>No_Answer</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>CampaignMember.Status</field>
            <operation>equals</operation>
            <value>No Answer</value>
        </criteriaItems>
        <description>Date when Campaign Member status  = &quot;No Answer&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Status %3D Not Interested</fullName>
        <actions>
            <name>Not_Interested</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>CampaignMember.Status</field>
            <operation>equals</operation>
            <value>Not Interested</value>
        </criteriaItems>
        <description>Date when Campaign Member status  = &quot;Not Interested&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Status %3D Wrong Number</fullName>
        <actions>
            <name>Wrong_Number</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>CampaignMember.Status</field>
            <operation>equals</operation>
            <value>Wrong Number</value>
        </criteriaItems>
        <description>Date when Campaign Member status  = &quot;Wrong Number&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
