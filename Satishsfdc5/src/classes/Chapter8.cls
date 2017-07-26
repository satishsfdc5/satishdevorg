public class Chapter8 {

    /** Listing 8-1
<apex:page controller="MyPageController">
  <apex:form >
    <apex:commandButton action="{!increment}" value="+1"
      reRender="result" />
    <apex:outputPanel id="result">The value is: {!value}
    </apex:outputPanel>
  </apex:form>
</apex:page>
    */
     
     /** Listing 8-2
public class MyPageController {
  public Integer value { get; private set; }
  public MyPageController() {
    value = 0;
  }
  public PageReference increment() {
    value++;
    return null;
  }
}
    */
    
    /** Listing 8-3
<apex:page controller="MyPageController">
  <apex:outputPanel id="result">
    <apex:pageMessages />
    <a onclick="timesTwoFunction('{!value}'); return false;">
      Run
    </a>
  </apex:outputPanel>
  <apex:form >
    <apex:actionFunction name="timesTwoFunction"
      action="{!timesTwo}" reRender="result">
      <apex:param name="arg1" value="" assignTo="{!value}" />
    </apex:actionFunction>
  </apex:form>
</apex:page>
    */
    
    /** Listing 8-4
public class MyPageController {
  public Integer value { get; set; }
  public MyPageController() {
    value = 1;
  }
  public PageReference timesTwo() {
    value *= 2;
    addInfo('The result is: ' + value);
    return null;
  }
  private void addInfo(String msg) {
    ApexPages.addMessage(new ApexPages.Message(
      ApexPages.Severity.INFO, msg));
  }
}
    */
    
    /** Listing 8-5
<apex:page controller="MyPageController">
  <apex:outputPanel id="result">
    <apex:pageMessages />
  </apex:outputPanel>
  <apex:form >
    <apex:actionPoller interval="5" action="{!timesTwo}"
      reRender="result" />
  </apex:form>
</apex:page>
    */
    
    /** Listing 8-6
<apex:page controller="MyPageController">
  <apex:outputPanel id="result">
    <apex:pageMessages />
  </apex:outputPanel>
  <apex:form >
    <apex:inputText >
      <apex:actionSupport action="{!timesTwo}"
        event="onfocus" reRender="result" />
    </apex:inputText>
  </apex:form>
</apex:page>
    */
    
    /** Listing 8-7
<apex:page controller="MyPageController">
  <apex:outputPanel id="result">
    <apex:pageMessages />
  </apex:outputPanel>
  <apex:actionStatus id="status"
    startText="Started" stopText="Stopped" />
  <apex:form >
    <apex:inputText >
      <apex:actionSupport action="{!timesTwo}"
        event="onfocus" reRender="result" status="status" />
    </apex:inputText>
  </apex:form>
</apex:page>
    */
    
    /** Listing 8-8
<apex:actionStatus id="status">
  <apex:facet name="stop">
    <h2>Stopped</h2>
  </apex:facet>
  <apex:facet name="start">
    <h2>Started</h2>
  </apex:facet>
</apex:actionStatus>
    */
    
    /** Listing 8-9
<apex:page controller="MyPageController">
  <script type="text/javascript">
    function start() {
      document.getElementById("myStatus").innerHTML = 'Started';
    }
    function stop() {
      document.getElementById("myStatus").innerHTML = 'Stopped';
    }
  </script>
  <apex:outputPanel id="result">
    <apex:pageMessages />
  </apex:outputPanel>
  <apex:actionStatus id="status"
    onStart="start();" onStop="stop();" />
  <div id="myStatus"></div>
  <apex:form >
    <apex:inputText >
      <apex:actionSupport action="{!timesTwo}"
        event="onfocus" reRender="result" status="status" />
    </apex:inputText>
  </apex:form>
</apex:page>
    */
    
    /** Listing 8-10
<apex:page >
  <hr />
  <apex:include pageName="SkillsMatrix" />
  <hr />
</apex:page>
    */
    
    /** Listing 8-11
<apex:page >
  <apex:insert name="header">
    <h1>Header</h1>
  </apex:insert>
  <hr /><apex:insert name="body" />
  <hr /><apex:insert name="footer" />
</apex:page>
    */
    
    /** Listing 8-12
<apex:page >
  <apex:composition template="MyPage">
    <apex:define name="header">
      Overriding the header content
    </apex:define>
    <apex:define name="body">
      This is the body content
    </apex:define>
    <apex:define name="footer">
      This is the footer content
    </apex:define>
  </apex:composition>
</apex:page>
    */
    
    /** Listing 8-13
<apex:component >
  <apex:attribute name="address" type="string" required="true"
    description="Address to show on the Google map" />
  <apex:includeScript
    value="http://maps.google.com/maps?file=api&v=2.x&key=..." />
  <script>
var map = null;
var geocoder = null;
function showAddress(address) {
  initGMap();
  if (geocoder) {
    geocoder.getLatLng(
      address,
      function(point) {
        if (point) {
          map.setCenter(point, 15);
          var marker = new GMarker(point);
          map.addOverlay(marker);
        }
      });
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
function init() {
  showAddress('{!address}');
}
var previousOnload = window.onload;
window.onload = function() { 
  if (previousOnload) { 
    previousOnload();
  }
  init();
}
</script>
<div id="map_canvas" style="width: 300px; height: 250px"></div>
</apex:component>
    */
    
    /** Listing 8-14
<apex:page >
<c:GoogleMap address="1 market st. san francisco, ca" />
</apex:page>
    */
    
    /** Listing 8-15                                            
<apex:page >
  <script type="text/javascript">
    function demo() {
      var component = document.getElementById(
        "{!$Component.myForm:myText}");
      alert('The value is ' + component.value);
    }
  </script>
  <apex:form id="myForm">
    <apex:inputText id="myText" />
    <a onclick="demo();">Run</a>
  </apex:form>
</apex:page>
    */
    
    /** Listing 8-16
<?xml version="1.0" encoding="utf-8"?>
<mx:Application xmlns:mx="http://www.adobe.com/2006/mxml"
  layout="absolute"
  xmlns:salesforce="http://www.salesforce.com/"
  creationComplete="login(event)">
  <salesforce:Connection id="apex" />
<mx:Script>
<![CDATA[
  import mx.collections.ArrayCollection;
  import mx.utils.ObjectUtil;
  import mx.controls.Alert;
  import com.salesforce.results.QueryResult;
  import com.salesforce.AsyncResponder;
  import com.salesforce.objects.LoginRequest;
  [Bindable]
  private var resourceList: ArrayCollection =
    new ArrayCollection();
  private function login(event: Event): void {
    var lr: LoginRequest = new LoginRequest();
    lr.server_url = parameters.server_url;
    lr.session_id = parameters.session_id;
    lr.callback = new AsyncResponder(loadData, handleFault);
    apex.login(lr);
  }
  private function handleFault(fault: Object): void {
    Alert.show(ObjectUtil.toString(fault));
  }
  private function loadData(lr: Object): void {
    apex.query("SELECT Id, Name, Home_Office__c, Region__c, " +
      "Hourly_Cost_Rate__c, Start_Date__c FROM Resource__c",
      new AsyncResponder(
        function(qr: QueryResult): void {
          if (qr.size > 0) {
            resourceList = qr.records;
          }
        }, handleFault)
    );
  }
  private function save(): void {
    apex.update(resourceList.toArray(),
      new AsyncResponder(handleUpdate, handleFault));
  }
  private function handleUpdate(result: Object): void {
    Alert.show(ObjectUtil.toString(result));
  }
  private function numericSortCompareFunction(
    obj1: Object, obj2: Object): int {
    return ObjectUtil.numericCompare(obj1 as Number,
      obj2 as Number);
  }
]]>
</mx:Script>
<mx:VBox height="100%" width="100%">
  <mx:HBox>
    <mx:Button label="Refresh" click="loadData(null);" />
    <mx:Button label="Save" click="save();" />
  </mx:HBox>
  <mx:DataGrid dataProvider="{resourceList}"
    editable="true" selectable="false"
    height="100%" width="100%">
    <mx:columns>
      <mx:DataGridColumn dataField="Name"/>
      <mx:DataGridColumn dataField="Home_Office__c"/>
      <mx:DataGridColumn dataField="Region__c"/>
      <mx:DataGridColumn dataField="Hourly_Cost_Rate__c"
        sortCompareFunction="numericSortCompareFunction" />
      <mx:DataGridColumn dataField="Start_Date__c"/>
    </mx:columns>
  </mx:DataGrid>
</mx:VBox>
</mx:Application>
    */
    
    /** Listing 8-17
<apex:page sidebar="false">
  <apex:flash src="{!$Resource.FlexDemo}"
    height="500" width="100%"
    flashvars="session_id={!$Api.Session_ID}
    &server_url={!$Api.Partner_Server_URL_150}" />
</apex:page>
    */
    
    /** Listing 8-18
public String getSessionId() {
  return UserInfo.getSessionId();
}
    */
    
    /** Listing 8-19
<object
  width="100%" height="500"
  codebase="https://fpdownload.macromedia.com/get
    /flashplayer/current/swflash.cab">
  <param name="movie" value="{!$Resource.FlexDemo}" />
  <param name="FlashVars"
    value="session_id={!$Api.Session_ID}&
      server_url={!$Api.Partner_Server_URL_150}" />
  <embed src="{!$Resource.FlexDemo}"
    width="100%" height="500"
    FlashVars="session_id={!$Api.Session_ID}&
      server_url={!$Api.Partner_Server_URL_150}"
    type="application/x-shockwave-flash">
  </embed>
</object>
    */
    
    /** Listing 8-20
public class CompareSkillsController {
  public String resourceId { get; set; }
  public String skill { get; set; }
  public List<Skill__c> getData() {
    return [ SELECT Resource__r.Name, Type__c, Rating__c
      FROM Skill__c
      WHERE Type__c = :skill
        AND Rating__c NOT IN ('', '0 - None') AND
        Resource__c != :resourceId
      ORDER BY Rating__c DESC ];
  }
}
    */
    
    /** Listing 8-21
<apex:component controller="CompareSkillsController">
  <apex:attribute name="skillType" description="Type of skill"
    type="String" required="true" assignTo="{!skill}" />
  <apex:attribute name="resourceId"
    description="Id of resource to compare with"
    type="String" required="true" assignTo="{!resourceId}" />
  <apex:pageBlock >
    <apex:pageBlockSection collapsible="false" columns="1">
      <apex:facet name="header">
        Other Resources with {!skillType}
        <span style="padding-left: 30px;">
          <a onclick="hideOverlay(); return false;"
          href="" style="text-decoration: underline;">Hide</a>
        </span>
      </apex:facet>
      <apex:pageBlockTable value="{!data}" var="item">
        <apex:column value="{!item.Resource__r.Name}" />
        <apex:column value="{!item.Rating__c}" />
      </apex:pageBlockTable>
    </apex:pageBlockSection>
  </apex:pageBlock>
</apex:component>
    */
    
    /** Listing 8-22
<apex:stylesheet   
  value="http://yui.yahooapis.com/combo?2.7.0/build/
    container/assets/skins/sam/container.css" />
<apex:includeScript
  value="http://yui.yahooapis.com/combo?2.7.0/build/
    yahoo-dom-event/yahoo-dom-event.js&2.7.0/build/animation/
    animation-min.js&2.7.0/build/container/container-min.js" /> 
<script>
var overlay;
function showOverlay(e) {
  overlay = new YAHOO.widget.Overlay(
    "{!$Component.compareSkills}", {
      xy:[525, e.pageY],
      visible:false, width:"450px", zIndex:1000,
      effect:{effect:YAHOO.widget.ContainerEffect.FADE,duration:0.25}
    }
  );
  overlay.render("{!$Component.form}");
  overlay.show();
}
function hideOverlay() {
  if (overlay != null) {
    overlay.hide();
    overlay = null;
  }
}
</script>
    */
    
    /** Listing 8-23
public PageReference refreshCompareSkills() {
  return null;
}
    */
    
    /** Listing 8-24
<apex:image value="/img/msg_icons/info16.png"
  style="margin-top: 2px; margin-right: 10px;">
  <apex:actionSupport event="onmouseover"
    action="{!refreshCompareSkills}" rerender="compareSkills"
    oncomplete="showOverlay(event);" onsubmit="hideOverlay();">
    <apex:param name="p1" value="{!skill.Type__c}"
    assignTo="{!selectedSkillType}" />
  </apex:actionSupport>
</apex:image>
    */
    
    /** Listing 8-25
<apex:outputPanel id="compareSkills" style="visibility: hidden;">
  <c:CompareSkillsComponent skillType="{!selectedSkillType}"
    resourceId="{!selectedResourceId}" />
</apex:outputPanel>
    */
            
}