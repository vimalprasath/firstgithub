<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Check_Will_This_Be_Joint_Application</fullName>
        <field>Will_this_be_a_joint_application__c</field>
        <literalValue>1</literalValue>
        <name>Check Will This Be Joint Application</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opportunity_Owner_EID_Update</fullName>
        <description>Updates the Opp Owner EID with the EID of the Opp Owner when Opp Owner is changed and when the Opp is created</description>
        <field>Opportunity_Owner_EID__c</field>
        <formula>Owner.EmployeeNumber</formula>
        <name>Opportunity Owner EID Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_ORT_to_HLR</fullName>
        <description>Set Opportunity Record type to &quot;HLR&quot;</description>
        <field>RecordTypeId</field>
        <lookupValue>HLR</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Set ORT to HLR</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_ORT_to_Originations</fullName>
        <description>Set Opportunity Record Type to Originations</description>
        <field>RecordTypeId</field>
        <lookupValue>Originations</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Set ORT to Originations</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Opp_Stage_To_App_Submitted</fullName>
        <description>Setting the Opportunity stage to app submitted</description>
        <field>StageName</field>
        <literalValue>App Submitted</literalValue>
        <name>Set Opp Stage To App Submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Opp_Stage_to_Negotiation</fullName>
        <description>Set Opportunity Stage to Negotiation</description>
        <field>StageName</field>
        <literalValue>Negotiation/Review</literalValue>
        <name>Set Opp Stage to Negotiation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Opp_Stage_to_Proposal</fullName>
        <description>Set Opportunity Stage to &quot;Proposal/Price Quote&quot;</description>
        <field>StageName</field>
        <literalValue>Proposal/Price Quote</literalValue>
        <name>Set Opp Stage to Proposal</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_The_Record_Type_To_In_App</fullName>
        <description>If the OPUS ID is Updated with E number the record type is changed to In 
