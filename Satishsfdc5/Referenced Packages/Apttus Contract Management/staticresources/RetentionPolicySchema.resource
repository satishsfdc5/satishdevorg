<?xml version="1.0" encoding="UTF-8"?>
<!--
 Copyright 2009-2010 Apttus Inc. All Rights Reserved.    
$Id: //Apttus/Develop/dev/schemas/RetentionPolicy.xsd $
$DateTime: 2010/02/10 19:02:26 $
This software is the proprietary information of Apttus, Inc.
Use is subject to license terms.

Author : Nathan Krishnan
    
Version: $Revision: #4 $

Description:
    Defines schema RetentionPolicy
-->
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" elementFormDefault="unqualified" attributeFormDefault="unqualified">
	<xs:element name="RetentionPolicy" type="RetentionPolicyType">
		<xs:annotation>
			<xs:documentation>Retention Policy</xs:documentation>
		</xs:annotation>
	</xs:element>
	<!-- retention policy -->
	<xs:complexType name="RetentionPolicyType">
		<xs:sequence>
			<xs:element name="Filter" type="FilterType" minOccurs="0">
				<xs:annotation>
					<xs:documentation>The record filter</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="Rule" type="RuleType" minOccurs="0">
				<xs:annotation>
					<xs:documentation>The retention rule</xs:documentation>
				</xs:annotation>
			</xs:element>
		</xs:sequence>
	</xs:complexType>
	<!-- filter -->
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
	<!-- rule type -->
	<xs:complexType name="RuleType">
		<xs:sequence>
			<xs:element name="RetainForever" type="xs:boolean">
				<xs:annotation>
					<xs:documentation>Retain forever indicator</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="RetainFor" type="RetainForType" minOccurs="0">
				<xs:annotation>
					<xs:documentation>Retain for</xs:documentation>
				</xs:annotation>
			</xs:element>
		</xs:sequence>
	</xs:complexType>
	<!-- retain for -->
	<xs:complexType name="RetainForType">
		<xs:sequence>
			<xs:element name="Period" type="RetentionPeriodType">
				<xs:annotation>
					<xs:documentation>The retention period</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="AfterDate" type="AfterDateType">
				<xs:annotation>
					<xs:documentation>The after date</xs:documentation>
				</xs:annotation>
			</xs:element>
		</xs:sequence>
	</xs:complexType>
	<!-- retention period -->
	<xs:complexType name="RetentionPeriodType">
		<xs:simpleContent>
			<xs:extension base="xs:nonNegativeInteger">
				<xs:attribute name="uom" type="PeriodUOMType">
					<xs:annotation>
						<xs:documentation>Retention period</xs:documentation>
					</xs:annotation>
				</xs:attribute>
			</xs:extension>
		</xs:simpleContent>
	</xs:complexType>
	<!-- after date -->
	<xs:complexType name="AfterDateType">
		<xs:sequence>
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
	<!-- period uom -->
	<xs:simpleType name="PeriodUOMType">
		<xs:restriction base="xs:string">
			<xs:enumeration value="Days"/>
			<xs:enumeration value="Months"/>
			<xs:enumeration value="Years"/>
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
