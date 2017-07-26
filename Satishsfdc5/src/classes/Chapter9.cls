public class Chapter9 {

    /** Listing 9-1
<?php
function dumpNote($note) {
  error_log(print_r($note, 1));
}
function ack($value) {
  return array('Ack' => value);
}
function notifications($data) {
  error_log('Notification from orgId: ' . $data->OrganizationId);
  if (is_array($data->Notification)) {
    $result = array();
    for ($i = 0; $i < count($data->Notification); $i++) {
      dumpNote($data->Notification[$i]->sObject);
      array_push($result, ack(true));
    }
    return $result;
  } else {
    dumpNote($data->Notification->sObject);
    return ack(true);
  }
}
ini_set("soap.wsdl_cache_enabled", "0");
$server = new SoapServer("workflowOutboundMessage.wsdl");
$server->addFunction("notifications");
$server->handle();
    */
    
    /** Listing 9-2
<ResultSet xsi:schemaLocation="urn:yahoo:maps
  http://api.local.yahoo.com/MapsService/V1/
  GeocodeResponse.xsd">
<Result precision="address">
<Latitude>37.555113</Latitude>
<Longitude>-122.300100</Longitude>
<Address>900 Concar Dr</Address>
<City>San Mateo</City>
<State>CA</State>
<Zip>94402-2600</Zip>
<Country>US</Country>
</Result>
</ResultSet>
    */

    /** Listing 9-3
public class YahooGeocode {
  public static List<Result> geocode(
    String street, String city, String state) {
    List<Result> result = new List<Result>();
    HttpRequest req = new HttpRequest();
    String url = 'http://local.yahooapis.com/MapsService/'
    + 'V1/geocode?appid=YD-9G7bey8_JXxQP6rxl.fBFGgCdNjoDMACQA--'
    + '&street=' + EncodingUtil.urlEncode(street, 'UTF-8')
    + '&city=' + EncodingUtil.urlEncode(city, 'UTF-8')
    + '&state=' + EncodingUtil.urlEncode(state, 'UTF-8');
    req.setEndpoint(url);
    req.setMethod('GET');
    Http http = new Http();
    HTTPResponse res = http.send(req);
    XmlDom doc = new XmlDom(res.getBody());
    XmlDom.Element[] recs = doc.getElementsByTagName('Result');
    if (recs != null) {
      for (XmlDom.Element rec : recs) {
        result.add(elementToResult(rec));
      }
    }
    return result;
  }
  public static Result elementToResult(XmlDom.Element element) {
    Result r = new Result();
    r.latitude = element.getValue('Latitude');
    r.longitude = element.getValue('Longitude');
    r.address = element.getValue('Address');
    r.city = element.getValue('City');
    r.state = element.getValue('State');
    r.zip = element.getValue('Zip');
    r.country = element.getValue('Country');
    return r;
  }
  public class Result {
    public String latitude;
    public String longitude;
    public String address;
    public String city;
    public String state;
    public String zip;
    public String country;
    public String asString() {
      return address + ', ' + city + ', ' + state 
        + ', ' + zip + ', ' + country + ' ('
        + latitude + ', ' + longitude + ')';
    }
  }
}
    */
    
    /** Listing 9-4
for (YahooGeocode.Result result : YahooGeocode.geocode(
  '900 Concar Dr', 'San Mateo', 'CA')) {
  System.debug(result.asString());
}
    */
    
    /** Listing 9-5
BenchmarkWS.AnonymousBenchmark service = 
  new BenchmarkWS.AnonymousBenchmark();
BenchmarkWS.UtilizationEntry ue =
  new BenchmarkWS.UtilizationEntry();
ue.naicsCode= '541511';
ue.startDate = Date.parse('4/5/2009');
ue.endDate = Date.parse('4/11/2009');
ue.totalHours = 35;
ue.totalResources = 1;
ue.utilization = 88;
BenchmarkWS.SubmissionStatus[] results =
  service.submitUtilizationData(
    new BenchmarkWS.UtilizationEntry[] { ue });
if (results != null) {
  for (BenchmarkWS.SubmissionStatus result : results) {
    if (!result.success) {
      System.debug(result.errorMessage);
    }
  }
}
    */
    
    /** Listing 9-16
public class UtilizationController {
  public Timecard__c card1 { get; private set; }
  public Timecard__c card2 { get; private set; }
  public Boolean shared { get; set; }
  public Decimal utilization { get; private set; }
  public Decimal totalHours { get; private set; }
  public Integer totalResources { get; private set; }
  public UtilizationController() {
    card1 = new Timecard__c();
    card2 = new Timecard__c();
  }
  public PageReference calculate() {
    Date startDate = card1.Week_Ending__c;
    Date endDate = card2.Week_Ending__c;
    // assumes all resources are billable
    List<Resource__c> resources = [ SELECT Id FROM Resource__c
      WHERE Start_Date__c < :startDate ];
    List<Timecard__c> timecards = [ SELECT Week_Ending__c,
      Total_Hours__c FROM Timecard__c
      WHERE Billable__c = true AND
        Week_Ending__c >= :startDate AND
        Week_Ending__c <= :endDate
      ORDER BY Week_Ending__c ];
    totalHours = 0;
    if (timecards.size() == 0) {
      return null;
    }
    for (Timecard__c timecard : timecards) {
      totalHours += timecard.Total_Hours__c;
    }
    // adjust start and end dates to match timecard week endings
    Timecard__c firstTimecard = timecards.get(0);
    Timecard__c lastTimecard = timecards.get(timecards.size() - 1);
    if (startDate < firstTimecard.Week_Ending__c) {
      startDate = firstTimecard.Week_Ending__c.addDays(-6);
      card1.Week_Ending__c = startDate;
    }
    if (endDate > lastTimecard.Week_Ending__c) {
      endDate = lastTimecard.Week_Ending__c;
      card2.Week_Ending__c = endDate;
    }
    totalResources = resources.size();
    Long availableHours = totalResources *
      calculateAvailableHours(startDate, endDate);
    utilization = 100 * totalHours.divide(availableHours, 2);
    if (shared) {
      shareUtilization();
    }
    return null;
  }
  public static Long calculateAvailableHours(
    Date startDate, Date endDate) {
    BusinessHours bh = [ SELECT id FROM BusinessHours
      WHERE IsDefault = true ];
    DateTime startTime = DateTime.newInstance(
      startDate.year(), startDate.month(), startDate.day(),
      0, 0, 0); 
    DateTime endTime = DateTime.newInstance(
      endDate.year(), endDate.month(), endDate.day(),
      0, 0, 0);
    Decimal diff = Decimal.valueOf(
      BusinessHours.diff(bh.id, startTime, endTime));
    return diff.divide(3600000, 0).round();
  }
  private void shareUtilization() {
    BenchmarkWS.AnonymousBenchmark service =
      new BenchmarkWS.AnonymousBenchmark();
    BenchmarkWS.UtilizationEntry ue =
      new BenchmarkWS.UtilizationEntry();
    ue.naicsCode= '541511';
    ue.startDate = card1.Week_Ending__c;
    ue.endDate = card2.Week_Ending__c;
    ue.totalHours = totalHours;
    ue.totalResources = totalResources;
    ue.utilization = utilization;
    BenchmarkWS.SubmissionStatus[] results =
      service.submitUtilizationData(
        new BenchmarkWS.UtilizationEntry[] { ue });
    if (results != null) {
      for (BenchmarkWS.SubmissionStatus result : results) {
        if (!result.success) {
          ApexPages.addMessage(new ApexPages.Message(
            ApexPages.Severity.ERROR, result.errorMessage));
        } else {
          ApexPages.addMessage(new ApexPages.Message(
            ApexPages.Severity.INFO,
            'Shared anonymous benchmark data'));
        }
      }
    }
  }
}
    */
    
    /** Listing 9-7
<apex:page controller="UtilizationController"
  tabStyle="Utilization__tab">
<apex:sectionHeader title="Services Manager"
  subtitle="Utilization" />
<apex:form >
<apex:pageMessages id="msgs" />
<apex:pageBlock id="util">
<apex:pageBlockButtons >
  <apex:commandButton action="{!calculate}"
    value="Calculate" rerender="msgs, util" />
</apex:pageBlockButtons>
<apex:pageBlockSection columns="1">
  <apex:pageBlockSectionItem >
    <apex:outputLabel value="Start Date" />
    <apex:inputField value="{!card1.Week_Ending__c}" />
  </apex:pageBlockSectionItem>
<apex:pageBlockSectionItem >
  <apex:outputLabel value="End Date" />
  <apex:inputField value="{!card2.Week_Ending__c}" />
</apex:pageBlockSectionItem>
<apex:pageBlockSectionItem >
  <apex:outputLabel value="Share Anonymously" />
  <apex:inputCheckbox value="{!shared}" />
</apex:pageBlockSectionItem>
<apex:pageBlockSectionItem >
  <apex:outputLabel value="Total Hours" />
  <apex:outputText value="{!totalHours}" />
</apex:pageBlockSectionItem>
<apex:pageBlockSectionItem >
  <apex:outputLabel value="Total Resources" />
  <apex:outputText value="{!totalResources}" />
</apex:pageBlockSectionItem>
<apex:pageBlockSectionItem >
  <apex:outputLabel value="Utilization (%)" />
  <apex:outputText value="{!utilization}" />
</apex:pageBlockSectionItem>
</apex:pageBlockSection>
</apex:pageBlock>
</apex:form>
</apex:page>
    */
                            
}