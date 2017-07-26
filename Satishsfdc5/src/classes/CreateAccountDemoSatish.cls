global class CreateAccountDemoSatish
{
    webservice static void CreateAcc(Id LocalId)
    {   
        
        //string localId = '001d000001fLjAp';
        String password = 'Thapasvi2010NY2A7ksru1YW8ect2tZXfLm87';
        String userName = 'demosatishorg@yahoo.com';
        
        List<Account> acct = new List<Account>();
        String sql = 'SELECT Name,SyncAccountId__c FROM Account WHERE ID=:localId ';
        acct = Database.Query(sql);
        system.debug('acct'+acct);
        
        partnerSoapSforceCom.Soap con = new partnerSoapSforceCom.Soap();
              
        partnerSoapSforceCom.LoginResult loginResult = con.login(username, password);    
        
        con.SessionHeader = new partnerSoapSforceCom.SessionHeader_element();
        con.endpoint_x =loginResult.ServerUrl;
        con.Sessionheader.sessionid = loginResult.sessionid;
        
        List<sobjectPartnerSoapSforceCom.sObject_x> sObjects = new List<sobjectPartnerSoapSforceCom.sObject_x>();           
        sobjectPartnerSoapSforceCom.sObject_x tmpObj = new sobjectPartnerSoapSforceCom.sObject_x();
        for(Account ac:acct)
        {
           
            tmpObj.type_x = 'Account';
            tmpObj.AccName= ac.Name;
            tmpObj.AccNumber= ac.SyncAccountId__c;            
            sObjects.add(tmpObj);
        }
        partnerSoapSforceCom.SaveResult[] results = con.create(sObjects); 
        system.debug('Result'+results); 
        System.debug('=====@@@@34@@@@@'+sObjects);          
    }
}