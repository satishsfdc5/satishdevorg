<?xml version="1.0" encoding="UTF-8"?>
<!-- edited with XMLSpy v2010 rel. 2 (x64) (http://www.altova.com) by Nathan Krishnan (private) -->
<!--
 Copyright 2010-2011 Apttus Inc. All Rights Reserved.    
$Id: //Apttus/Develop/dev/schemas/ActionMeta.xsd $
$DateTime: 2010/05/18 19:02:26 $
This software is the proprietary information of Apttus, Inc.
Use is subject to license terms.

Author : Nathan Krishnan
    
Version: $Revision: #4 $

Description:
    Defines schema SearchFilter
-->
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" elementFormDefault="unqualified" attributeFormDefault="unqualified">
	<xs:element name="SearchFilter" type="SearchFilterType">
		<xs:annotation>
			<xs:documentation>Search Filter</xs:documentation>
		</xs:annotation>
	</xs:element>
	<xs:complexType name="SearchFilterType">
		<xs:sequence>
			<xs:element name="SObjectName" type="xs:string">
				<xs:annotation>
					<xs:documentation>SObject name</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="SObjectLabel" type="xs:string" minOccurs="0">
				<xs:annotation>
					<xs:documentation>SObject label</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="Filter" type="FilterType">
				<xs:annotation>
					<xs:documentation>The row filter</xs:documentation>
				</xs:annotation>
			</xs:element>
		</xs:sequence>
	</xs:complexType>
	<!-- filter type-->
	<xs:complexType name="FilterType">
		<xs:sequence>
			<xs:element name="Predicates" type="PredicateCollType">
				<xs:annotation>
					<xs:documentation>The filter predicates</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="ConditionExpr" type="xs:string">
				<xs:annotation>
					<xs:documentation>The filter expression</xs:documentation>
				</xs:annotation>
			</xs:element>
		</xs:sequence>
	</xs:complexType>
	<!-- predicate collection -->
	<xs:complexType name="PredicateCollType">
		<xs:sequence>
			<xs:element name="Predicate" type="PredicateType" maxOccurs="unbounded">
				<xs:annotation>
					<xs:documentation>The predicate</xs:documentation>
				</xs:annotation>
			</xs:element>
		</xs:sequence>
	</xs:complexType>
	<!-- predicate -->
	<xs:complexType name="PredicateType">
		<xs:sequence>
			<xs:element name="RowNum" type="xs:positiveInteger">
				<xs:annotation>
					<xs:documentation>Row number</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="FieldName" type="xs:string">
				<xs:annotation>
					<xs:documentation>Field name</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="FieldLabel" type="xs:string">
				<xs:annotation>
					<xs:documentation>Field label</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="FieldType" type="xs:string">
				<xs:annotation>
					<xs:documentation>Field type</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="CompOper" type="CompOperType">
				<xs:annotation>
					<xs:documentation>Comparison operator</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="FieldValue" type="xs:string">
				<xs:annotation>
					<xs:documentation>Field value</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="BoolOper" type="BoolOperType">
				<xs:annotation>
					<xs:documentation>Boolean operator</xs:documentation>
				</xs:annotation>
			</xs:element>
		</xs:sequence>
	</xs:complexType>
	<!-- SFDC ID type -->
	<xs:simpleType name="ID">
		<xs:restriction base="xs:string">
			<xs:length value="18"/>
			<xs:pattern value="[a-zA-Z0-9]{18}"/>
		</xs:restriction>
	</xs:simpleType>
	<!-- comparison operator -->
	<xs:simpleType name="CompOperType">
		<xs:restriction base="xs:string">
			<xs:enumeration value="equal to"/>
			<xs:enumeration value="not equal to"/>
			<xs:enumeration value="starts with"/>
			<xs:enumeration value="contains"/>
			<xs:enumeration value="does not contain"/>
			<xs:enumeration value="less than"/>
			<xs:enumeration value="greater than"/>
			<xs:enumeration value="less than or equal to"/>
			<xs:enumeration value="greater than or equal to"/>
			<xs:enumeration value="in"/>
			<xs:enumeration value="not in"/>
		</xs:restriction>
	</xs:simpleType>
	<!-- boolean operator -->
	<xs:simpleType name="BoolOperType">
		<xs:restriction base="xs:string">
			<xs:enumeration value="AND"/>
			<xs:enumeration value="OR"/>
		</xs:restriction>
	</xs:simpleType>
</xs:schema>
