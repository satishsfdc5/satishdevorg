/*****************************************************************************************************************************
Author       : Satish Kakarlapudi
Date Created : 25th August 2015
Description  : Test Class for Account object Trigger "AccountTotal"
******************************************************************************************************************************/
@isTest
public class AccountTotalTest {
    
    //Test method to test Account record with Total Field value
    static testMethod void test1(){
        Account acc = new account();
        acc.name = 'TestAcc';
        insert acc;
        
        Contact con = new contact();
        con.FirstName = 'Test';
        con.LastName = 'Contact';
        con.AccountId = acc.id;
        insert con;
       	
        Contact con1 = new contact();
        con1.FirstName = 'Test';
        con1.LastName = 'Contact1';
        con1.AccountId = acc.id;
        insert con1;
        
        Account accupdate = [select id,total__c from account where Id =:acc.id limit 1];
        accupdate.Total__c = 100;
        update accupdate;
        system.assertEquals(accupdate.Total__C,100);
        
        List<contact> conUpdate = [select id,share__C from contact where accountId =:acc.id];
        system.assertEquals(conupdate[0].share__C,50);
         
    }
	
    //Test Method to test Account Record when Total Field value is Null.
    static testMethod void test2(){
        Account acc = new account();
        acc.name = 'TestAcc';
        insert acc;
        
        Contact con = new contact();
        con.FirstName = 'Test';
        con.LastName = 'Contact';
        con.AccountId = acc.id;
        insert con;
       	
        Contact con1 = new contact();
        con1.FirstName = 'Test';
        con1.LastName = 'Contact1';
        con1.AccountId = acc.id;
        insert con1;
        
        Account accupdate = [select id,total__c from account where Id =:acc.id limit 1];
        update accupdate;
        system.assertEquals(accupdate.Total__C,Null);
        
        List<contact> conUpdate = [select id,share__C from contact where accountId =:acc.id];
        system.assertEquals(conupdate[0].share__C,0);
         
    }
}