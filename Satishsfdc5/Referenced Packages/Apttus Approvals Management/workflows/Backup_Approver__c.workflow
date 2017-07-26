<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>ApprovalRequestReassignmentNotification</fullName>
        <description>Approval Request Reassignment Notification</description>
        <protected>false</protected>
        <recipients>
            <field>Backup_User__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Current_User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Apttus__ApttusEmailTemplates/Approval_Request_Reassignment_Notification</template>
    </alerts>
    <fieldUpdates>
        <fullName>SetCancellationDatetoNOW</fullName>
        <description>Set Cancellation Date to NOW</description>
        <field>Cancellation_Date__c</field>
        <formula>NOW()</formula>
        <name>Set Cancellation Date to NOW</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SetCancellationDatetoNull</fullName>
        <description>Set Cancellation Date to Null</description>
        <field>Cancellation_Date__c</field>
        <name>Set Cancellation Date to Null</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SetEffectiveDatetoNull</fullName>
        <description>Set Effective Date to Null</description>
        <field>Effective_Date__c</field>
        <name>Set Effective Date to Null</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SetExpirationDatetoNull</fullName>
        <description>Set Expiration Date to Null</description>
        <field>Expiration_Date__c</field>
        <name>Set Expiration Date to Null</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SetInEffectFlagtoFalse</fullName>
        <description>Set In Effect Flag to False</description>
        <field>InEffect__c</field>
        <literalValue>0</literalValue>
        <name>Set In Effect Flag to False</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SetInEffectFlagtoTrue</fullName>
        <description>Set In Effect Flag to True</description>
        <field>InEffect__c</field>
        <literalValue>1</literalValue>
        <name>Set In Effect Flag to True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SetIsActivetoFalse</fullName>
        <description>Set Is Active to False</description>
        <field>IsActive__c</field>
        <literalValue>0</literalValue>
        <name>Set Is Active to False</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Send Reassignment Notification</fullName>
        <actions>
            <name>ApprovalRequestReassignmentNotification</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Backup_Approver__c.InEffect__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Backup Approver - Send notifications to the backup user and current user when a backup approver is activated or deactivated</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
