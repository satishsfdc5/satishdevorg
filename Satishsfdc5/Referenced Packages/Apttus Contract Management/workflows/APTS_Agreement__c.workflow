<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>SearchFieldUpdate</fullName>
        <description>Update the account search field with Account Name</description>
        <field>Account_Search_Field__c</field>
        <formula>Account__r.Name  &amp;  FF_Agreement_Number__c</formula>
        <name>Search Field Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SetAgreementNumber</fullName>
        <description>Set agreement number from the auto generated contract number</description>
        <field>Agreement_Number__c</field>
        <formula>Contract_Number__c</formula>
        <name>Set Agreement Number</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SetClonetriggertofalse</fullName>
        <description>Set Clone trigger to false</description>
        <field>Workflow_Trigger_Created_From_Clone__c</field>
        <literalValue>0</literalValue>
        <name>Set Clone trigger to false</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Reset Clone Trigger</fullName>
        <actions>
            <name>SetClonetriggertofalse</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>APTS_Agreement__c.Workflow_Trigger_Created_From_Clone__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Reset Clone Trigger</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Search Field Update</fullName>
        <actions>
            <name>SearchFieldUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Populate an external Id search field with account name, so that side bar support can work with Account name search</description>
        <formula>or(not (isnull(Account__r.Name)) ,not (isnull(FF_Agreement_Number__c)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Agreement Number</fullName>
        <actions>
            <name>SetAgreementNumber</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>APTS_Agreement__c.Agreement_Number__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Set agreement number for new agreements. The agreement number is auto generated.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
