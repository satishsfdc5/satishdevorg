@RestResource(urlMapping='/Account/*')
global with sharing class RestApiTestClass {

    @HttpPost
    global static void doPost(string name, string phone, string website){
        Account Acc = new Account();
        system.debug('APICalled');
        acc.Name = name;
        acc.Phone = phone;
        acc.Website = website;
        insert Acc;
        
    }
    
}