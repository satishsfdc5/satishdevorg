<?xml version="1.0" encoding="UTF-8"?>
<!--
 Copyright 2009-2011 Apttus Inc. All Rights Reserved.    
$Id: //Apttus/Develop/dev/schemas/ComplyConfig.xsd $
$DateTime: 2010/05/18 19:02:26 $
This software is the proprietary information of Apttus, Inc.
Use is subject to license terms.

Author : Nathan Krishnan
    
Version: $Revision: #4 $

Description:
    Defines schema ComplyConfig
-->
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" elementFormDefault="unqualified" attributeFormDefault="unqualified">
	<xs:element name="ComplyConfig" type="ComplyConfigType">
		<xs:annotation>
			<xs:documentation>Comply Configuration</xs:documentation>
		</xs:annotation>
	</xs:element>
	<!-- comply config -->
	<xs:complexType name="ComplyConfigType">
		<xs:sequence>
			<xs:element name="AgreementSpec" type="AgreementSpecType" minOccurs="0">
				<xs:annotation>
					<xs:documentation>The agreement spec</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="TemplateSpec" type="ObjectSpecType" minOccurs="0">
				<xs:annotation>
					<xs:documentation>The template spec</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="AgreementRuleSpec" type="ObjectSpecType" minOccurs="0">
				<xs:annotation>
					<xs:documentation>The agreement rule spec</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="EmailTemplateSpec" type="ObjectSpecType" minOccurs="0">
				<xs:annotation>
					<xs:documentation>The email template spec</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="QueryTemplateSpec" type="ObjectSpecType" minOccurs="0">
				<xs:annotation>
					<xs:documentation>The query template spec</xs:documentation>
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
	<!-- object spec -->
	<xs:complexType name="ObjectSpecType">
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
	<!-- agreement spec -->
	<xs:complexType name="AgreementSpecType">
		<xs:complexContent>
			<xs:extension base="ObjectSpecType">
				<xs:sequence>
					<xs:element name="ContentSpec" type="ContentSpecType" minOccurs="0">
						<xs:annotation>
							<xs:documentation>The content specification</xs:documentation>
						</xs:annotation>
					</xs:element>
				</xs:sequence>
			</xs:extension>
		</xs:complexContent>
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
	<!-- content spec -->
	<xs:complexType name="ContentSpecType">
		<xs:sequence>
			<xs:element name="Description" type="xs:string" minOccurs="0">
				<xs:annotation>
					<xs:documentation>The element description.</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="TagFields" type="TagFieldCollType">
				<xs:annotation>
					<xs:documentation>The content tag field</xs:documentation>
				</xs:annotation>
			</xs:element>
		</xs:sequence>
	</xs:complexType>
	<!-- tag field collection -->
	<xs:complexType name="TagFieldCollType">
		<xs:sequence>
			<xs:element name="TagField" type="FieldSpecType" minOccurs="0" maxOccurs="unbounded">
				<xs:annotation>
					<xs:documentation>The content tag field</xs:documentation>
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
