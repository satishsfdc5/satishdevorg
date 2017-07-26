trigger HandleOrderUpdate on Invoice__c (after update) {
    
  /*  //Create Map of IDs to all old versions of records 
    Map<Id,invoice__c> oldMap = new Map<Id,Invoice__c>(Trigger.old);
    
    //Create List of Ids
    List<ID> invoiceids = new List<ID>();
    
    //Iterate through the list of new version on Invoice__c
    for(Invoice__c invoice : Trigger.new){
        if(invoice.status__c == 'Closed' && oldMap.get(Invoice.id).status__c!= 'Closed'){
            invoiceids.add(invoice.id);
        }
    }
    
    //If Invoice ids not null call Future Method IntegrationHeroku.PostOrder
    if(invoiceids.size()>0){
        IntegrationHeroku.postOrder(invoiceids);
    }*/
    Set<ID> invids = new set<ID>();
    for(Invoice__C inv :Trigger.New){
       if(inv.Total_Loss__c == True){
           invids.add(inv.id);
       }
    }
    List<Line_Item__c> liupdate = new List<Line_Item__c>();
    for(Line_Item__c li : [select id,Invoice__c,Status__C from Line_Item__c where Invoice__c IN: invids]){
        Line_Item__c liadd = new Line_Item__c();
        liadd.id = li.id;
        liadd.status__c = 'Completed';
        liupdate.add(liadd);
    }
    update liupdate;
}