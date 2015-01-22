<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>CR1_MC_Intro_Non_RB_Lead</fullName>
        <description>CR1 – MC Intro Non -RB Lead</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Intro_Mail/MC_Intro_Bank_Non_Bank_Lead_2</template>
    </alerts>
    <alerts>
        <fullName>CR1_MC_Intro_RB_Lead_Send_Email</fullName>
        <description>CR1 – MC Intro RB Lead</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderAddress>jvimalprasath@gmail.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Intro_Mail/MC_Intro_RB_Lead_to_MC</template>
    </alerts>
    <alerts>
        <fullName>Internal_referral_Alert</fullName>
        <ccEmails>jvimalprasath@gmail.com</ccEmails>
        <description>Internal referral Alert</description>
        <protected>false</protected>
        <senderAddress>jvimalprasath@gmail.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/WTL_MSA_Advice_1</template>
    </alerts>
    <alerts>
        <fullName>Lead_Assigned_to_Web_Purchase</fullName>
        <description>Lead Assigned to Web Purchase</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderAddress>jvimalprasath@gmail.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/LAF_CustomerEmail_LOWFICO_Template</template>
    </alerts>
    <alerts>
        <fullName>MC_Email</fullName>
        <description>MC Email</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>jvimalprasath@gmail.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/WTL_MSA_Advice_1</template>
    </alerts>
    <alerts>
        <fullName>Send_email_to_MC_On_Lead_Assigment</fullName>
        <description>Send email to MC On Lead Assigment</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>jvimalprasath@gmail.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/WTL_MSA_Advice_1</template>
    </alerts>
    <alerts>
        <fullName>Send_email_to_MSA_when_lead_comes_into_queue_from_webtolead_Direct</fullName>
        <ccEmails>OutboundCoach@ingdirect.com</ccEmails>
        <description>Send email to MSA when lead comes into queue from webtolead Direct</description>
        <protected>false</protected>
        <senderAddress>jvimalprasath@gmail.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/WTL_MSA_Advice_1</template>
    </alerts>
    <alerts>
        <fullName>Send_email_to_MSA_when_lead_comes_into_queue_from_webtolead_form1</fullName>
        <ccEmails>jvimalprasath@gmail.com</ccEmails>
        <description>Send email to MSA when lead comes into queue from webtolead form1</description>
        <protected>false</protected>
        <senderAddress>jvimalprasath@gmail.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/WTL_MSA_Advice_1</template>
    </alerts>
    <alerts>
        <fullName>WTL_Customer_Email_Centralized</fullName>
        <description>WTL-Customer Email - Centralized</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Intro_Mail/WTL_Client_Advice_Centralized</template>
    </alerts>
    <alerts>
        <fullName>WTL_MC_Email</fullName>
        <description>WTL-MC Email</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>jvimalprasath@gmail.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/WTL_MSA_Advice_1</template>
    </alerts>
    <alerts>
        <fullName>WTL_MSA_Advice</fullName>
        <description>WTL-MSA Advice</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>jvimalprasath@gmail.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/WTL_MSA_Advice_1</template>
    </alerts>
    <alerts>
        <fullName>WTL_MSA_Email_Notification_2</fullName>
        <ccEmails>outboundcoach@ingdirect.com</ccEmails>
        <description>WTL MSA Email Notification 2</description>
        <protected>false</protected>
        <senderAddress>jvimalprasath@gmail.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/WTL_MSA_Advice_1</template>
    </alerts>
    <alerts>
        <fullName>WTL_MSA_Email_Notification_3</fullName>
        <ccEmails>jvimalprasath@gmail.com</ccEmails>
        <description>WTL MSA Email Notification 3</description>
        <protected>false</protected>
        <senderAddress>jvimalprasath@gmail.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/WTL_MSA_Advice_1</template>
    </alerts>
    <fieldUpdates>
        <fullName>Active_Timestamp</fullName>
        <description>Triggers the Active Timestamp Field to Update</description>
        <field>Active_Timestamp__c</field>
        <formula>IF(ISNULL(PRIORVALUE(Active_Timestamp__c)),NOW(),PRIORVALUE(Active_Timestamp__c))</formula>
        <name>Active Timestamp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Auto_Populate_Lead_Company_Field</fullName>
        <field>Company</field>
        <formula>&apos;N/A&apos;</formula>
        <name>Auto Populate Lead Company Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CO_Clear_SendEmaiRBportal_checkbox</fullName>
        <field>Send_Email_RB_Portal__c</field>
        <literalValue>0</literalValue>
        <name>CO_Clear_SendEmaiRBportal_checkbox</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Borrowers_APT_Property</fullName>
        <description>Copying Borrowers Apt# To Property Apt#</description>
        <field>Property_Apt__c</field>
        <formula>Borrowers_Apt__c</formula>
        <name>Copy Borrowers APT# Property</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Borrowers_Address_1_Co_Borrower</fullName>
        <description>Copying Borrowers Address 1 to Co-Borrowers Address 1</description>
        <field>Co_Borrowers_Address_1__c</field>
        <formula>Borrowers_Address_1__c</formula>
        <name>Copy Borrowers Address 1 Co Borrower</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Borrowers_Address_2_Co_Borrower</fullName>
        <description>Copying Borrowers Address 1 to Co-Borrowers Address 2</description>
        <field>Co_Borrowers_Address_2__c</field>
        <formula>Borrowers_Address_2__c</formula>
        <name>Copy Borrowers Address 2 Co Borrower</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Borrowers_Address_2_Property</fullName>
        <description>Copying Borrowers Address 1 To Property Address 2</description>
        <field>Property_Address_2__c</field>
        <formula>Borrowers_Address_2__c</formula>
        <name>Copy Borrowers Address 2 Property</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Borrowers_Address_Property</fullName>
        <description>Copying Borrowers Address 1 to Property Address 1</description>
        <field>Property_Address_1__c</field>
        <formula>Borrowers_Address_1__c</formula>
        <name>Copy Borrowers Address 1 Property</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Borrowers_Apt_Co_Borrower</fullName>
        <description>Copying Borrowers Apt# 1 to Co-Borrowers Apt#</description>
        <field>Co_Borrowers_Apt__c</field>
        <formula>Borrowers_Apt__c</formula>
        <name>Copy Borrowers Apt # Co Borrower</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Borrowers_City_Co_Borrower</fullName>
        <description>Copying Borrowers City To Co-Borrowers City</description>
        <field>Co_Borrowers_City__c</field>
        <formula>Borrowers_City__c</formula>
        <name>Copy Borrowers City Co Borrower</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Borrowers_City_Property</fullName>
        <description>Copying Borrowers City To Property City</description>
        <field>Property_City__c</field>
        <formula>Borrowers_City__c</formula>
        <name>Copy Borrowers City Property</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Borrowers_Country_Co_Borrower</fullName>
        <description>Copying Borrowers Country To Co-Borrowers Country</description>
        <field>Co_Borrowers_Country__c</field>
        <formula>Borrowers_Country__c</formula>
        <name>Copy Borrowers Country Co Borrower</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Borrowers_Country_Property</fullName>
        <description>Copying Borrowers Country To Property Country</description>
        <field>Property_Country__c</field>
        <formula>Borrowers_Country__c</formula>
        <name>Copy Borrowers Country Property</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Borrowers_County_Co_Borrower</fullName>
        <description>Copying Borrowers County To Co-Borowers County</description>
        <field>Co_Borrowers_County__c</field>
        <formula>Borrowers_County__c</formula>
        <name>Copy Borrowers County Co Borrower</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Borrowers_County_Property</fullName>
        <description>Copying Borrowers County To Property County</description>
        <field>Property_County__c</field>
        <formula>Borrowers_County__c</formula>
        <name>Copy Borrowers County Property</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Borrowers_Home_Phone_Number</fullName>
        <description>Copying Borrowers Home Phone To Co-Borrowers Home Phone</description>
        <field>Co_Borrowers_Home_Phone__c</field>
        <formula>Borrowers_Home_Phone__c</formula>
        <name>Copy Borrowers Home Phone Number</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Borrowers_House_Co_Borrower</fullName>
        <description>Copying Borrowers House# To Co-Borrowers House #</description>
        <field>Co_Borrowers_House__c</field>
        <formula>BorrowersHouse__c</formula>
        <name>Copy Borrowers House # Co-Borrower</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Borrowers_House_Property</fullName>
        <description>Copying Borrowers House # To Property House #</description>
        <field>Property_House__c</field>
        <formula>BorrowersHouse__c</formula>
        <name>Copy Borrowers House # Property</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Borrowers_State_Co_Borrower</fullName>
        <description>Copying Borrowers State To Co-Borrowers Sate</description>
        <field>Co_Borrowers_State__c</field>
        <formula>Borrowers_State__c</formula>
        <name>Copy Borrowers State Co Borrower</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Borrowers_State_Property</fullName>
        <description>Copying Borrowers State To Property State</description>
        <field>Property_State__c</field>
        <formula>Borrowers_State__c</formula>
        <name>Copy Borrowers State Property</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Borrowers_Zip_Code_Co_Borrower</fullName>
        <description>Copying Borrower Zip/Postal Code To Co-Borrowers Zip/Postal Code</description>
        <field>Co_Borrowers_Zip_Postal_Code__c</field>
        <formula>Borrowers_Zip_Postal_Code__c</formula>
        <name>Copy Borrowers Zip Code Co Borrower</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Borrowers_Zip_Code_Property</fullName>
        <description>Copying Borrowers Zip/Postal Code To Property Zip/Postal Code</description>
        <field>Property_Zip_Postal_Code__c</field>
        <formula>Borrowers_Zip_Postal_Code__c</formula>
        <name>Copy Borrowers Zip Code Property</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>HLR_Flag_Down</fullName>
        <field>HLR_Flag__c</field>
        <formula>&quot;0&quot;</formula>
        <name>HLR Flag Down</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>HLR_Flag_Update</fullName>
        <field>HLR_Flag__c</field>
        <formula>&quot;1&quot;</formula>
        <name>HLR Flag Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Joint_Application_Flag_Off</fullName>
        <description>turn of the Joint Application Flag (will_this_be_a_joint_application__c)</description>
        <field>Will_this_be_a_joint_application__c</field>
        <literalValue>0</literalValue>
        <name>Joint Application Flag Off</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Joint_Application_Flag_On</fullName>
        <description>set the joint application flag (will_this_be_a_joint_application__c) to true</description>
        <field>Will_this_be_a_joint_application__c</field>
        <literalValue>1</literalValue>
        <name>Joint Application Flag On</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead_Owner_EID_Update</fullName>
        <description>Updates the Lead Owner EID with the EID of the Lead Owner when Lead Owner is changed and when the lead is created</description>
        <field>Lead_Owner_EID__c</field>
        <formula>Owner:User.EmployeeNumber</formula>
        <name>Lead Owner EID Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead_Stage_to_Attempting</fullName>
        <description>Lead Stage value will be updated to &quot;Attempting&quot;</description>
        <field>Lead_Stage__c</field>
        <literalValue>Attempting</literalValue>
        <name>Lead Stage to Attempting</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead_Stage_to_New</fullName>
        <description>Lead Stage field value will be updated to &quot;New&quot;</description>
        <field>Lead_Stage__c</field>
        <literalValue>New</literalValue>
        <name>Lead Stage to New</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead_stage_to_Lost</fullName>
        <description>Lead Stage field is updated to &quot;Lost&quot; value</description>
        <field>Lead_Stage__c</field>
        <literalValue>Lost</literalValue>
        <name>Lead stage to Lost</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead_status_Attempt_1_No_Contact</fullName>
        <description>Set lead status to Attempt 1 - No Contact when loan is added to Web - Purchase queue</description>
        <field>Status</field>
        <literalValue>Attempt 1 - No Contact</literalValue>
        <name>Lead status - Attempt 1 - No Contact</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Loan_Amount</fullName>
        <description>Zillow field Loan Amount into the “Requested_Loan_Amount__c” field</description>
        <field>Requested_Loan_Amount__c</field>
        <formula>Requested_Loan_Amount__c</formula>
        <name>Loan Amount</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Loan_Update_Date</fullName>
        <field>Loan_Update_Date__c</field>
        <formula>NOW()</formula>
        <name>Loan_Update_Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Phone_Update</fullName>
        <description>Shows the Phone #</description>
        <field>Borrowers_Home_Phone__c</field>
        <formula>Phone</formula>
        <name>Phone Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Purchase_Price</fullName>
        <description>Zillow field Purchase Price into the “Original Purchase Price” field.</description>
        <field>Original_Purchase_Price__c</field>
        <formula>Original_Purchase_Price__c</formula>
        <name>Purchase Price</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Lead_Record_Type_to_HLR</fullName>
        <description>Set Lead Record Type to HLR</description>
        <field>RecordTypeId</field>
        <lookupValue>HLR</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Set Lead Record Type to HLR</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Lead_Record_Type_to_Home_Equity</fullName>
        <description>Change the Lead Record type to Home Equity</description>
        <field>RecordTypeId</field>
        <lookupValue>Home_Equity</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Set Lead Record Type to Home Equity</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Lead_Record_Type_to_Prequal</fullName>
        <description>Change the Lead Record Type to Prequal</description>
        <field>RecordTypeId</field>
        <lookupValue>Prequal</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Set Lead Record Type to Prequal</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Lead_Record_Type_to_Unassigned</fullName>
        <description>Set Lead Record Type to Unassigned</description>
        <field>RecordTypeId</field>
        <lookupValue>Unassigned</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Set Lead Record Type to Unassigned</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Lead_Status_to_No_Attempts</fullName>
        <description>Set Lead Status to &quot;No Attempts&quot;</description>
        <field>Status</field>
        <literalValue>No Attempts</literalValue>
        <name>Set Lead Status to No Attempts</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_The_Lead_Record_Type_To_Web</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Web</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Set The Lead Record Type To Web</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Uncheck_Copy_Borrowers_Address</fullName>
        <description>Copy Borrowers Address Will Be Unchecked  Once the Borrowers Address Gets Copied to the Co-Borowers Address</description>
        <field>Copy_Borrower_Current_Address__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck Copy Borrowers Address</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Uncheck_Copy_Borrowers_Current_Address_1</fullName>
        <description>Copy Borrowers Current Address 1 Will Be Unchecked Once The Borrower Address Gets Copied to Property Address</description>
        <field>Copy_Borrower_Current_Address_to_Subject__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck Copy Borrowers Current Address 1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Uncheck_Copy_Borrowers_Home_Phone</fullName>
        <description>Copy Borrowers Home Phone Will Be Unchecked Once The Borrowers Home Phone Is Copied To Co-Borrowers Home Phone</description>
        <field>Copy_Borrowers_Home_Phone__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck Copy Borrowers Home Phone</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdateClosingdate</fullName>
        <description>UpdatingClosingdate</description>
        <field>Closing_Date__c</field>
        <formula>Today()+30</formula>
        <name>UpdateClosingdate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdateNew2Active</fullName>
        <field>New_to_Active__c</field>
        <literalValue>1</literalValue>
        <name>UpdateNew2Active</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Is_SofiLead_to_false</fullName>
        <field>Is_Sofi_Lead__c</field>
        <literalValue>0</literalValue>
        <name>Update Is_SofiLead to false</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Lead_Channel_to_Centralized_Retai</fullName>
        <description>If lead owner is changed and role name of new owner contains Centralized, Channel = Centralized Retail</description>
        <field>Channel__c</field>
        <literalValue>Centralized Retail</literalValue>
        <name>Update Lead Channel to Centralized Retai</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Lead_Channel_to_Distributed</fullName>
        <description>If lead owner is changed and role name of new owner contains Distributed, Channel = Distributed Retail</description>
        <field>Channel__c</field>
        <literalValue>Distributed Retail</literalValue>
        <name>Update Lead Channel to Distributed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Lead_Channel_to_Home_Equity</fullName>
        <description>If lead owner is changed and role name of new owner contains Home Equity, Channel = Home Equity</description>
        <field>Channel__c</field>
        <literalValue>Home Equity</literalValue>
        <name>Update Lead Channel to Home Equity</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Lead_Channel_to_Neighborhood_Lend</fullName>
        <description>If lead owner is changed and role name of new owner contains CRA, Channel = Neighborhood Lending</description>
        <field>Channel__c</field>
        <literalValue>Neighborhood Lending</literalValue>
        <name>Update Lead Channel to Neighborhood Lend</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Lead_Owner_Queue_name</fullName>
        <field>Lead_Owner_Queue__c</field>
        <formula>Owner:Queue.QueueName</formula>
        <name>Update Lead Owner Queue name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_MC_Intro_Non_RB_Lead_Field</fullName>
        <field>Send_Intro_RB_Non_RB_Email__c</field>
        <literalValue>1</literalValue>
        <name>Update MC Intro Non-RB Lead Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_MC_Intro_RB_Lead_Field</fullName>
        <field>Send_Intro_RB_Non_RB_Email__c</field>
        <literalValue>1</literalValue>
        <name>Update MC Intro RB Lead Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_My_Lead_to_true</fullName>
        <field>My_Lead__c</field>
        <literalValue>1</literalValue>
        <name>Update My Lead to true</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Send_Email_Checker_Field</fullName>
        <field>Sending_Email_Checker__c</field>
        <literalValue>Non - RB Lead</literalValue>
        <name>Update Send Email Checker Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Send_Email_Checker_Field_2</fullName>
        <field>Sending_Email_Checker__c</field>
        <literalValue>RB Lead</literalValue>
        <name>Update Send Email Checker Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_The_Stage_To_Converted</fullName>
        <description>Updating the Lead Stage to &quot;Converted&quot;</description>
        <field>Lead_Stage__c</field>
        <literalValue>Converted</literalValue>
        <name>Update The Stage To Converted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_The_Status_To_Converted</fullName>
        <description>Updating  the status of the lead to &quot;Converted - View in Pipeline&quot;</description>
        <field>Status</field>
        <literalValue>Converted - View in Pipeline</literalValue>
        <name>Update The Status To Converted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_status_to_Transfer_to_HLR</fullName>
        <description>Sprint 10_07A- (Story-B-144627)</description>
        <field>Status</field>
        <literalValue>Transfer to HLR</literalValue>
        <name>Update status to Transfer to HLR</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Warm_Transfer_Channel_value_RB_Portal</fullName>
        <field>Channel_Values__c</field>
        <literalValue>Warm Transfer - RB Portal</literalValue>
        <name>Warm Transfer Channel value RB Portal</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Warm_Transfer_Channel_value_RB_SOFI</fullName>
        <field>Channel_Values__c</field>
        <literalValue>Warm Transfer - RB SOFI</literalValue>
        <name>Warm Transfer Channel value RB SOFI</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Web_Direct</fullName>
        <field>Channel__c</field>
        <literalValue>Direct</literalValue>
        <name>Web_Direct</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Zillow_ChannelSource</fullName>
        <field>Channel_Sources__c</field>
        <literalValue>Web</literalValue>
        <name>Zillow ChannelSource</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Zillow_ChannelValue</fullName>
        <field>Channel_Values__c</field>
        <literalValue>Zillow</literalValue>
        <name>Zillow ChannelValue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Zillow_Channel_Centralized</fullName>
        <field>Channel__c</field>
        <literalValue>Centralized Retail</literalValue>
        <name>Zillow Channel Centralized</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Zillow_Channel_Direct</fullName>
        <field>Channel__c</field>
        <literalValue>Direct</literalValue>
        <name>Zillow Channel Direct</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Zillow_Company</fullName>
        <field>Company</field>
        <formula>&quot;Zillow&quot;</formula>
        <name>Zillow Company</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Zillow_Credit_Score_660_679</fullName>
        <field>How_Would_you_Describe_Your_Credit__c</field>
        <literalValue>660-679</literalValue>
        <name>Zillow Credit Score 660 - 679</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Zillow_Credit_Score_680_699</fullName>
        <field>How_Would_you_Describe_Your_Credit__c</field>
        <literalValue>680-699</literalValue>
        <name>Zillow Credit Score 680 - 699</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Zillow_Credit_Score_700_719</fullName>
        <field>How_Would_you_Describe_Your_Credit__c</field>
        <literalValue>700-719</literalValue>
        <name>Zillow Credit Score 700 - 719</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Zillow_Credit_Score_720_739</fullName>
        <field>How_Would_you_Describe_Your_Credit__c</field>
        <literalValue>720-739</literalValue>
        <name>Zillow Credit Score 720 - 739</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Zillow_Credit_Score_740</fullName>
        <field>How_Would_you_Describe_Your_Credit__c</field>
        <literalValue>740-800</literalValue>
        <name>Zillow Credit Score 740 +</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Zillow_Credit_Score_below_680</fullName>
        <field>How_Would_you_Describe_Your_Credit__c</field>
        <literalValue>Less than 660</literalValue>
        <name>Zillow Credit Score below 680</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Zillow_Loan_Amount</fullName>
        <description>Zillow Field Loan Amount into the “Requested_Loan_Amount__c” field</description>
        <field>Requested_Loan_Amount__c</field>
        <formula>Loan_Amount__c</formula>
        <name>Zillow Loan Amount</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Zillow_Notes</fullName>
        <description>Zillow Field Notes into the notes list on the MCs screen</description>
        <field>Notes__c</field>
        <formula>Admin_Comments__c</formula>
        <name>Zillow Notes</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Zillow_Phone_Number</fullName>
        <field>Borrowers_Home_Phone__c</field>
        <formula>Preferred_Phone_Number__c</formula>
        <name>Zillow Phone Number</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Zillow_Purchase_Price</fullName>
        <description>Zillow field Purchase Price into the “Approximate Value” field</description>
        <field>Original_Purchase_Price__c</field>
        <formula>Approximate_Value__c</formula>
        <name>Zillow Purchase Price</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Zillow_Record_Type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Web</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Zillow Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Zillow_State</fullName>
        <field>State</field>
        <formula>Property_State__c</formula>
        <name>Zillow State</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Zillow_Status</fullName>
        <field>Status</field>
        <literalValue>New - Not Opened</literalValue>
        <name>Zillow Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Zillow_ZipCode</fullName>
        <field>Property_Zip_Postal_Code__c</field>
        <formula>Zip_Code__c</formula>
        <name>Zillow ZipCode</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>changerecordtype2isconverted</fullName>
        <description>Changes the recordtype to isconverted after conversion</description>
        <field>RecordTypeId</field>
        <lookupValue>IsConverted</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>changerecordtype2isconverted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>channel_source</fullName>
        <field>Channel_Sources__c</field>
        <literalValue>Web</literalValue>
        <name>channel source</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>CR1 %E2%80%93 MC Intro Non - RB Lead</fullName>
        <actions>
            <name>CO_Clear_SendEmaiRBportal_checkbox</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_MC_Intro_Non_RB_Lead_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Send_Email_Checker_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5</booleanFilter>
        <criteriaItems>
            <field>Lead.Send_Email_RB_Portal__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Channel_Values__c</field>
            <operation>notEqual</operation>
            <value>RB Portal</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.DoNotCall</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>notEqual</operation>
            <value>National Opt Out</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Sending_Email_Checker__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Sprint 3