App</description>
        <field>RecordTypeId</field>
        <lookupValue>In_App</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Set The Record Type To In App</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_The_Stage_To_Lost</fullName>
        <description>Setting the stage to lost</description>
        <field>StageName</field>
        <literalValue>Lost</literalValue>
        <name>Set The Stage To Lost</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_The_Stage_To_Won</fullName>
        <description>Setting the stage to Won</description>
        <field>StageName</field>
        <literalValue>Won</literalValue>
        <name>Set The Stage To Won</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Uncheck_Wiill_This_Be_Joint_Application</fullName>
        <field>Will_this_be_a_joint_application__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck Wiill This Be Joint Application</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Opp_Channel_to_Centralized_Retai</fullName>
        <description>If Opp owner is changed and role name of new owner contains Centralized, Channel = Centralized Retail</description>
        <field>Channel__c</field>
        <literalValue>Centralized Retail</literalValue>
        <name>Update Opp Channel to Centralized Retai</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Opp_Channel_to_Distributed</fullName>
        <description>If Opp owner is changed and role name of new owner contains Distributed, Channel = Distributed Retail</description>
        <field>Channel__c</field>
        <literalValue>Distributed Retail</literalValue>
        <name>Update Opp Channel to Distributed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Opp_Channel_to_Home_Equity</fullName>
        <description>If opp owner is changed and role name of new owner contains Home Equity, Channel = Home Equity</description>
        <field>Channel__c</field>
        <literalValue>Home Equity</literalValue>
        <name>Update Opp Channel to Home Equity</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Opp_Channel_to_Neighborhood_Lend</fullName>
        <description>If opp owner is changed and role name of new owner contains CRA, Channel = Neighborhood Lending</description>
        <field>Channel__c</field>
        <literalValue>Neighborhood Lending</literalValue>
        <name>Update Opp Channel to Neighborhood Lend</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_The_Stage_To_Prospecting</fullName>
        <description>Updating the opportunity stage to prospecting</description>
        <field>StageName</field>
        <literalValue>Prospecting</literalValue>
        <name>Update The Stage To Prospecting</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Change The Record Type To In App</fullName>
        <actions>
            <name>Set_The_Record_Type_To_In_App</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Empower_Lead_ID__c</field>
            <operation>startsWith</operation>
            <value>E</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>notEqual</operation>
            <value>Home Equity</value>
        </criteriaItems>
        <description>If the Opus ID is updated with a E number the record type is changed to In App</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Changing The Opportunity Stage To App Submitted</fullName>
        <actions>
            <name>Set_Opp_Stage_To_App_Submitted</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND (2 OR 3 OR 4 OR 5 OR 6 OR 7 OR 8 OR 9)</booleanFilter>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>In App</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Loan_Status__c</field>
            <operation>contains</operation>
            <value>Final Approval</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Loan_Status__c</field>
            <operation>contains</operation>
            <value>Re-Disclosure</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Loan_Status__c</field>
            <operation>contains</operation>
            <value>Rate not Locked</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Loan_Status__c</field>
            <operation>contains</operation>
            <value>Rate locked but not accepted</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Loan_Status__c</field>
            <operation>contains</operation>
            <value>Conditional Approval</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Loan_Status__c</field>
            <operation>contains</operation>
            <value>Suspended</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Loan_Status__c</field>
            <operation>contains</operation>
            <value>Ready to Close</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Loan_Status__c</field>
            <operation>contains</operation>
            <value>Final-To Be Decisioned</value>
        </criteriaItems>
        <description>Changing the stage in the In App record type depending on the status coming from OPUS</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Changing The Opportunity Stage to Lost</fullName>
        <actions>
            <name>Set_The_Stage_To_Lost</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND (2 OR 3 OR 4)</booleanFilter>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>In App</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Loan_Status__c</field>
            <operation>contains</operation>
            <value>Cancelled</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Loan_Status__c</field>
            <operation>contains</operation>
            <value>Withdrawn by Customer</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Loan_Status__c</field>
            <operation>contains</operation>
            <value>Declined - direct customer to MC</value>
        </criteriaItems>
        <description>Changing the Stage when the status of the opportunity comes back from opus as cancelled/withdrawn by customer/declined</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Changing The Opportunity Stage to Won</fullName>
        <actions>
            <name>Set_The_Stage_To_Won</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>In App</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Loan_Status__c</field>
            <operation>contains</operation>
            <value>Closed/Funded</value>
        </criteriaItems>
        <description>Changing the Stage when the status of the opportunity comes back from opus as closed/funded</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Opportunity Owner EID Update</fullName>
        <actions>
            <name>Opportunity_Owner_EID_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.OwnerId</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Updates the Opportunity Owner EID with the EID of the Opportunity Owner</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Opportunity Stage To Prospecting</fullName>
        <actions>
            <name>Update_The_Stage_To_Prospecting</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>Opportunity.Loan_Status__c</field>
            <operation>contains</operation>
            <value>Unable to Prequalify,Prequal Approved</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Empower_Lead_ID__c</field>
            <operation>startsWith</operation>
            <value>D</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Opportunity Stage to Negotiation</fullName>
        <actions>
            <name>Set_Opp_Stage_to_Negotiation</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Empower_Lead_ID__c</field>
            <operation>startsWith</operation>
            <value>E</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Channel_Sources__c</field>
            <operation>notEqual</operation>
            <value>HE Campaign,HE Other,HE Referral</value>
        </criteriaItems>
        <description>If OPUS ID is update with a &quot;E&quot; number, set the Opportunity Stage to &quot;Negotiation/Review&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Opportunity Stage to Proposal</fullName>
        <actions>
            <name>Set_Opp_Stage_to_Proposal</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Empower_Lead_ID__c</field>
            <operation>startsWith</operation>
            <value>D</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Channel_Sources__c</field>
            <operation>notEqual</operation>
            <value>HE Campaign,HE Other,HE Referral</value>
        </criteriaItems>
        <description>If OPUS ID is update with a &quot;D&quot; number, set the Opportunity Stage to &quot;Proposal/Price Quote&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Joint Application To False</fullName>
        <actions>
            <name>Uncheck_Wiill_This_Be_Joint_Application</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Applicant_Type__c</field>
            <operation>equals</operation>
            <value>Individual</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Joint Application To True</fullName>
        <actions>
            <name>Check_Will_This_Be_Joint_Application</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Applicant_Type__c</field>
            <operation>equals</operation>
            <value>Married Couple,Two Individuals (Not Married),More than Two Individuals</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Opp Channel to Centralized Retail</fullName>
        <actions>
            <name>Update_Opp_Channel_to_Centralized_Retai</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>If Opp Owner is changed and role name of new owner contains Centralized, Channel = Centralized Retail</description>
        <formula>((ISNEW()) || (ISCHANGED( OwnerId ) &amp;&amp; !ISBLANK(TRIM(Owner.Username))))  &amp;&amp; ( !Contains(Owner.UserRole.Name, &quot;Home Equity&quot;) &amp;&amp;  !Contains(Owner.UserRole.Name, &quot;CRA&quot;) &amp;&amp; !Contains(Owner.UserRole.Name, &quot;Distributed&quot;) &amp;&amp; !Contains(Owner.UserRole.Name, &quot;Screener&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Opp Channel to Distributed</fullName>
        <actions>
            <name>Update_Opp_Channel_to_Distributed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>If Opp owner is changed and role name of new owner contains Distributed, Channel = Distributed Retail</description>
        <formula>((ISNEW()) || (ISCHANGED( OwnerId ) &amp;&amp; !ISBLANK(TRIM(Owner.Username))))  &amp;&amp; Contains(Owner.UserRole.Name, &quot;Distributed&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Opp Channel to Home Equity</fullName>
        <actions>
            <name>Update_Opp_Channel_to_Home_Equity</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>If opp owner is changed and role name of new owner contains Home Equity, Channel = Home Equity</description>
        <formula>((ISNEW()) || (ISCHANGED( OwnerId ) &amp;&amp; !ISBLANK(TRIM(Owner.Username)))) &amp;&amp; Contains(Owner.UserRole.Name, &quot;Home Equity&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Opp Channel to Neighborhood Lending</fullName>
        <actions>
            <name>Update_Opp_Channel_to_Neighborhood_Lend</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>If opp owner is changed and role name of new owner contains CRA, Channel = Neighborhood Lending</description>
        <formula>((ISNEW()) || (ISCHANGED( OwnerId ) &amp;&amp; !ISBLANK(TRIM(Owner.Username))))  &amp;&amp; Contains(Owner.UserRole.Name, &quot;CRA&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
