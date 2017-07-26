public class AccNewButtonPageController {
    Public List<Opportunity> opp {get;set;}
    public Account Acc {get; set;}
    public Id accid;
    
    //SK - Comments New Clone project
    public AccNewButtonPageController(ApexPages.StandardController sc){
       opp = new List<Opportunity>();
       Acc = new Account();
       
    }
    
    public void addRow(){
        opp.add(new opportunity());
    }
	
    public pageReference doSave(){
        system.debug('AccName' + acc.Name);
        Account newacc = new Account();
        newacc.name=acc.Name;
        newacc.type = acc.Type;
        newacc.Industry = acc.Industry;
        newacc.Website = acc.Website;
        insert newacc;
        
        accid = newacc.id;
        List<Opportunity> opptoInsert = new List<Opportunity>();
        for(Opportunity op:opp){
        Opportunity newopp = new Opportunity();
        newopp.name = op.Name;
        newopp.AccountId = accid;
        newopp.StageName = op.StageName;
        newopp.CloseDate = op.CloseDate;
        opptoInsert.add(newopp);
        }
        insert opptoInsert;
        
        PageReference pageref = new PageReference('/'+accid);
        return pageref;
    }
}