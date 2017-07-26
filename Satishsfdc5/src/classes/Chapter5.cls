public class Chapter5 {

    /** Listing 5-1
String helloWorld(String name) {
  return 'Hello, ' + name;
}
System.debug(helloWorld('Apex'));
    */
    
    public static void listing5_2() {
        Integer i;
    }
    
    /** Listing 5-3
Integer i;
String I;
    */
    
    /** Listing 5-4
Enum MyConstants { One, Two, Three }
MyConstants x = MyConstants.One;
    */

    public static void listing5_5() {
    	Integer i =123;
		Long l = i;
		Double d = l;
		Decimal dec = d;
    }    

    public static void listing5_6() {
    	String s = 'a0I80000003hazV';
		ID id = s;
		String s2 = id;
    }
    
    public static void listing5_7() {
		String s = '1234';
		Integer i = Integer.valueOf(s);
		Double d = Double.valueOf(s);
		Long l = Long.valueOf(s);
		Decimal dec = Decimal.valueOf(s);
    }

    /** Listing 5-8
String s = '1234.56';
Integer i = Integer.valueOf(s);
    */
    
    public static void listing5_9() {
		Decimal d = 123.456;
		Long rounded = d.round(RoundingMode.HALF_EVEN);
		Decimal divided = d.divide(3, 3, RoundingMode.HALF_EVEN);
		Decimal reducedScale = d.setScale(2, RoundingMode.HALF_EVEN);
    }

    public static void listing5_10() {
		Date d = Date.valueOf('2009-12-31');
		DateTime dt = DateTime.valueOf('2009-12-31 02:30:00');
		Time t = Time.newInstance(2,30,0,0);
    }

    public static void listing5_11() {
		DateTime dt = DateTime.valueOf('2009-12-31 00:00:00');
		System.debug(dt.format('E MMM dd, yyyy'));
    }
    
    public static void listing5_12() {
		List<String> stringList = new List<String>();
		stringList.add('Hello');
    }

    public static void listing5_13() {
		String[] stringArray = new String[5];
		stringArray[0] = 'Hello';
    }

    public static void listing5_14() {
		List<List<String>> list2 = new List<List<String>>();
		List<String> childList = new List<String>();
		childList.add('value');
		list2.add(childList);
    }

    public static void listing5_15() {
		List<Integer> intList = new Integer[3];
		intList[0] = 123;
		intList.add(456);
		Integer[] intArray = new List<Integer>();
        intArray.add(456);
		intArray.set(0, 123);
    }
    
    public static void listing5_16() {
		Set<String> stringSet = new Set<String>();
		stringSet.add('abc');
		stringSet.add('def');
		System.debug(stringSet.contains('abc'));
    }
    
    public static void listing5_17() {
		Map<Integer, String> myMap = new Map<Integer, String>();
		myMap.put(123, 'abc');
		System.debug(myMap.get(123));
    }
    
    /** Listing 5-18
void testValue(Integer value) {
  if (value > 100) {
    System.debug('true');
  } else {
    System.debug('false');
  }
}
testValue(99);
testValue(101);
    */
    
    /** Listing 5-19
class MyException extends Exception {}
Timecard__c timecard = new Timecard__c();
try {
  insert timecard;
} catch (DMLException e) {
  throw new MyException('Could not create Timecard record: ' + e);
} finally {
  System.debug('Exiting timecard creation code');
}
    */
    
    /** Listing 5-20
Integer counter = 0;
void recursive() {
  if (counter < 100) {
    counter++;
    recursive();
  }
}
recursive();
    */
    
    /** Listing 5-21
@future
public static void asyncMethod(List<String> idsToProcess) {
// code block
}
    */
    
    public static void listing5_22() {    
		Resource__c resource = new Resource__c();
		resource.Name = 'Larry';
    }
    
    /** Listing 5-23
      Contact c = new Contact();
	  c.FirstName = 'Larry';
	  resource.Contact__r = c;
    */
    
    public static void listing5_24() {
		Contact c = new Contact();
		c.LastName = 'Larry';
    }
 
    /** Listing 5-25
      SELECT Id, Name
        FROM Account
    */
    
    /** Listing 5-26
      SELECT Name
        FROM Account
        WHERE AnnualRevenue > 100000000
        AND Type = 'Customer - Direct'
        AND LastModifiedDate = THIS_YEAR
    */
    
    /** Listing 5-27
      SELECT Name, Type
        FROM Account
        WHERE LastModifiedDate = TODAY
        LIMIT 10
    */
    
    /** Listing 5-28
      SELECT Name, Type, AnnualRevenue
        FROM Account
        ORDER BY Type, LastModifiedDate DESC
    */
    
    /** Listing 5-29 
      SELECT Name, Contact__r.MailingCity, Contact__r.CreatedBy.Name
        FROM Resource__c
        WHERE Contact__r.MailingState = 'IL'
    */
    
    /** Listing 5-30
      SELECT Id, Name,
        (SELECT Total_Hours__c
          FROM Timecards__r
          WHERE Week_Ending__c = THIS_MONTH)
        FROM Resource__c
    */
    
    public static void listing5_31() {
		Decimal totalHours = 0;
		List<String> statuses = new String[] { 'Green', 'Yellow' };
		List<Proj__c> projects = [ SELECT Total_Billable_Hours_Invoiced__c
		  FROM Proj__c
		  WHERE Start_Date__c = THIS_YEAR and Status__c IN :statuses ];
		for (Proj__c project : projects) {
		  totalHours += project.Total_Billable_Hours_Invoiced__c;
		}
    }
    
    public static void listing5_32() { 
		Decimal totalHours = 0;
		for (Proj__c project : [ SELECT Total_Billable_Hours_Invoiced__c
		  FROM Proj__c
		  WHERE Start_Date__c = THIS_YEAR ]) {
		  totalHours += project.Total_Billable_Hours_Invoiced__c;
		}
    }
    
    public static void listing5_33() {
		try {
		  Contact c = new Contact(FirstName = 'Justin', LastName = 'Case');
		  insert c;
		  Resource__c r = new Resource__c(
		    Contact__c = c.Id, Hourly_Cost_Rate__c = 75, Region__c = 'West');
		  insert r;
		} catch (DmlException e) {
		  System.debug(LoggingLevel.ERROR, e.getMessage());
		}
    }
    
    public static void listing5_34() {
		Resource__c doug = new Resource__c(Name = 'Doug Hole');
		insert doug;
		doug.Hourly_Cost_Rate__c = 100;
		doug.Home_Office__c = 'London';
		update doug;
    }

    public static void listing5_35() {
		Resource__c r = new Resource__c(Resource_ID__c = 1001, Name = 'Terry Bull');
		upsert r Resource_ID__c;
    }

    public static void listing5_36() {
		Resource__c terry = new Resource__c(Name = 'Terry Bull');
		insert terry;
		delete terry;
    }
    
    /** Listing 5-37
undelete terry;
Resource__c terry2 = [ SELECT Id, Name
  FROM Resource__c WHERE Name like 'Terry%' LIMIT 1 ];
System.debug(terry2.Name + ' exists');
delete terry;
    */    

    /** Listing 5-38
trigger validateTimecard on Timecard__c (before insert, before update) {
  // code block
}
    */
    
    /** Listing 5-39
List<Resource__c> toInsert = new List<Resource__c>();
for (Contact contact : contacts) {
  toInsert.add(new Resource__c(
    Name = contact.FirstName + ' ' + contact.LastName));
}
insert toInsert;
    */
        
    /** Listing 5-40
public class MyClass {}
MyClass c = new MyClass();
List<MyClass> myList = new List<MyClass>();
myList.add(c);
    */
    
    /** Listing 5-41
Integer memberVar;
static Integer classVar;
static final Integer CONSTANT = 1;
    */
    
    /** Listing 5-42
void doNothing() {}
void doNothingWithArgs(String a, Integer b, Date c) {}
void returnsNothing() { Integer i = 1; }
Integer returnsInteger() { return 2009; }
    */
    
    /** Listing 5-43
private Integer cost;
public Integer getCost() { return cost; }
public void setCost(Integer cost) { this.cost = cost; }
    */
    
    /** Listing 5-44 
public Integer cost { get { return cost; } set { this.cost = value; } }
    */
    
    /** Listing 5-45
public Integer cost { get; set; }
    */
    
    /** Listing 5-46
public Integer readOnly { get; private set; }
public Integer writeOnly { private get; set; }
    */
    
    /** Listing 5-47
public class MyClass {
  String x;
  Integer y;
  MyClass(String a, Integer b) {
    this.x = a;
    this.y = b;
  }
}
MyClass c = new MyClass('string', 123);
    */
    
    /** Listing 5-48        
public class MyClass {
  String x, y, z;
  MyClass() { x = 'value'; }
  MyClass(String y) { this(); this.y = y; }
  MyClass(String y, String z) { this(y); this.z = z; }
}
MyClass c = new MyClass('a', 'b');
System.debug(c.x + ', ' + c.y + ', ' + c.z);
    */
    
    /** Listing 5-49
public class MyClass {
  {
    System.debug('Instance initializer');
  }
  MyClass() {
    System.debug('Constructor');
  }
}
new MyClass();
    */
    
    /** Listing 5-50            
public class MyClass {
  String x;
  class MyInnerClass {
    String y;
    void doSomething() {
      // cannot access x from here!
    }
  }
}
    */
     
     /** Listing 5-51      
public interface MyInterface {
  void doSomething(String thing);
}
public class MyClass implements MyInterface {
  public void doSomething(String x) {
}
    */
    
    /** Listing 5-52
public virtual class MyParentClass {
  public virtual void doSomething() {
    System.debug('something');
  }
}
public class MyClass extends MyParentClass {
  public override void doSomething() {
    super.doSomething();
    System.debug('something else');
  }
}
new MyClass().doSomething();
    */
    
    /** Listing 5-53
public abstract class MyBaseClass {
  public abstract void doSomething();
}
public class MyClass extends MyBaseClass {
  public override void doSomething() {
    System.debug('something');
  }
}
new MyClass().doSomething();
    */

    /** Listing 5-54
public class ClassA {}
public class ClassB extends ClassA {}
public class ClassC extends ClassB {}
public class Overloaded {
  public void doSomething(ClassA a) {
    System.debug('something with A');
  }
  public void doSomething(ClassB b) {
    System.debug('something with B');
  }
}
new Overloaded().doSomething(new ClassA());
new Overloaded().doSomething(new ClassB());
// new Overloaded().doSomething(new ClassC());
    */
    
    /** Listing 5-55
List<ClassA> newList = new List<ClassA>();
newList.add(new ClassA());
newList.add(new ClassB());
newList.add(new ClassC());
System.debug(newList.get(2) instanceof ClassB);
    */
    
    /** Listing 5-56
static testMethod void negativeTest() {
  Integer i = 2 + 2;
  System.assert(i == 4);
  System.assert(i / 2 == 1);
}
    */
    
    /** Listing 5-57
trigger validateTimecard on Timecard__c (before insert, before update) {
  TimecardManager.handleTimecardChange(Trigger.old, Trigger.new);
}
    */
    
    /** Listing 5-58            
public class TimecardManager {
  public class TimecardException extends Exception {}
  public static void handleTimecardChange(List<Timecard__c> oldTimecards,
    List<Timecard__c> newTimecards) {
    Set<ID> resourceIds = new Set<ID>();
    for (Timecard__c timecard : newTimecards) {
      resourceIds.add(timecard.Resource__c);
    }
    List<Assignment__c> assignments = [ SELECT Id, Start_Date__c,
      End_Date__c, Resource__c FROM Assignment__c
      WHERE Resource__c IN :resourceIds ];
    if (assignments.size() == 0) {
      throw new TimecardException('No assignments');
    }
    Boolean hasAssignment;
    for (Timecard__c timecard : newTimecards) {
      hasAssignment = false;
      for (Assignment__c assignment : assignments) {
        if (assignment.Resource__c == timecard.Resource__c &&
          timecard.Week_Ending__c - 6 >= assignment.Start_Date__c &&
          timecard.Week_Ending__c <= assignment.End_Date__c) {
            hasAssignment = true;
            break;
        }
      }
      if (!hasAssignment) {
        timecard.addError('No assignment for resource ' + 
          timecard.Resource__c + ', week ending ' + 
          timecard.Week_Ending__c);
      }
    }
  }
}
    */
    
    /** Listing 5-59
@isTest
private class TestTimecardManager {
  private static ID resourceId, projectId;

  static {
    Resource__c resource = new Resource__c(Name = 'Bob');
    insert resource;
    resourceId = resource.Id;
    Proj__c project = new Proj__c(Name = 'Proj1');
    insert project;
    projectId = project.Id;
  }

  static testMethod void positiveTest() {
    Date weekEnding = Date.valueOf('2009-04-11');
    insert new Assignment__c(Project__c = projectId,
      Start_Date__c = weekEnding - 6, End_Date__c = weekEnding,
      Resource__c = resourceId);
    insert new Timecard__c(Project__c = projectId,
      Week_Ending__c = weekEnding, Resource__c = resourceId);
  }

  static testMethod void testNoAssignments() {
    Timecard__c timecard = new Timecard__c(Project__c = projectId,
      Week_Ending__c = Date.valueOf('2009-04-11'),
      Resource__c = resourceId);
    try {
      insert timecard;
    } catch (DmlException e) {
      System.assert(e.getMessage().indexOf('No assignments') > 0);
      return;
    }
    System.assert(false);
  }

  static testMethod void testNoValidAssignments() {
    Date weekEnding = Date.valueOf('2009-04-04');
    insert new Assignment__c(Project__c = projectId,
      Start_Date__c = weekEnding - 6, End_Date__c = weekEnding,
      Resource__c = resourceId);
    try {
      insert new Timecard__c(Project__c = projectId,
      Week_Ending__c = Date.today(), Resource__c = resourceId);
    } catch (DmlException e) {
      System.assert(e.getMessage().indexOf('No assignment for resource') > 0);
      return;
    }
    System.assert(false);
  }

  static testMethod void testBatch() {
    Date weekEnding = Date.valueOf('2009-04-11');
    insert new Assignment__c(Project__c = projectId,
      Start_Date__c =  weekEnding - 6, End_Date__c = weekEnding,
      Resource__c = resourceId);
    List<Timecard__c> timecards = new List<Timecard__c>();
    for (Integer i=0; i<200; i++) {
      timecards.add(new Timecard__c(Project__c = projectId,
        Week_Ending__c = weekEnding, Resource__c = resourceId));
    }
    insert timecards;
  }
}
    */
 
     testmethod public static void test() {
        listing5_2();
        listing5_5();
        listing5_6();
        listing5_7();
        listing5_9();
        listing5_10();
        listing5_11();
        listing5_12();
        listing5_13();
        listing5_14();
        listing5_15();
        listing5_16();
        listing5_17();
        listing5_22();
        listing5_24();
        listing5_31();
        listing5_32();
        listing5_33();
        listing5_34();
        listing5_35();
        listing5_36();
     }
                          
}