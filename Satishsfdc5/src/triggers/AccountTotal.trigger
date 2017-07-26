/*****************************************************************************************************************************
Author       : Satish Kakarlapudi
Date Created : 25th August 2015
Description  : Trigger will fire on Account object after update. Total Amount in Account record will be divided equally among
			   contact child records and will store value in Share field in Contact record.
			   Created Custom Field Total__C in Account Object.
			   Created Custom Field Share__C in Contact Object.
******************************************************************************************************************************/
trigger AccountTotal on Account (after Update) {
    
//Stored Account Ids in Set to get Contact Records
Set<ID> accids = new set<ID>();
//Map to store Id of Account and Contacts size of each parent account
Map<Id,Integer> map2share = new Map<ID,Integer>();
//List to add updated Contract Records
List<Contact> ConToUpdate = new List<Contact>();
    for(Account acc : trigger.new){
        accids.add(acc.id);        
    }
    
 //AggregateResult to get count of contacts in each account.
 List<AggregateResult> totalcontacts = [select accountid,count(id) ids from contact where accountid In : accids group by accountId];
    for(AggregateResult agr : totalcontacts){
        map2share.put((ID) agr.get('accountid'),(Integer) agr.get('ids'));
    }
    for(contact con : [select id,accountId,account.total__C,share__C from contact where accountId IN : accids]){
        	contact conAdd = new contact();
        	conAdd.id = con.id;
        	//I used conditional Ternary operator if Total field in account record is null.
        	conAdd.Share__c = con.account.total__C==Null? 0.00 : con.account.total__C / map2Share.get(con.AccountId);
        	conToUpdate.add(conAdd);       
    }
    if(conToUpdate.size()>0)
   	Update conToUpdate;
}