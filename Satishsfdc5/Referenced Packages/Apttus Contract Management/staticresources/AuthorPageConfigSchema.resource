<?xml version="1.0" encoding="UTF-8"?>
<!-- edited with XMLSpy v2010 rel. 2 (x64) (http://www.altova.com) by Nathan Krishnan (private) -->
<!--
 Copyright 2009-2010 Apttus Inc. All Rights Reserved.    
$Id: //Apttus/Develop/dev/schemas/AuthorPageConfig.xsd $
$DateTime: 2010/05/18 19:02:26 $
This software is the proprietary information of Apttus, Inc.
Use is subject to license terms.

Author : Nathan Krishnan
    
Version: $Revision: #4 $

Description:
    Defines schema AuthorPageConfig
-->
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" elementFormDefault="unqualified" attributeFormDefault="unqualified">
	<xs:element name="AuthorPageConfig" type="AuthorPageConfigType">
		<xs:annotation>
			<xs:documentation>Author Page Configuration</xs:documentation>
		</xs:annotation>
	</xs:element>
	<xs:complexType name="AuthorPageConfigType">
		<xs:sequence>
			<xs:element name="Action" type="AuthorActionType">
				<xs:annotation>
					<xs:documentation>The author action.</xs:documentation>
				</xs:annotation>
			</xs:element>
		</xs:sequence>
	</xs:complexType>
	<!-- authoraction type -->
	<xs:complexType name="AuthorActionType">
		<xs:sequence>
			<xs:element name="CustomPage" type="CustomPageType">
				<xs:annotation>
					<xs:documentation>The custom page.</xs:documentation>
				</xs:annotation>
			</xs:element>
		</xs:sequence>
		<xs:attribute name="name" use="required">
			<xs:annotation>
				<xs:documentation>The action name.</xs:documentation>
			</xs:annotation>
		</xs:attribute>
	</xs:complexType>
	<!-- custom page -->
	<xs:complexType name="CustomPageType">
		<xs:sequence>
			<xs:element name="Name" type="xs:string">
				<xs:annotation>
					<xs:documentation>The Page name</xs:documentation>
				</xs:annotation>
			</xs:element>
		</xs:sequence>
	</xs:complexType>
</xs:schema>
