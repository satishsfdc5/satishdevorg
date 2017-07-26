public class Chapter6 {

  /** Listing 6-1
    SELECT Name, Account__r.Name
      FROM Proj__c
   */

  /** Listing 6-2
    SELECT Name, Account__r.Name
      FROM Proj__c
      WHERE Account__c != null
   */
  
  /** Listing 6-3
    SELECT Id, Name,
      (SELECT Id FROM Projects__r WHERE Status__c = 'Yellow')
      FROM Account
   */

  /** Listing 6-4
    SELECT Id, Name
      FROM Account
      WHERE Id IN
        (SELECT Account__c FROM Proj__c WHERE Status__c = 'Yellow')
   */
  
  /** Listing 6-5
    SELECT Id, Name
      FROM Account
      WHERE Id NOT IN
        (SELECT Account__c FROM Proj__c WHERE Status__c = 'Green')
   */
  
   /** Listing 6-6
     SELECT Id, Name
       FROM Proj__c
       WHERE Requested_Skills__c INCLUDES ('Apex;Java;C#', 'Python')
    */

  public static void listing6_7() {
    List<List<SObject>> result = [
                                  FIND 'Chicago'
                                  RETURNING Proj__c(Name), Resource__c(Name)
                                  ];
    List<Proj__c> projects = (List<Proj__c>)result[0];
    for (Proj__c project : projects) {
      System.debug('Project: ' + project.Name);
    }
    List<Resource__c> resources = (List<Resource__c>)result[1];
    for (Resource__c resource : resources) {
      System.debug('Resource: ' + resource.Name);
    }
  }

  public static void listing6_8() {
    Resource__c tim = [ SELECT Id
                        FROM Resource__c
                        WHERE Name = 'Tim Barr' LIMIT 1 ];
    Skill__c skill1 = new Skill__c(Resource__c = tim.Id,
        Type__c = 'Java', Rating__c = '3 - Average');
    Skill__c skill2 = new Skill__c(Resource__c = tim.Id,
        Rating__c = '4 - Above Average');
    Skill__c[] skills = new  Skill__c[] { skill1, skill2 };
    Database.SaveResult[] saveResults =
      Database.insert(skills, false);
    for (Integer i=0; i<saveResults.size(); i++) {
      Database.SaveResult saveResult = saveResults[i];
      if (!saveResult.isSuccess()) {
        Database.Error err = saveResult.getErrors()[0];
        System.debug('Skill ' + i + ' insert failed: '
            + err.getMessage());
      } else {
        System.debug('Skill ' + i + ' insert succeeded: new Id = '
            + saveResult.getId());
      }
    }
  }

  static void printRecordCount() {
    System.debug([ SELECT count() FROM Resource__c ] + ' records');
  }

  public static void listing6_9() {
    printRecordCount();
    Savepoint sp = Database.setSavepoint(); 

    delete [ SELECT Id FROM Resource__c ];
    printRecordCount();

    Database.rollback(sp); 
    printRecordCount();
  }

  public static void listing6_10() {
    Resource__c tim = [ SELECT Id, Hourly_Cost_Rate__c
                        FROM Resource__c
                        WHERE Name = 'Tim Barr' LIMIT 1
                        FOR UPDATE ];
    tim.Hourly_Cost_Rate__c += 20;
    update tim;
  }

  /** Listing 6-11
    SELECT ParentId, UserOrGroupId, AccessLevel
      FROM Proj__Share
      WHERE Parent.Name = 'GenePoint'
   */

  /** Listing 6-12
    SELECT Id, Type, RelatedId
      FROM Group
   */

  /** Listing 6-13
User tim = [ SELECT Id FROM User
             WHERE Name = 'Tim Barr' LIMIT 1 ];
Proj__c genePoint = [ SELECT Id FROM Proj__c
                      WHERE Name = 'GenePoint' LIMIT 1 ];
Proj__Share share = new Proj__Share(
    ParentId = genePoint.Id,
    UserOrGroupId = tim.Id,
    rowCause = Proj__Share.rowCause.My_Sharing_Reason__c,
    AccessLevel = 'Read');
insert share;
  */
  
  public static void listing6_14() {
    User you = [ SELECT Email
                 FROM User
                 WHERE Id = :UserInfo.getUserId()
                 LIMIT 1 ];
    Messaging.SingleEmailMessage mail =
      new Messaging.SingleEmailMessage(); 
    mail.setToAddresses(new String[] { you.Email });
    mail.setSubject('Test message');
    mail.setPlainTextBody('This is a test');
    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
  }

  /** Listing 6-15
User you = [ SELECT Email
             FROM User
             WHERE Id = :UserInfo.getUserId()
             LIMIT 1 ];
EmailTemplate template = [ SELECT Id
                           FROM EmailTemplate
                           WHERE DeveloperName = 'Test_Template'
                             LIMIT 1 ];
Messaging.SingleEmailMessage mail =
  new Messaging.SingleEmailMessage(); 
mail.templateId = template.Id;
mail.targetObjectId = you.Id;
mail.setSaveAsActivity(false);
Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
  */

  /** Listing 6-16
User you = [ SELECT Email
             FROM User
             WHERE Id = :UserInfo.getUserId()
             LIMIT 1 ];
EmailTemplate template = [ SELECT Id
                           FROM EmailTemplate
                           WHERE DeveloperName = 'Test_Template'
                             LIMIT 1 ];
Messaging.MassEmailMessage mail = new Messaging.MassEmailMessage();
mail.templateId = template.Id;
mail.targetObjectIds = new Id[] { you.Id };
mail.setSaveAsActivity(false);
Messaging.sendEmail(new Messaging.MassEmailMessage[] { mail }); 
  */
  
  /** Listing 6-17
global class MyEmailService implements
  Messaging.InboundEmailHandler {
  global Messaging.InboundEmailResult
    handleInboundEmail(Messaging.InboundEmail email,
      Messaging.InboundEnvelope envelope) {
  
   Messaging.InboundEmailResult result = new
      Messaging.InboundEmailresult();
    Messaging.SingleEmailMessage outbound = new
      Messaging.SingleEmailMessage();
    outbound.toAddresses = new String[] { email.replyTo };
    outbound.setSubject('Re: ' + email.subject);
    outbound.setHtmlBody('<p>This reply was generated by Apex.'
      + 'You wrote:</p><i>' + email.plainTextBody + '</i>');
    Messaging.sendEmail(new Messaging.SingleEmailMessage[]
      { outbound });
  
   return result;
  }
}
   */
  
  public static void listing6_18() {
    List<Resource__c> resources = Database.query('SELECT Id, Name FROM Resource__c');
    for (Resource__c resource : resources) {
      System.debug(resource.Id + ' ' + resource.Name);
    }
    List<SObject> projects = Database.query('SELECT Id, Name FROM Proj__c');
    for (SObject project : projects) {
      System.debug(project.get('Id') + ' ' + project.get('Name'));
    }
  }
  
  public static void listing6_19() {
    List<List<SObject>> result = Search.query(
        'FIND \'Chicago\' '
        + 'RETURNING Resource__c(Name), Proj__c(Name)');
    for (List<SObject> records : result) {
      for (SObject record : records) {
        System.debug(record.get('Name'));
      }
    }
  }

  public static void listing6_20() {
    Map<String, Schema.SObjectType> objects = Schema.getGlobalDescribe();
    Schema.DescribeSObjectResult objInfo = null;
    for (Schema.SObjectType obj : objects.values()) {
      objInfo = obj.getDescribe();
      System.debug(objInfo.getName() + ' [' + objInfo.getLabel() + ']');
    }
  }

  public static void listing6_21() {
    Map<String, Schema.SObjectField> fields = Schema.SObjectType.Proj__c.fields.getMap();
    Schema.DescribeFieldResult fieldInfo = null;
    for (Schema.SObjectField field : fields.values()) {
      fieldInfo = field.getDescribe();
      System.debug(fieldInfo.getName() 
          + ' [' + fieldInfo.getLabel() + '] ' 
          + fieldInfo.getType().name()
          + '(' + fieldInfo.getPrecision()
          + ', ' + fieldInfo.getScale() + ')');
    }
  }

  public static void listing6_22() {
    Schema.DescribeSObjectResult res = Resource__c.SObjectType.getDescribe(); 
    List<Schema.ChildRelationship> relationships = res.getChildRelationships(); 
    for (Schema.ChildRelationship relationship : relationships) {
      System.debug(relationship.getField() + ', ' + relationship.getChildSObject());
    }
  }

  public static void listing6_23() {
    Schema.DescribeFieldResult fieldInfo = Schema.SObjectType.Skill__c.fields.Type__c;
    List<Schema.PicklistEntry> picklistValues = fieldInfo.getPicklistValues();
    for (Schema.PicklistEntry picklistValue : picklistValues) {
      System.debug(picklistValue.getLabel());
    }
  }

  public static void listing6_24() {
    Schema.DescribeSObjectResult sobj = Resource__c.SObjectType.getDescribe();
    List<Schema.RecordTypeInfo> recordTypes = sobj.getRecordTypeInfos();
    for (Schema.RecordTypeInfo recordType : recordTypes) {
      System.debug(recordType.getName());
    }
  }

  /** Listing 6-25
trigger handleTimecardNotifications
  on Timecard__c (after update) {
  for (Timecard__c timecard : trigger.new) {
    if (timecard.Status__c !=
      trigger.oldMap.get(timecard.Id).Status__c &&
      (timecard.Status__c == 'Approved' ||
      timecard.Status__c == 'Rejected')) {
      Resource__c resource =
        [ SELECT Contact__r.Email FROM Resource__c
          WHERE Id = :timecard.Resource__c LIMIT 1 ];
      Proj__c project =
        [ SELECT Name FROM Proj__c
          WHERE Id = :timecard.Project__c LIMIT 1 ];
      User user = [ SELECT Name FROM User
          WHERE Id = :timecard.LastModifiedById LIMIT 1 ];
      Messaging.SingleEmailMessage mail = new
        Messaging.SingleEmailMessage();
      mail.toAddresses = new String[]
        { resource.Contact__r.Email };
      mail.setSubject('Timecard for '
        + timecard.Week_Ending__c + ' on '
        + project.Name);
      mail.setHtmlBody('Your timecard was changed to '
        + timecard.Status__c + ' status by '
        + user.Name);
      Messaging.sendEmail(new Messaging.SingleEmailMessage[]
        { mail });
    }
  }
}
   */

    testmethod public static void test() {
      delete [ select Id from Resource__c where Name = 'Tim Barr' ];
      insert new Resource__c(Name = 'Tim Barr', Hourly_Cost_Rate__c = 100);

      listing6_7();
      listing6_8();
      listing6_9();
      listing6_10();
      printRecordCount();
      listing6_14();
      listing6_18();
      listing6_19();
      listing6_20();
      listing6_21();
      listing6_22();
      listing6_23();
      listing6_24();
    }
}