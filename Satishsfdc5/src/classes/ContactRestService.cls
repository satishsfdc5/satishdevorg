@RestResource(UrlMapping='/V.1/Contacts/*')
global with Sharing class ContactRestService {
    
    @HttpPost
    global static string doPost(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        string contactName = req.requestURI.subString(req.requestURI.lastIndexOf('/')+1);
        if(contactName == 'contacts'){
            return createContact(req);
        }else {
            return 'Invalid Operation';
        }
    }
    private static string createContact(RestRequest req){
        Account Acc = new Account();
        //get a Map of all fields in the contact object
       	Map<String,Schema.SobjectField> sobjfieldmap = Schema.SObjectType.Account.fields.getMap();
       	Acc.Name = req.params.get('accname');
        insert Acc;
        return Acc.id;
    }
    
    @HttpGet
    global static List<Contact> doGet(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        string contactName = req.requestURI.subString(req.requestURI.lastIndexOf('/')+1);
         if(contactName != 'contacts'){
             return getContact(contactName,req);
         }else {
             return getContacts(req);
         }
    }
    
    @HttpPut
    global static string doPut(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        string Id = req.requestURI.subString(req.requestURI.lastIndexOf('/')+1);
        system.debug('Id'+id);
        if(Id != 'contacts'){
            return updateContact(Id,req);
        }else {
            return 'Invalid Operation';
        }
    }
    
    @HttpDelete
    global static string doDelete(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        string Id = req.requestURI.subString(req.requestURI.lastIndexOf('/')+1);
        system.debug('Id'+id);
        if(Id != 'contacts'){
            return deleteContact(Id,req);
        }else {
            return 'Invalid Operation';
        }
    }
    
    private static List<Contact> getContact(String ContactName, RestRequest req){
        //default fields to Return
        String qryFields = 'Id,Name';
        
        //set fields to return
        if(req.params.containsKey('fields')) qryFields = req.params.get('fields');
        
        return Database.query('Select '+ qryFields + ' from Contact where Name = ' + ContactName);
        //return Database.query('select '+qryFields+ ' from contact');
    }
    
    private static List<contact> getContacts(RestRequest req){
        //default fields to return
        string qryFields = 'Id,Name';
        
        //default query limit
        string qryLimit = '100';
        
        //default Orderby
        string qryOrderby = '';
        
        //default where clause
        string qryWhere = '';
        
        //set the fields to return
        if (req.params.containsKey('fields')) qryFields = req.params.get('fields');
        system.debug('fields'+qryFields);
        //set the limit for records to return
        if(req.params.containsKey('limit')) qryLimit = 'limit ' + req.params.get('limit');
        system.debug('limit'+qryLimit);
        //set the order by
        if(req.params.containsKey('orderby')) qryorderby = 'Order by ' + req.params.get('orderby');
        //set the where clause to search by contactname
        if(req.params.containskey('search')) qryWhere = 'Where Name Like \'' + req.params.get('search') + '%\'';
        system.debug('search'+qryWhere);
        system.debug('query'+'select '+qryFields+ ' from Contact'+' ' +qryWhere + ' ' + qryorderby + ' ' + qryLimit);
  
       return Database.query('select '+qryFields+ ' from Contact' + ' ' +qryWhere + ' ' + qryorderby + ' ' + qryLimit);
                //return Database.query('select '+qryFields+ ' from contact');
    }
    
    private static string updateContact(String contactid , RestRequest req){
        Map<String,Schema.SObjectField> conFieldsMap = Schema.SObjectType.contact.fields.getMap();
        Set<string> noUpdateFields = new set<string>{'Name'};
        contact con;
        con =[select id from contact where id=:contactid];
        system.debug('conid'+con);
        for(string key : req.params.keyset()){
            if(conFieldsMap.containsKey(key) && !noUpdateFields.contains(key.toLowerCase()))
                con.put(key,req.params.get(key));
        }
        update con;
        return con.id;
    }
    
    private static string deleteContact(String contactid , RestRequest req){
        contact con;
        con =[select id from contact where id=:contactid];
        delete con;
        return 'Record ID : ' + contactid + ' is Deleted';
    }

}