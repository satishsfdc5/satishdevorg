public class Chapter2 {

    /** Listing 2-1
      AND(
        NOT(
          ISNULL(Start_Date__c)
        ),
        NOT(
          ISNULL(End_Date__c)
        ),
        (Start_Date__c > End_Date__c)
      )
    */
    
    /** Listing 2-2
      Billable Revenue (Currency) = Week_Total_Hrs__c * Rate_Per_Hour__c
    */
    
    /** Listing 2-3
      SELECT Name, Total_Billable_Revenue_Pending_Invoice__c, Project_Status__c
        FROM Proj__c
        WHERE Invoiced__c = FALSE and Start_Date__c = LAST_QUARTER
        ORDER BY Total_Billable_Revenue_Pending_Invoice__c DESC LIMIT 10
    */
    
    /** Listing 2-4
      SELECT Orders.OrderId, OrderLineItems.LineItemId
        FROM Orders, OrderLineItems
        WHERE Orders.OrderId = OrderLineItems.OrderId
    */
    
    /** Listing 2-5
      SELECT OrderId, (SELECT LineItemId FROM OrderLineItems)
        FROM Orders
    */
    
    /** Listing 2-6
      FIND 'java*' IN ALL FIELDS
        RETURNING Project__c, Resource__c, Assignment__c, Skill__c
    */
    
    /** Listing 2-7
public void grantRaise(String resourceName, Decimal newRate) {
  Resource__c r = [ select Id, Hourly_Cost_Rate__c
      from Resource__c
      where Name = :resourceName limit 1 ];
  if (r != null) {
    r.Hourly_Cost_Rate__c = newRate;
    update r;
  }
}
    */    

    /** Listing 2-8
<?xml version="1.0" encoding="UTF-8"?>
<CustomObject xmlns="http://soap.sforce.com/2006/04/metadata">
    <deploymentStatus>Deployed</deploymentStatus>
    <fields>
        <fullName>Start_Date__c</fullName>
        <label>Start Date</label>
        <type>Date</type>
    </fields>
    <label>Project</label>
    <nameField>
        <label>Project Name</label>
        <type>Text</type>
    </nameField>
    <pluralLabel>Projects</pluralLabel>
    <searchLayouts/>
    <sharingModel>ReadWrite</sharingModel>
</CustomObject>
    */

    /** Listing 2-9
      FLOOR((TODAY() - Start_Date_in_Industry__c) / 365)
    */
    
    /** Listing 2-10
      IF (AND (Start_Date__c <= TODAY(), End_Date__c >= TODAY()) , "Yes", "No")      
    */
    
    /** Listing 2-11
      ISPICKVAL(Type__c, '')
    */
    
    /** Listing 2-12
      Sunday_Hours__c + Monday_Hours__c +
        Tuesday_Hours__c + Wednesday_Hours__c + 
        Thursday_Hours__c + Friday_Hours__c + 
        Saturday_Hours__c
    */
    
    /** Listing 2-13
      =VLOOKUP(A2, contact!$A$1:$B$32, 2, FALSE) 
    */
    
    /** Listing 2-14
      =VLOOKUP(A2, account!$A$1:$B$32, 2, FALSE)
    */
    
    /** Listing 2-15
NAME,ACTIVE__C,EDUCATION__C,HIGHEST_EDUCATION_LEVEL__C,
HOURLY_COST_RATE__C,HOME_OFFICE__C,REGION__C,START_DATE__C,START_DATE_IN_INDUSTRY__C,YEARS_OF_EXPERIENCE__C,CONTACT__C
Tim Barr,TRUE,University of Chicago,MS,100,Chicago,Central,2/3/2003,6/1/1983,,0038000000YzufcAAB
Rose Gonzalez,TRUE,St. Edwards University,BS,50,Austin,Central,5/15/2006,5/15/2006,,0038000000YzufXAAR
Josh Davis,TRUE,Cascade College,BS,40,Portland,West,7/1/2008,1/1/2005,,0038000000YzufhAAB
Jane Grey,TRUE,University of Arizona,PhD,120,Tucson,West,10/15/2004,3/1/1992,,0038000000YzufiAAB
Arthur Song,TRUE,Fordham University,MS,125,New York,East,6/28/2007,5/1/1979,,0038000000YzufjAAB
    */

    /** Listing 2-16
NAME,TYPE__C,START_DATE__C,END_DATE__C,BILLABLE_HOURS__C,CONSULTING_BUDGET__C,EXPENSE_BUDGET__C,INVOICED__C,LOCATION__C,PROJECT_ID__C,NOTES__C,STAGE__C,STATUS__C,STATUS_NOTES__C,ACCOUNT__C
GenePoint,Billable,1/12/2009,,800,200000,20000,FALSE,"Mountain View, CA",,Phase 2,In Progress,Green,,0018000000PAmpWAAT
Grand Hotels & Resorts Ltd,Billable,2/16/2009,,100,30000,0,FALSE,"Chicago, IL",,,In Progress,Green,,0018000000PAmpdAAD
United Oil & Gas Corp.,Billable,2/9/2009,,500,75000,10000,FALSE,"New York, NY",,,In Progress,Green,,0018000000PAmpgAAD
Burlington Textiles Corp of America,Billable,2/2/2009,,200,40000,5000,FALSE,"Burlington, NC",,,In Progress,Green,,0018000000PAmpaAAD
Express Logistics and Transport,Non-Billable,3/1/2009,,0,0,0,FALSE,"Portland, OR",,Presales,In Progress,Green,,0018000000PAmpeAAD
    */
 
     testmethod public static void test() {}
    
}