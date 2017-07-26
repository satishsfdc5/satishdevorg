<?xml version="1.0" encoding="UTF-8"?>
<!--
 Copyright 2009-2010 Apttus Inc. All Rights Reserved.    
$Id: //Apttus/Develop/dev/schemas/ContentEventRequest.xsd $
$DateTime: 2010/02/10 19:02:26 $
This software is the proprietary information of Apttus, Inc.
Use is subject to license terms.

Author : Nathan Krishnan
    
Version: $Revision: #4 $

Description:
    Defines schema ContentEventRequest
-->
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" elementFormDefault="unqualified" attributeFormDefault="unqualified">
	<xs:element name="ContentEvent" type="ContentEventType">
		<xs:annotation>
			<xs:documentation>Content Event</xs:documentation>
		</xs:annotation>
	</xs:element>
	<xs:complexType name="ContentEventType">
		<xs:sequence>
			<xs:element name="EventName" type="EventType">
				<xs:annotation>
					<xs:documentation>The content event name</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:choice>
				<xs:element name="PublishContentRequest" type="PublishContentRequestType">
					<xs:annotation>
						<xs:documentation>Publish the content</xs:documentation>
					</xs:annotation>
				</xs:element>
			</xs:choice>
		</xs:sequence>
	</xs:complexType>
	<!-- publish content request type -->
	<xs:complexType name="PublishContentRequestType">
		<xs:sequence>
			<xs:element name="AgreementId" type="ID">
				<xs:annotation>
					<xs:documentation>The agreement id</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="ContentMetadata" type="PropertyCollType">
				<xs:annotation>
					<xs:documentation>The content metadata</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="ContentData" type="ContentDataCollType">
				<xs:annotation>
					<xs:documentation>The content data collection</xs:documentation>
				</xs:annotation>
			</xs:element>
		</xs:sequence>
	</xs:complexType>
	<!-- content data collection -->
	<xs:complexType name="ContentDataCollType">
		<xs:sequence>
			<xs:element name="AttachmentId" type="ID" maxOccurs="unbounded">
				<xs:annotation>
					<xs:documentation>The attachment id</xs:documentation>
				</xs:annotation>
			</xs:element>
		</xs:sequence>
	</xs:complexType>
	<!-- content property collection -->
	<xs:complexType name="PropertyCollType">
		<xs:sequence>
			<xs:element name="Property" type="PropertyType" minOccurs="0" maxOccurs="unbounded">
				<xs:annotation>
					<xs:documentation>The content property</xs:documentation>
				</xs:annotation>
			</xs:element>
		</xs:sequence>
	</xs:complexType>
	<!-- content property -->
	<xs:complexType name="PropertyType">
		<xs:sequence>
			<xs:element name="Name" type="xs:string">
				<xs:annotation>
					<xs:documentation>The property name</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="Value" type="xs:string">
				<xs:annotation>
					<xs:documentation>The property value</xs:documentation>
				</xs:annotation>
			</xs:element>
		</xs:sequence>
	</xs:complexType>
	<!-- event type -->
	<xs:simpleType name="EventType">
		<xs:restriction base="xs:string">
			<xs:enumeration value="Publish Content"/>
		</xs:restriction>
	</xs:simpleType>
	<!-- SFDC ID type -->
	<xs:simpleType name="ID">
		<xs:restriction base="xs:string">
			<xs:length value="18"/>
			<xs:pattern value="[a-zA-Z0-9]{18}"/>
		</xs:restriction>
	</xs:simpleType>
</xs:schema>
