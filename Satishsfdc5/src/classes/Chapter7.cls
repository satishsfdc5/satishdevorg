public class Chapter7 {

    /** Listing 7-1
<apex:page controller="MyPageController">
  <apex:form >
    Your name: <apex:inputText value="{!name}" />
    <apex:outputText value="{!message}" />
    <apex:commandButton action="{!hello}" value="Say Hi" />
  </apex:form>
</apex:page>
    */
    
    /** Listing 7-2
public class MyPageController {
public String name { get; set; }
  public String message { get; private set; }
  public PageReference hello() {
    message = 'Hello, ' + name;
    return null;
  }
}
    */
    
    /** Listing 7-3
<apex:page standardController="Proj__c">
  The current project is: {!Proj__c.Name}
  <apex:form >
    <apex:commandButton action="{!edit}" value="Edit {!Proj__c.Name}" />
    <apex:commandButton action="{!list}" value="Go To List" />
  </apex:form>
<apex:page>
    */
    
    /** Listing 7-4
<apex:page standardController="Proj__c" recordSetVar="projects">
  <apex:repeat value="{!projects}" var="p">
    {!p.Name}<br />
  </apex:repeat>
</apex:page>
    */
    
    /** Listing 7-5
public class MyPageController {
  public Proj__c proj { get; private set; }
  public MyPageController() {
    proj = [ SELECT Name, Account__r.BillingCity FROM Proj__c
      WHERE Name = 'Tim Barr' LIMIT 1 ];
  }
}
    */
    
    /** Listing 7-6
public class MyPageController {
  public List<ResourceWrapper> resources { get; set; }
  public MyPageController() {
    resources = new List<ResourceWrapper>();
    List<Resource__c> records = [ SELECT Name FROM Resource__c ]; 
    for (Resource__c record : records) {
      resources.add(new ResourceWrapper(record));
    }
  }
  public PageReference doSomething() {
    for (ResourceWrapper wrapper : resources) {
      if (wrapper.selected) {
        System.debug(wrapper.data.Id);
      }
    }
  return null;
  }
  class ResourceWrapper {
    public Resource__c data { get; private set; }
    public Boolean selected { get; set; }
    public ResourceWrapper(Resource__c data) {
      this.data = data;
      this.selected = false;
    }
  }
}
    */
    
    /** Listing 7-7
 <apex:page controller="MyPageController">
<apex:form >
  <apex:pageBlock title="Sample Code">
    <apex:pageBlockButtons >
      <apex:commandButton action="{!doSomething}"
        value="Do Something" />
    </apex:pageBlockButtons>   
    <apex:pageBlockTable
      value="{!resources}" var="resource">
      <apex:column headerValue="Selected">
        <apex:inputCheckbox value="{!resource.selected}" />
      </apex:column>
      <apex:column headerValue="Resource Name">
        {!resource.data.Name}
      </apex:column>
    </apex:pageBlockTable>
  </apex:pageBlock>
</apex:form>
</apex:page>
    */
    
    /** Listing 7-8
public MyController {
  private ApexPages.StandardController controller;
  public MyController(ApexPages.StandardController controller) { 
    this.controller = controller;
  }
  public PageReference doSomething() { return null; }
}
    */
    
    /** Listing 7-9
<apex:page standardController="Resource__c"
  extensions="MyPageController">
  <apex:form>
    <apex:commandButton action="{!doSomething}"
      value="Do Something" />
  </apex:form>
</apex:page>
    */
    
    /** Listing 7-10
<apex:dataList value="{!resources}" var="resource">
  <b>{!resource.Name}</b>
</apex:dataList>
    */
    
    /** Listing 7-11
<apex:form>
  <apex:inputField value="{!project.Stage__c}" />
</apex:form>
    */
    
    /** Listing 7-12
<apex:outputField value="{!project.Billable_Hours__c}" />
    */
    
    /** Listing 7-13
<apex:repeat value="{!Skills__r}" var="skill">
  <apex:outputField value="{!skill.Type__c}" />
</apex:repeat>
    */
    
    /** Listing 7-14
<apex:form>
  <apex:commandButton action="{!doSomething}"
    value="Do Something" />
</apex:form>
    */
    
    /** Listing 7-15
public class ForceStyledComponentsControllerExtension {
  private final List<Resource__c> resources;
  public ForceStyledComponentsControllerExtension(
    ApexPages.StandardSetController stdController) {
    this.resources = (List<Resource__c>)stdController.getRecords(); 
  }
  public PageReference initPage() {
    ApexPages.addMessage(new ApexPages.Message(
      ApexPages.Severity.INFO, 'pageMessages'));
    return null;
  }
}
    */
    
    /** Listing 7-16
<apex:page standardController="Resource__c"
  recordSetVar="resources"
  tabStyle="ForceStyledComponents__tab"
  extensions="ForceStyledComponentsControllerExtension"
  action="{!initPage}">
<apex:form >
<apex:sectionHeader title="sectionHeader.title"
  subtitle="subtitle"
  description="sectionHeader.description"
  help="http://developer.force.com" />
<apex:pageMessages />
<apex:pageBlock title="pageBlock.title"
  helpUrl="http://developer.force.com"
  helpTitle="pageBlock.helpTitle"> 
  <apex:pageBlockButtons >
    <apex:commandButton action="{!save}"
      value="pageBlockButtons 1"/>
    <apex:commandButton action="{!save}"
      value="pageBlockButtons 2" disabled="true" />
  </apex:pageBlockButtons>
  <apex:pageBlockTable var="r" value="{!resources}"
    title="pageBlockTable.title" rows="1">
    <apex:column >column 1</apex:column>
    <apex:column >column 2</apex:column>
    <apex:column >column 3</apex:column>
  </apex:pageBlockTable>
  <p />
  <apex:pageBlockSection title="pageBlockSection.title"
    columns="2">
    <apex:pageBlockSectionItem >
      <apex:outputPanel >Label1</apex:outputPanel>
      <apex:outputPanel >Field1</apex:outputPanel>
    </apex:pageBlockSectionItem>
    <apex:pageBlockSectionItem >
      <apex:outputPanel >Label2</apex:outputPanel>
      <apex:outputPanel >Field2</apex:outputPanel>
    </apex:pageBlockSectionItem>
  </apex:pageBlockSection>
</apex:pageBlock>
<p />
<apex:tabPanel switchType="client" selectedTab="name2"> 
  <apex:tab label="tab 1"
    name="name1">tabPanel tab 1</apex:tab> 
  <apex:tab label="tab 2"
    name="name2">tabPanel tab 2</apex:tab> 
</apex:tabPanel> 
<p />
<apex:toolbar >
  <apex:outputText >toolbar</apex:outputText>
  <apex:outputLink value="http://developer.force.com">
    outputLink 1</apex:outputLink>
  <apex:toolbarGroup itemSeparator="line" location="right">
    <apex:outputLink value="http://">outputLink 2</apex:outputLink>
    <apex:outputLink value="http://">outputLink 3</apex:outputLink>
  </apex:toolbarGroup> 
</apex:toolbar>
<p />
<apex:panelBar > 
  <apex:panelBarItem label="panelBarItem.label 1">panelBarItem 1
  </apex:panelBarItem> 
  <apex:panelBarItem label="panelBarItem.label 2">panelBarItem 3
  </apex:panelBarItem> 
  <apex:panelBarItem label="panelBarItem.label 3">panelBarItem 3
  </apex:panelBarItem>
</apex:panelBar> 
</apex:form>
</apex:page>
    */
    
    /** Listing 7-17
public class ForceUIComponentsController {
  public Resource__c subject { get; private set; }
  public ForceUIComponentsController() {
    subject = [ SELECT Id, Name
      FROM Resource__c LIMIT 1 ];
  }
}
    */
    
    /** Listing 7-18
<apex:page tabStyle="Force_com_UI_Components__tab"
  controller="ForceUIComponentsController">
<style>
.panel {
  background-image: none;
  background-color: #666666;
}
.panelActive {
  background-color: #38197A;
}
</style>
<apex:panelBar headerClass="panel" headerClassActive="panelActive"> 
  <apex:panelBarItem label="listViews">
    <apex:listViews type="Resource__c" />
  </apex:panelBarItem> 
  <apex:panelBarItem label="enhancedList">
    <apex:enhancedList type="Resource__c" height="300" />
  </apex:panelBarItem> 
  <apex:panelBarItem label="relatedList">
    <apex:relatedList subject="{!subject}" list="Skills__r" />
  </apex:panelBarItem>
  <apex:panelBarItem label="detail">
    <apex:detail subject="{!subject}" relatedList="false"
      title="false" />
  </apex:panelBarItem>
</apex:panelBar> 
</apex:page>
    */
    
    /** Listing 7-19
public with sharing class MyController {
  // the code in this controller honors record sharing rules
}
    */
    
    public static void listing7_20() {
		ApexPages.addMessage(new ApexPages.Message(
		  ApexPages.Severity.ERROR, 'Something went wrong'));
    }
    
    /** Listing 7-21
static testMethod void sampleTestMethod() {
  MyPageController controller = new MyPageController();
  PageReference page = new PageReference('MyPage');
  Test.setCurrentPage(page);
}
    */
    
    /** Listing 7-22
public class SkillsMatrixController {
  public String selectedResourceId { get; set; }
  public Boolean isEditable { get; private set; }
  public Resource__c selectedResource { get; private set; }
  public List<Skill__c> selectedSkills { get; private set; }
  public List<SelectOption> getResourceOptions() {
    List<SelectOption> options = new List<SelectOption>();
      options.add(new SelectOption(
        '', '-- Select Resource --'));
    List<Resource__c> resources = [ SELECT Id, Name
      FROM Resource__c ORDER BY Contact__r.LastName ];
    for (Resource__c resource : resources) {
      options.add(new SelectOption(resource.Id,
        resource.Name));      
    }
    return options;
  }
  public PageReference refresh() {
    if (selectedResourceId == null) {
      addError('Select a resource');
      return null;
    }
    selectedResource = [ SELECT Id, Name,
      User__r.UserRoleId,
      User__r.ProfileId,
      (SELECT Type__c, Rating__c, LastModifiedDate
        FROM Skills__r ORDER BY Rating__c DESC)
      FROM Resource__c
      WHERE Id = :selectedResourceId
      LIMIT 1 ];
    Set<String> skillTypes = new Set<String>();
    selectedSkills = new List<Skill__c>();
    for (Skill__c skill : selectedResource.Skills__r) {
      skillTypes.add(skill.Type__c);
      selectedSkills.add(skill);
    }
    Schema.DescribeFieldResult field = Skill__c.Type__c.getDescribe(); 
    String picklistValue = null;
    for (Schema.PicklistEntry entry : field.getPicklistValues()) {
      picklistValue = entry.getLabel();
      if (!skillTypes.contains(picklistValue)) {
        selectedSkills.add(
          new Skill__c(Resource__c = selectedResource.Id,
            Type__c = picklistValue));
      }
    }
    if (isManager()) {
       isEditable = true;
    } else {
      Resource__c userResource = getCurrentUserResource();
      isEditable = 
        selectedResource != null && userResource != null
        && selectedResource.Id == userResource.Id;
    }
    return null;
  }
  private void addError(String msg) {
    ApexPages.addMessage(new ApexPages.Message(
      ApexPages.Severity.ERROR, msg));
  }
  private void addInfo(String msg) {
    ApexPages.addMessage(new ApexPages.Message(
      ApexPages.Severity.INFO, msg));
  }
  public Resource__c getCurrentUserResource() {
    List<Resource__c> userResource = [ SELECT Id, Name,
      User__r.UserRoleId, User__r.ProfileId
      FROM Resource__c
      WHERE User__c = :UserInfo.getUserId()
      LIMIT 1 ];
    if (userResource.size() == 0) {
      addError('No resource associated with user');
      return null;
    } else {
      return userResource.get(0);   
    }
  }
  private Boolean isManager() {
    List<Profile> profiles = [ SELECT Id
      FROM Profile WHERE Name IN (
      'Project Manager', 'Vice President', 'System Administrator') 
      AND Id = :UserInfo.getProfileId() LIMIT 1 ];
    return profiles.size() == 1;
  }
  public PageReference save() {
    try {
      upsert selectedSkills;
      addInfo('Changes saved');
    } catch(DmlException e) {
      addError('Could not save changes: ' +e.getMessage());
    }
    return null;
  }
}
    */
    
    /** Listing 7-23    
<apex:page controller="SkillsMatrixController"
  tabStyle="Skill__c">
  <style>
  .resourceLabel { padding-right: 15px; }
  .goButton { margin-left: 10px; }
  </style>
  <apex:sectionHeader title="Services Manager"
    subtitle="Skills Matrix" />
  <apex:pageMessages />
  <apex:form id="form">
  <apex:outputLabel value="Resource:" for="selectedResourceId"
    styleClass="resourceLabel" />
  <apex:selectList id="selectedResourceId" title="Resource"
    value="{!selectedResourceId}" size="1">
    <apex:selectOptions value="{!resourceOptions}" />
  </apex:selectList>
  <apex:commandButton action="{!refresh}" value="Go!"
    styleClass="goButton" />
  <p />
  <apex:pageBlock title="Skills">
    <apex:pageBlockButtons >
      <apex:commandButton action="{!save}" value="Save"
        disabled="{!NOT isEditable}" />
    </apex:pageBlockButtons>
    <apex:pageBlockTable value="{!selectedSkills}" var="skill"
      rendered="{!selectedResourceId != ''}">
      <apex:column value="{!skill.Type__c}" />
      <apex:column headerValue="Rating">
        <apex:outputField value="{!skill.Rating__c}"
          rendered="{!NOT isEditable}" />
        <apex:inputField value="{!skill.Rating__c}"
          rendered="{!isEditable}" />
      </apex:column>
      <apex:column value="{!skill.LastModifiedDate}" />
    </apex:pageBlockTable>
  </apex:pageBlock>
  </apex:form>
</apex:page>
    */
    
    /** Listing 7-24
@isTest
private class TestSkillsMatrixController {
  static PageReference page;
  static SkillsMatrixController controller;
  static Resource__c barry, tim;
  static User barryUser, timUser;    
  static {
    delete [ SELECT Id FROM Resource__c ];
    timUser = [ SELECT Id FROM User WHERE Name = 'Tim Barr' LIMIT 1];
    barryUser = [ SELECT Id FROM User WHERE Name = 'Barry Cade' LIMIT 1];
    init();
  }
  private static void init() {
    barry = new Resource__c(Name = 'Barry');
    tim = new Resource__c(Name = 'Tim', User__c = timUser.Id);
    insert new Resource__c[] { barry, tim };
    Skill__c[] skills = new Skill__c[] {
      new Skill__c(Type__c = 'Java', Rating__c = '3',
        Resource__c = tim.Id) };
    insert skills;
    page = new PageReference('SkillsMatrix');
    Test.setCurrentPage(page);
    controller = new SkillsMatrixController();
  }
  static testMethod void testAsUser() {
    System.runAs(timUser) {
      init();
      controller.selectedResourceId = barry.Id;
      controller.refresh();
      System.assert(!controller.isEditable);
      controller.selectedResourceId = tim.Id;
      controller.refresh();
      System.assert(controller.isEditable);
    }
  }
  static testMethod void testNoResourceForUser() {
    System.runAs(barryUser) {
      init();
      controller.selectedResourceId = barry.Id;
      controller.refresh();
      System.assert(ApexPages.hasMessages(ApexPages.Severity.ERROR));
    }
  }
  static testMethod void testNoSkills() {
    controller.getResourceOptions();
    controller.selectedResourceId = barry.Id;
    controller.refresh();
    System.assert(controller.selectedSkills.size() > 0);
    System.assert(controller.isEditable);
  }
  static testMethod void testWithSkills() {
    controller.getResourceOptions();
    controller.selectedResourceId = tim.Id;
    controller.refresh();
    System.assert(controller.selectedSkills.size() > 0);
    System.assert(controller.selectedSkills.get(0).Type__c == 'Java');
  }
  static testMethod void testNoResourceSelected() {
    controller.selectedResourceId = null;
    PageReference ref = controller.refresh();
    System.assert(ApexPages.hasMessages());
  }
  static testMethod void testSave() {
    final String skillRating = '5 - Expert';
    controller.getResourceOptions();
    controller.selectedResourceId = barry.Id;
    controller.refresh();
    List<Skill__c> selectedSkills = controller.selectedSkills;
    Skill__c skill = selectedSkills.get(0);
    skill.Rating__c = skillRating;
    String skillType = skill.Type__c;
    controller.save();
    System.assert(ApexPages.hasMessages(ApexPages.Severity.INFO));
    Skill__c savedSkill = [ SELECT Rating__c FROM Skill__c
      WHERE Resource__c = :barry.Id AND
        Type__c = :skillType LIMIT 1 ];
    System.assert(savedSkill != null &&
      savedSkill.Rating__c == skillRating);
  }
}
    */
 
    testmethod public static void test() {
    	listing7_20();
    }
}