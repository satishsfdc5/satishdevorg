<?xml version="1.0" encoding="UTF-8"?>
<!--
 Copyright 2009-2011 Apttus Inc. All Rights Reserved.    
$Id: //Apttus/Develop/dev/schemas/ProposalConfig.xsd $
$DateTime: 2010/05/18 19:02:26 $
This software is the proprietary information of Apttus, Inc.
Use is subject to license terms.

Author : Nathan Krishnan
    
Version: $Revision: #4 $

Description:
    Defines schema ProposalConfig
-->
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" elementFormDefault="unqualified" attributeFormDefault="unqualified">
	<xs:element name="ProposalConfig" type="ProposalConfigType">
		<xs:annotation>
			<xs:documentation>Proposal Configuration</xs:documentation>
		</xs:annotation>
	</xs:element>
	<!-- proposal config -->
	<xs:complexType name="ProposalConfigType">
		<xs:sequence>
			<xs:element name="ProposalSpec" type="ProposalSpecType" minOccurs="0">
				<xs:annotation>
					<xs:documentation>The proposal spec</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="OpportunityToProposalCopySpec" type="OpportunityToProposalCopySpecType" minOccurs="0">
				<xs:annotation>
					<xs:documentation>The opportunity to proposal copy spec</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="SortSpec" type="SortSpecType" minOccurs="0">
				<xs:annotation>
					<xs:documentation>The sort specification</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="PDFSecurityDefault" type="PDFSecurityDefaultType" minOccurs="0">
				<xs:annotation>
					<xs:documentation>The pdf security default specification.</xs:documentation>
				</xs:annotation>
			</xs:element>
		</xs:sequence>
	</xs:complexType>
	<!-- proposal spec -->
	<xs:complexType name="ProposalSpecType">
		<xs:sequence>
			<xs:element name="Description" type="xs:string" minOccurs="0">
				<xs:annotation>
					<xs:documentation>The element description.</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="CloneSpec" type="CloneSpecType" minOccurs="0">
				<xs:annotation>
					<xs:documentation>The clone specification</xs:documentation>
				</xs:annotation>
			</xs:element>
		</xs:sequence>
	</xs:complexType>
	<!-- clone spec -->
	<xs:complexType name="CloneSpecType">
		<xs:sequence>
			<xs:element name="Description" type="xs:string" minOccurs="0">
				<xs:annotation>
					<xs:documentation>The element description.</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="Includes" type="ChildObjectCollType" minOccurs="0">
				<xs:annotation>
					<xs:documentation>The included child objects</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="Excludes" type="ChildObjectCollType" minOccurs="0">
				<xs:annotation>
					<xs:documentation>The excluded child objects</xs:documentation>
				</xs:annotation>
			</xs:element>
		</xs:sequence>
	</xs:complexType>
	<!-- child object collection -->
	<xs:complexType name="ChildObjectCollType">
		<xs:sequence>
			<xs:element name="ChildObject" type="ChildObjectType" minOccurs="0" maxOccurs="unbounded">
				<xs:annotation>
					<xs:documentation>The child object</xs:documentation>
				</xs:annotation>
			</xs:element>
		</xs:sequence>
	</xs:complexType>
	<!-- child object -->
	<xs:complexType name="ChildObjectType">
		<xs:sequence>
			<xs:element name="Name" type="xs:string">
				<xs:annotation>
					<xs:documentation>Child object name</xs:documentation>
				</xs:annotation>
			</xs:element>
		</xs:sequence>
	</xs:complexType>
	<!-- opportunity to proposal copy spec type -->
	<xs:complexType name="OpportunityToProposalCopySpecType">
		<xs:sequence>
			<xs:element name="Description" type="xs:string" minOccurs="0">
				<xs:annotation>
					<xs:documentation>The element description.</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="ProposalFields" type="FieldMappingCollType" minOccurs="0">
				<xs:annotation>
					<xs:documentation>The proposal fields</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="ProposalLineItemFields" type="FieldMappingCollType" minOccurs="0">
				<xs:annotation>
					<xs:documentation>The proposal line item fields</xs:documentation>
				</xs:annotation>
			</xs:element>
		</xs:sequence>
	</xs:complexType>
	<!-- field mapping collection -->
	<xs:complexType name="FieldMappingCollType">
		<xs:sequence>
			<xs:element name="FieldMapping" type="FieldMappingType" minOccurs="0" maxOccurs="unbounded">
				<xs:annotation>
					<xs:documentation>The copy field mapping</xs:documentation>
				</xs:annotation>
			</xs:element>
		</xs:sequence>
	</xs:complexType>
	<!-- field mapping -->
	<xs:complexType name="FieldMappingType">
		<xs:sequence>
			<xs:element name="FromField" type="FieldSpecType">
				<xs:annotation>
					<xs:documentation>The from field</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="ToField" type="FieldSpecType">
				<xs:annotation>
					<xs:documentation>The to field</xs:documentation>
				</xs:annotation>
			</xs:element>
		</xs:sequence>
	</xs:complexType>
	<!-- field spec type -->
	<xs:complexType name="FieldSpecType">
		<xs:sequence>
			<xs:element name="Name" type="xs:string">
				<xs:annotation>
					<xs:documentation>Field name</xs:documentation>
				</xs:annotation>
			</xs:element>
		</xs:sequence>
	</xs:complexType>
	<!-- sort spec type -->
	<xs:complexType name="SortSpecType">
		<xs:sequence>
			<xs:element name="Description" type="xs:string" minOccurs="0">
				<xs:annotation>
					<xs:documentation>The element description.</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="SortObjects" type="SortObjectCollType">
				<xs:annotation>
					<xs:documentation>The sort object</xs:documentation>
				</xs:annotation>
			</xs:element>
		</xs:sequence>
	</xs:complexType>
	<!-- sort object collection type -->
	<xs:complexType name="SortObjectCollType">
		<xs:sequence>
			<xs:element name="SortObject" type="SortObjectSpecType" minOccurs="0" maxOccurs="unbounded">
				<xs:annotation>
					<xs:documentation>The sort object</xs:documentation>
				</xs:annotation>
			</xs:element>
		</xs:sequence>
	</xs:complexType>
	<!-- sort object spec type -->
	<xs:complexType name="SortObjectSpecType">
		<xs:sequence>
			<xs:element name="Name" type="xs:string">
				<xs:annotation>
					<xs:documentation>Object name</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="SortFields" type="SortFieldCollType">
				<xs:annotation>
					<xs:documentation>The sort field</xs:documentation>
				</xs:annotation>
			</xs:element>
		</xs:sequence>
	</xs:complexType>
	<!-- sort field collection type -->
	<xs:complexType name="SortFieldCollType">
		<xs:sequence>
			<xs:element name="SortField" type="SortFieldSpecType" minOccurs="0" maxOccurs="unbounded">
				<xs:annotation>
					<xs:documentation>The sort field</xs:documentation>
				</xs:annotation>
			</xs:element>
		</xs:sequence>
	</xs:complexType>
	<!-- sort field spec type -->
	<xs:complexType name="SortFieldSpecType">
		<xs:sequence>
			<xs:element name="Name" type="xs:string">
				<xs:annotation>
					<xs:documentation>Field name</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="SortOrder" type="SortOrderType" minOccurs="0">
				<xs:annotation>
					<xs:documentation>Sort order</xs:documentation>
				</xs:annotation>
			</xs:element>
		</xs:sequence>
	</xs:complexType>
	<!-- pdf security default type -->
	<xs:complexType name="PDFSecurityDefaultType">
		<xs:sequence>
			<xs:element name="CanPrint" type="xs:boolean">
				<xs:annotation>
					<xs:documentation>Set this to true to allow the user to print the document.</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="CanCopy" type="xs:boolean">
				<xs:annotation>
					<xs:documentation>Set this to true to allow the user to copy text and graphics from the document.</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="CanChange" type="xs:boolean">
				<xs:annotation>
					<xs:documentation>Set this to true to allow the user to edit the document.</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="CanAddNotes" type="xs:boolean">
				<xs:annotation>
					<xs:documentation>Set this to true to allow the user to add annotations.</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="CanFillFields" type="xs:boolean">
				<xs:annotation>
					<xs:documentation>Set this to true to allow the user to fill in form fields. Only works with 128-bit encryption.</xs:documentation>
				</xs:annotation>
			</xs:element>
			<!--
			<xs:element name="CanCopyAccess" type="xs:boolean">
				<xs:annotation>
					<xs:documentation>Set this to true to enable copying for use with accessibility features. Only works with 128-bit encryption.</xs:documentation>
				</xs:annotation>
			</xs:element>
-->
			<xs:element name="CanAssemble" type="xs:boolean">
				<xs:annotation>
					<xs:documentation>Set this to true to allow the user to assemble the document. Only works with 128-bit encryption.</xs:documentation>
				</xs:annotation>
			</xs:element>
			<!--
			<xs:element name="CanPrintFull" type="xs:boolean">
				<xs:annotation>
					<xs:documentation>Set this to false to force low-resolution printing of the document only. This prevents the document from being distilled into a new PDF document. Only works with 128-bit encryption.</xs:documentation>
				</xs:annotation>
			</xs:element>
-->
		</xs:sequence>
	</xs:complexType>
	<!-- order type -->
	<xs:simpleType name="SortOrderType">
		<xs:restriction base="xs:string">
			<xs:enumeration value="ascending"/>
			<xs:enumeration value="descending"/>
		</xs:restriction>
	</xs:simpleType>
</xs:schema>
