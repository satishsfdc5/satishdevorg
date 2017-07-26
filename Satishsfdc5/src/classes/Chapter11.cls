public class Chapter11 {

    /** Listing 11-1
Select Week_Ending__c, Total_Hours__c,
  (Select Status From ProcessInstances),
  (Select IsPending, StepStatus From ProcessSteps)
From Timecard__c
    */
    
    /** Listing 11-2
Approval.ProcessSubmitRequest req =
  new Approval.ProcessSubmitRequest();
req.setObjectId('a048000000BO4W3');
Approval.ProcessResult result = Approval.process(req);
System.debug(result.success);
    */
    
    /** Listing 11-3
Resource__c r = [ SELECT Hourly_Cost_Rate__c, CurrencyIsoCode
  FROM Resource__c WHERE Name = 'Priti Manek' LIMIT 1 ];
System.debug(r.Hourly_Cost_Rate__c + ' ' + r.CurrencyIsoCode);
r = [ SELECT convertCurrency(Hourly_Cost_Rate__c)
  FROM Resource__c WHERE Name = 'Priti Manek' LIMIT 1 ];
System.debug(r.Hourly_Cost_Rate__c);
    */
    
    /** Listing 11-4
SELECT StartDate, NextStartDate, IsoCode, ConversionRate
  FROM DatedConversionRate
    */
    
    /** Listing 11-5
public SAMLDemo() throws ConfigurationException {
  DefaultBootstrap.bootstrap();
  parser = new BasicParserPool();
  parser.setNamespaceAware(true);
  marshallerFactory = Configuration.getMarshallerFactory();
  unmarshallerFactory = Configuration.getUnmarshallerFactory();
  builderFactory = Configuration.getBuilderFactory(); 
}
    /** Listing 11-6               
private XMLObject buildXMLObject(QName objectQName)
  throws RuntimeException {
  XMLObjectBuilder builder = Configuration.getBuilderFactory().
    getBuilder(objectQName);
  if (builder == null) {
    throw new RuntimeException("Unable to retrieve builder for
      object QName " + objectQName);
  }
  return builder.buildObject(objectQName.getNamespaceURI(),
    objectQName.getLocalPart(), objectQName.getPrefix());
}
DateTime now = new DateTime();
IdentifierGenerator idGenerator =
  new SecureRandomIdentifierGenerator();
Subject subject = (Subject) buildXMLObject(
  Subject.DEFAULT_ELEMENT_NAME);
NameID nameID = (NameID) buildXMLObject(
  NameID.DEFAULT_ELEMENT_NAME);
nameID.setFormat(NameID.EMAIL);
nameID.setValue("paigeturner.dl@gmail.com");
subject.setNameID(nameID);
SubjectConfirmation conf = (SubjectConfirmation)
  buildXMLObject(SubjectConfirmation.DEFAULT_ELEMENT_NAME);
conf.setMethod("urn:oasis:names:tc:SAML:2.0:cm:bearer");
SubjectConfirmationData data = (SubjectConfirmationData)
  buildXMLObject(SubjectConfirmationData.DEFAULT_ELEMENT_NAME);
data.setRecipient("https://login.salesforce.com");
data.setNotOnOrAfter(now);
conf.setSubjectConfirmationData(data);
subject.getSubjectConfirmations().add(conf);
Assertion assertion = (Assertion)
  buildXMLObject(Assertion.DEFAULT_ELEMENT_NAME);
assertion.setVersion(SAMLVersion.VERSION_20);
assertion.setID(idGenerator.generateIdentifier());
assertion.setIssueInstant(now);
assertion.setSubject(subject);
    */
    
    /** Listing 11-7
Signature signature = (Signature) buildXMLObject(
  Signature.DEFAULT_ELEMENT_NAME);
signature.setSigningCredential(credential);
signature.setCanonicalizationAlgorithm(
  SignatureConstants.ALGO_ID_C14N_EXCL_OMIT_COMMENTS);
signature.setSignatureAlgorithm(
  SignatureConstants.ALGO_ID_SIGNATURE_RSA);
response.setSignature(signature);
Marshaller marshaller = marshallerFactory.getMarshaller(response);
marshaller.marshall(response);
Signer.signObject(signature);
Response signedResponse = (Response) unmarshallerFactory.getUnmarshaller(
  response.getDOM()).unmarshall(response.getDOM());
Marshaller m = marshallerFactory.getMarshaller(signedResponse);
Element generatedDOM = m.marshall(response, parser.newDocument());
BASE64Encoder be = new BASE64Encoder();
String xml = XMLHelper.nodeToString(generatedDOM);
return be.encode(xml.getBytes());
    */
    
    /** Listing 11-8
openssl pkcs8 -topk8 -nocrypt -in pk.pem -outform DER -out pk.der
openssl x509 -in cert.pem -inform PEM -out cert.crt -outform DER
    */
    
    /** Listing 11-9            
<html>
  <body>
    <form name="form" action="https://login.salesforce.com"
      method="post"> 
      <textarea name="SAMLResponse" rows="20" cols="80">
      </textarea>
      <input type="submit" value="Submit" />
    </form>
  </body>
</html>
    */
    
    /** Listing 11-10
<?php
function authenticated($value) {
  if ($value) {
    return array('Authenticated' => $value);
  } else {
    return null;
  }
}
function Authenticate($data) {
  error_log('Delegated authentication request for username ' .
    $data->username . ' from IP ' . $data->sourceIp);
  return authenticated(false);
}
ini_set("soap.wsdl_cache_enabled", "0");
$server = new SoapServer("AuthenticationService.wsdl");
$server->addFunction("Authenticate");
$server->handle();
    */
    
    /** Listing 11-11
<apex:component >
<apex:attribute name="mapData" type="String"
  required="true"
  description="JSON-encoded names and addresses
  to show on the Google map" />
<apex:includeScript value="http://maps.google.com/maps?
  file=api&v=2.x&key=APIKEY" />
<script>
var map = null;
var geocoder = null;
var markerList;
var addressList;
var nameList;
var currentIndex;
function finishShowMultipleAddresses() {
  var bounds = new GLatLngBounds();
  map.setCenter(new GLatLng(0,0), 0);
  for (var i=0; i<markerList.length; i++) {
    var marker = markerList[i];
    map.addOverlay(marker);
    bounds.extend(marker.getPoint());
  }
  map.setZoom(map.getBoundsZoomLevel(bounds));
  map.setCenter(bounds.getCenter());
}
function finishGeocode(point) {
  if (point) {
    var marker = new GMarker(point, {
      'title' : nameList[currentIndex].replace('&amp;', '&')
    });
    markerList.push(marker);
    currentIndex++;
    if (currentIndex == addressList.length) {
      finishShowMultipleAddresses();
    } else {
      geocoder.getLatLng(addressList[currentIndex], finishGeocode);
    }
  }
}
function initGMap() {
  if (GBrowserIsCompatible()) {
    map = new GMap2(document.getElementById("map_canvas"));
    if (geocoder == null) {
      geocoder = new GClientGeocoder();
    }
  }
}
function showMultipleAddresses(names, addresses) {
  initGMap();
  nameList = names;
  addressList = addresses;
  markerList = new Array();
  currentIndex = 0;
  if (geocoder) {
    geocoder.getLatLng(addresses[currentIndex], finishGeocode);
  }
}
function init() {
  var mapData = eval("(" + 
    document.getElementById("map_data").innerHTML + ")");
  showMultipleAddresses(mapData.names, mapData.addresses);
}
var previousOnload = window.onload;
window.onload = function() {
  if (previousOnload) {
    previousOnload();
  }
  init();
}
</script>
<div id="map_data" style="display: none">{!mapData}</div>
<div id="map_canvas" style="width: 300px; height: 300px"></div>
</apex:component>
    */
    
    /** Listing 11-12
<apex:page controller="ProjectMapController">
  <c:GoogleMultiMap mapData="{!projectLocationsJson}" />
</apex:page>
    */ 

    /** Listing 11-13
public class ProjectMapController {
  public String getProjectLocationsJson() {
    List<Proj__c> projects = [ SELECT Name,
      Account__r.BillingStreet, Account__r.BillingCity,
      Account__r.BillingState, Account__r.BillingPostalCode
      FROM Proj__c
      WHERE Stage__c = 'In Progress' ];
    String result = '{ names: [';
    Boolean first = true;
    for (Proj__c project : projects) {
      if (!first) {
        result += ', ';
      } else {
        first = false;
      }
      result += '\'' + project.Name.replace('\'', '\"') + '\'';
    }
    result += '], addresses: [';
    first = true;
    for (Proj__c project : projects) {
      if (!first) {
        result += ', ';
      } else {
        first = false;
      }
     result += '\'' +
       project.Account__r.BillingStreet + ' ' +
       project.Account__r.BillingCity + ' ' +
       project.Account__r.BillingState + ' ' +
       project.Account__r.BillingPostalCode + '\'';
    }
    result += '] }';
    return result;
  }
}
    */
 
     testmethod public static void test() {}
       
}