Wipro Technologies</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>CR1 %E2%80%93 MC Intro RB Lead</fullName>
        <actions>
            <name>CO_Clear_SendEmaiRBportal_checkbox</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_MC_Intro_RB_Lead_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Send_Email_Checker_Field_2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND (3 OR 4) AND 5</booleanFilter>
        <criteriaItems>
            <field>Lead.Send_Email_RB_Portal__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Channel_Values__c</field>
            <operation>equals</operation>
            <value>RB Portal</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.DoNotCall</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>notEqual</operation>
            <value>National Opt Out</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Sending_Email_Checker__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Sprint 3
Wipro Technologies</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Change Lead Status to No Attempts</fullName>
        <actions>
            <name>Active_Timestamp</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Lead_Status_to_No_Attempts</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>UpdateNew2Active</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update Lead status to &quot;No Attempts&quot; when a LO saves a lead and the status is currently &quot;New - Not Opened&quot;</description>
        <formula>AND(ISPICKVAL(Status,&apos;New - Not Opened&apos;) &amp;&amp;  ( CONTAINS($Profile.Name, &quot;Loan Officer&quot;)  ||    CONTAINS($Profile.Name, &quot;Sales Consultant&quot;)),NOT(CreatedDate== NOW()))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Changerecordtypetoisconverted</fullName>
        <actions>
            <name>Update_The_Stage_To_Converted</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_The_Status_To_Converted</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>changerecordtype2isconverted</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Changes the record type to isconverted after conversion.</description>
        <formula>AND( (!ISBLANK( Account_Name__c )),(! ISBLANK( Related_Opportunity__c ) ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Channel value set to Warm Transfer</fullName>
        <active>false</active>
        <description>Channel value set to Warm transfer when an MC assign a lead from RB Portal queues to himself.</description>
        <formula>AND(  ISCHANGED( Owner__c ),     ISBLANK(TRIM(PRIORVALUE(Owner__c))),  ( Owner:User.FirstName != &quot;Queue&quot; &amp;&amp; Owner:User.LastName != &quot;User&quot; ),        Is_assigned_already__c  == false,       ISPICKVAL(Channel_Sources__c, &apos;Bank&apos;),       ISPICKVAL(Channel_Values__c, &apos;RB Portal&apos;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Channel value set to Warm Transfer - RB Portal</fullName>
        <actions>
            <name>Warm_Transfer_Channel_value_RB_Portal</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Channel value set to Warm transfer when an MC assign a lead from RB Portal queues to himself.</description>
        <formula>AND(  ISCHANGED( Owner__c ),     ISBLANK(TRIM(PRIORVALUE(Owner__c))),  ( Owner:User.FirstName != &quot;Queue&quot; &amp;&amp; Owner:User.LastName != &quot;User&quot; ),        Is_assigned_already__c  == false,       ISPICKVAL(Channel_Sources__c, &apos;Bank&apos;),       ISPICKVAL(Channel_Values__c, &apos;RB Portal&apos;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Channel value set to Warm Transfer RB SOFI</fullName>
        <actions>
            <name>Warm_Transfer_Channel_value_RB_SOFI</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(  ISCHANGED( Owner__c ),     ISBLANK(TRIM(PRIORVALUE(Owner__c))),  ( Owner:User.FirstName != &quot;Queue&quot; &amp;&amp; Owner:User.LastName != &quot;User&quot; ),        Is_assigned_already__c  == false,       ISPICKVAL(Channel_Sources__c, &apos;Bank&apos;),       ISPICKVAL(Channel_Values__c, &apos;RB SOFI&apos;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Copy Borrowers Address To Co-Borrowers Address</fullName>
        <actions>
            <name>Copy_Borrowers_Address_1_Co_Borrower</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Borrowers_Address_2_Co_Borrower</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Borrowers_Apt_Co_Borrower</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Borrowers_City_Co_Borrower</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Borrowers_Country_Co_Borrower</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Borrowers_County_Co_Borrower</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Borrowers_House_Co_Borrower</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Borrowers_State_Co_Borrower</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Borrowers_Zip_Code_Co_Borrower</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Uncheck_Copy_Borrowers_Address</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Copy_Borrower_Current_Address__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Copying Borrower Address To Co-Borrowers Address when Copy Borrowers current address is checked</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Copy Borrowers Address To Property Address</fullName>
        <actions>
            <name>Copy_Borrowers_APT_Property</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Borrowers_Address_2_Property</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Borrowers_Address_Property</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Borrowers_City_Property</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Borrowers_Country_Property</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Borrowers_County_Property</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Borrowers_House_Property</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Borrowers_State_Property</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Borrowers_Zip_Code_Property</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Uncheck_Copy_Borrowers_Current_Address_1</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Copy_Borrower_Current_Address_to_Subject__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Copying Borrower Address To Property Address when Copy Borrower Current Address 1 is checked</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Copy Borrowers Home Phone To Co-Borrowers Home Phone</fullName>
        <actions>
            <name>Copy_Borrowers_Home_Phone_Number</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Uncheck_Copy_Borrowers_Home_Phone</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1</booleanFilter>
        <criteriaItems>
            <field>Lead.Copy_Borrowers_Home_Phone__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Copying Borrowers Home Phone To Co-Borrowers Home Phone when Copy Borrowers Home Phone Is Checked</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Customer_Email_Alert</fullName>
        <actions>
            <name>MC_Email</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(ISCHANGED(Owner__c),Owner:Queue.QueueName =&apos;&apos;, NOT(CreatedDate== NOW()))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>For Sofi Lead owner assignment logic2</fullName>
        <actions>
            <name>Update_Is_SofiLead_to_false</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_My_Lead_to_true</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Transfer_To_HLR__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Changes Is_Sofi_Lead__c to False and My_Lead__c to true</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>HLR Flag Down</fullName>
        <actions>
            <name>HLR_Flag_Down</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Lead_Record_Type_to_Prequal</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(ISCHANGED( Transfer_To_HLR__c ),(Transfer_To_HLR__c = False))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>HLR Flag Up</fullName>
        <actions>
            <name>HLR_Flag_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Lead_Record_Type_to_HLR</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Setting the HLR Flag</description>
        <formula>AND(ISCHANGED( Transfer_To_HLR__c ),(Transfer_To_HLR__c = True))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Individual Applicant Test</fullName>
        <actions>
            <name>Joint_Application_Flag_Off</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Applicant_Type__c</field>
            <operation>equals</operation>
            <value>Individual</value>
        </criteriaItems>
        <description>If the Applicant Type field contains &quot;Individual Application&quot; turn of the Joint application flag &quot;Will_This_be_a_joint_application__c&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Instant Lead</fullName>
        <actions>
            <name>Update_Lead_Channel_to_Neighborhood_Lend</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>CONTAINS(Lead_Owner_Role_RR__c, &quot;CRA&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Instant Lead Centralized</fullName>
        <actions>
            <name>Update_Lead_Channel_to_Centralized_Retai</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>Contains( Lead_Owner_Role_RR__c, &quot;Centralized&quot; )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Instant Lead Distributed</fullName>
        <actions>
            <name>Update_Lead_Channel_to_Distributed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>works only on Round Robin Instant Lead</description>
        <formula>CONTAINS(Lead_Owner_Role_RR__c, &quot;Distributed&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Instant Lead HomeEquity</fullName>
        <actions>
            <name>Update_Lead_Channel_to_Home_Equity</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>CONTAINS(Lead_Owner_Role_RR__c, &quot;Home Equity&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Internal Referral email Alert</fullName>
        <actions>
            <name>Internal_referral_Alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>Internal_Referral_Name__c != null</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Joint Applicant test</fullName>
        <actions>
            <name>Joint_Application_Flag_On</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2 OR 3</booleanFilter>
        <criteriaItems>
            <field>Lead.Applicant_Type__c</field>
            <operation>equals</operation>
            <value>Married Couple</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Applicant_Type__c</field>
            <operation>equals</operation>
            <value>Two Individuals (Not Married)</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Applicant_Type__c</field>
            <operation>equals</operation>
            <value>More than Two Individuals</value>
        </criteriaItems>
        <description>This test will determine if the applicant type is such that the will_this_be_a_joint_application__c field is checked.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Lead Assigned to Non-Queue Owner</fullName>
        <actions>
            <name>Set_Lead_Record_Type_to_Prequal</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Lead owner is changed to non-queue owner, and record type is not HLR, Home Equity,ToBeConverted or Web</description>
        <formula>AND(NOT(CreatedDate== NOW()),Lead_Owner_Queue__c==&apos;&apos;, NOT(ISPICKVAL(Channel__c, &apos;Home Equity&apos;)), OR(CONTAINS(RecordType.Name, &apos;Web&apos;),CONTAINS(RecordType.Name, &apos;Home Equity&apos;),CONTAINS(RecordType.Name, &apos;Unassigned&apos;)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Lead Assigned to Non-Queue Owner %28HomeEquity%29</fullName>
        <actions>
            <name>Set_Lead_Record_Type_to_Home_Equity</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Lead owner is changed to non-queue owner, Channel is Home Equity, and Record Type is Web or Unassigned</description>
        <formula>AND(NOT(CreatedDate== NOW()), Lead_Owner_Queue__c==&apos;&apos;, ISPICKVAL(Channel__c, &apos;Home Equity&apos;), OR(CONTAINS(RecordType.Name, &apos;Web&apos;), CONTAINS(RecordType.Name, &apos;Prequal&apos;), CONTAINS(RecordType.Name, &apos;Unassigned&apos;)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Lead Assigned to Queue</fullName>
        <actions>
            <name>Set_Lead_Record_Type_to_Unassigned</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Lead_Owner_Queue__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.RecordTypeId</field>
            <operation>notEqual</operation>
            <value>Web,HLR,Home Equity,ToBeConverted</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Channel_Values__c</field>
            <operation>notEqual</operation>
            <value>Lead Aggregator</value>
        </criteriaItems>
        <description>Lead owner is changed to Queue, and record type is not HLR, Home Equity, ToBeConverted or Web</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Lead Owner EID Update</fullName>
        <actions>
            <name>Lead_Owner_EID_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Channel__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Updates the Lead Owner EID with the EID of the Lead Owner</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Lead Status Change</fullName>
        <actions>
            <name>Active_Timestamp</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Captures NEW timestamp when a the lead status is manual changed</description>
        <formula>NOT(ISPICKVAL(Status,&apos;New - Not Opened&apos;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Lead Status is Contacted%2C bogus%2C wrong%2C national%2C test%2C duplicate</fullName>
        <actions>
            <name>Lead_stage_to_Lost</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2 OR 3 OR 4 OR 5 OR 6 OR 7 OR 8 OR 9</booleanFilter>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Duplicate Lead,HE Duplicate Lead</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Contacted / No Product Available,HE Contacted / No Product Available</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Contacted / No longer interested,HE Contacted / No longer interested</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Contacted / Went with another lender,HE Contacted / Went with another lender</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Bogus Lead,HE Bogus Lead</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Wrong number/eMarketing,HE Wrong Number/eMarketing</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>National Opt Out,HE National Opt Out</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Test Lead,HE Test Lead</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Contacted / Property Type Not Offered</value>
        </criteriaItems>
        <description>Triggered when the Lead Status is Contacted -no product/no interest/another lender, bogus, wrongnumber/e marketing, nationalopt out, test, duplicate</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Lead Status is New to Not Opened</fullName>
        <actions>
            <name>Lead_Stage_to_New</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>New - Not Opened,HE New - Not Opened</value>
        </criteriaItems>
        <description>Triggered when the Lead status is &quot;New - Not Opened&quot;. This will update the Lead Stage to &quot;New&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Lead Status to No Attempts or Attempts 1-6</fullName>
        <actions>
            <name>Lead_Stage_to_Attempting</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2 OR 3 OR 4 OR 5 OR 6 OR 7 OR 8 OR 9 OR 10 OR 11</booleanFilter>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>No Attempts,HE No Attempts</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Attempt 1 - No Contact,HE Attempt 1 - No Contact</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Attempt 2 - No Contact,HE Attempt 2 - No Contact</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Attempt 3 - No Contact,HE Attempt 3 - No Contact</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Attempt 4 - No Contact,HE Attempt 4 - No Contact</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Attempt 5 - No Contact,HE Attempt 5 - No Contact</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Attempt 6+ - No Contact,HE Attempt 6+ - No Contact</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Contacted / Customer Rate Shopping</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Contacted / Still Deciding</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Request For Prequal</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Contacted / Follow Up Pending</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Lead assigned to Web Purchase queue</fullName>
        <actions>
            <name>Lead_Assigned_to_Web_Purchase</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Lead_status_Attempt_1_No_Contact</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(      Owner:Queue.QueueName = &apos;Web – Purchase&apos;,      ISPICKVAL(Status, &apos;New - Not Opened&apos;)     )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Lead status to Transfer to HLR</fullName>
        <actions>
            <name>Update_status_to_Transfer_to_HLR</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Transfer_To_HLR__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>LoanStatusUpdate</fullName>
        <actions>
            <name>Loan_Update_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>To display the  appropriate loan status in RB Portal</description>
        <formula>AND( ISCHANGED( Status ) , BEGINS( Empower_Lead_ID__c ,&apos;E&apos;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Phone Display</fullName>
        <actions>
            <name>Phone_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Phone</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Displays the value of &quot;Phone&quot; in the &quot;Borrowers Home Phone&quot; field</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate Company Field On Lead</fullName>
        <actions>
            <name>Auto_Populate_Lead_Company_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Company</field>
            <operation>notEqual</operation>
            <value>NULL</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Company</field>
            <operation>notEqual</operation>
            <value>Zillow</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Revert To Editable on Unlock</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Lead.DNC__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Channel Value from Inbound to WarmTransfer</fullName>
        <active>false</active>
        <formula>PRIORVALUE(OwnerId) &lt;&gt; OwnerId &amp;&amp;  PRIORVALUE(OwnerId) = $Label.Direct_Inbound_Queueid</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Lead Channel to Centralized Retail</fullName>
        <actions>
            <name>Update_Lead_Channel_to_Centralized_Retai</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>If lead owner is changed and role name of new owner contains Centralized, Channel = Centralized Retail</description>
        <formula>AND( Contains(Owner:User.UserRole.Name, &quot;Centralized&quot;),      ISNEW() || ( ISCHANGED( Owner__c )                &amp;&amp; !ISBLANK( TRIM( Owner__c ))                &amp;&amp; ISBLANK( Lead_Owner_Role_RR__c )))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Lead Channel to Distributed</fullName>
        <actions>
            <name>Update_Lead_Channel_to_Distributed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>If lead owner is changed and role name of new owner contains Distributed, Channel = Distributed Retail</description>
        <formula>((ISNEW()) || (ISCHANGED( Owner__c ) &amp;&amp; !ISBLANK(TRIM(Owner__c))))  &amp;&amp;  Contains(Owner:User.UserRole.Name, &quot;Distributed&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Lead Channel to Home Equity</fullName>
        <actions>
            <name>Update_Lead_Channel_to_Home_Equity</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>If lead owner is changed and role name of new owner contains Home Equity, Channel = Home Equity</description>
        <formula>((ISNEW()) || (ISCHANGED( Owner__c ) &amp;&amp; !ISBLANK(TRIM(Owner__c))))  &amp;&amp; Contains(Owner:User.UserRole.Name, &quot;Home Equity&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Lead Channel to Neighborhood Lending</fullName>
        <actions>
            <name>Update_Lead_Channel_to_Neighborhood_Lend</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>If lead owner is changed and role name of new owner contains CRA, Channel = Neighborhood Lending</description>
        <formula>((ISNEW()) || (ISCHANGED( Owner__c ) &amp;&amp; !ISBLANK(TRIM(Owner__c))))  &amp;&amp; Contains(Owner:User.UserRole.Name, &quot;CRA&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Lead Owner Queue name</fullName>
        <actions>
            <name>Update_Lead_Owner_Queue_name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Salesforce_Lead_Number__c</field>
            <operation>notEqual</operation>
            <value>null</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>UpdateClosingDate</fullName>
        <actions>
            <name>UpdateClosingdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Closing_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Updates the closing date to 30 days from the day.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WTL-ChannelSource Field Update</fullName>
        <actions>
            <name>Set_The_Lead_Record_Type_To_Web</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>channel_source</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Channel_Values__c</field>
            <operation>equals</operation>
            <value>Lead Aggregator</value>
        </criteriaItems>
        <description>Update Channel Field Source for Lead Aggregator</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>WTL-Direct Channel Field Update</fullName>
        <actions>
            <name>Web_Direct</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update Channel field to Direct</description>
        <formula>(Owner:Queue.DeveloperName = &apos;Web_Direct&apos;) &amp;&amp; (ISBLANK(Lead_Owner_Role_RR__c))</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>WTL-MSA Advice 2 v2</fullName>
        <actions>
            <name>WTL_MSA_Email_Notification_2</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <formula>(Owner:Queue.QueueName = &apos;Web Direct&apos;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Zillow Channel Centralized</fullName>
        <actions>
            <name>Zillow_Channel_Centralized</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Ref_Id__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Loan_Purpose__c</field>
            <operation>equals</operation>
            <value>Purchase</value>
        </criteriaItems>
        <description>Update Channel value</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Zillow Channel Direct</fullName>
        <actions>
            <name>Zillow_Channel_Direct</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Ref_Id__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Loan_Purpose__c</field>
            <operation>equals</operation>
            <value>Refinance</value>
        </criteriaItems>
        <description>Update Zillow Channel values</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Zillow Credit Score 660 - 679</fullName>
        <actions>
            <name>Zillow_Credit_Score_660_679</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update Zillow Credit Scores</description>
        <formula>(!ISBLANK(Ref_Id__c)||!ISBLANK(Mortech_Tracking_ID__c)) &amp;&amp; VALUE(CreditScore__c)&gt;= 660 &amp;&amp; VALUE(CreditScore__c)&lt;= 679</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Zillow Credit Score 680 - 699</fullName>
        <actions>
            <name>Zillow_Credit_Score_680_699</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update Zillow Credit Scores</description>
        <formula>(!ISBLANK(Ref_Id__c)||!ISBLANK(Mortech_Tracking_ID__c))  &amp;&amp; VALUE(CreditScore__c)&gt;= 680 &amp;&amp; VALUE(CreditScore__c)&lt;= 699</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Zillow Credit Score 700 - 719</fullName>
        <actions>
            <name>Zillow_Credit_Score_700_719</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update Zillow Credit Scores</description>
        <formula>(!ISBLANK(Ref_Id__c)||!ISBLANK(Mortech_Tracking_ID__c))  &amp;&amp; VALUE(CreditScore__c)&lt;= 719 &amp;&amp; VALUE(CreditScore__c)&gt;= 700</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Zillow Credit Score 720 - 739</fullName>
        <actions>
            <name>Zillow_Credit_Score_720_739</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update Zillow Credit Scores</description>
        <formula>(!ISBLANK(Ref_Id__c)||!ISBLANK(Mortech_Tracking_ID__c))  &amp;&amp; VALUE(CreditScore__c)&lt;= 739 &amp;&amp; VALUE(CreditScore__c)&gt;= 720</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Zillow Credit Score 740 %2B</fullName>
        <actions>
            <name>Zillow_Credit_Score_740</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update Zillow Channel values</description>
        <formula>(!ISBLANK(Ref_Id__c)||!ISBLANK(Mortech_Tracking_ID__c))  &amp;&amp; VALUE(CreditScore__c)&gt;= 740</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Zillow Credit Score below 660</fullName>
        <actions>
            <name>Zillow_Credit_Score_below_680</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update Zillow Credit Scores</description>
        <formula>(!ISBLANK(Ref_Id__c)||!ISBLANK(Mortech_Tracking_ID__c))  &amp;&amp; VALUE(CreditScore__c)&lt; 660</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Zillow Field Updates</fullName>
        <actions>
            <name>Loan_Amount</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Purchase_Price</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Zillow_ChannelSource</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Zillow_ChannelValue</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Zillow_Company</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Zillow_Phone_Number</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Zillow_Record_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Zillow_State</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Zillow_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Zillow_ZipCode</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Lead.Ref_Id__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Move Zillow specific fields to COHL fields</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Zillow Field Updates 2</fullName>
        <actions>
            <name>Zillow_Loan_Amount</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Zillow_Notes</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Zillow_Purchase_Price</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Lead.Ref_Id__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Move Zillow specific fields to COHL fields</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
