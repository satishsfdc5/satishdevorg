trigger ContactAVGUpdate on Contact (after insert) {
    set<ID> accids = new set<ID>();
    for(Contact con : trigger.new){
        accids.add(con.AccountId);
    }
    List<Account> accupdate = new List<Account>();
    AggregateResult[] results = [select accountId, avg(rating__C) ar from Contact where accountId IN:accids group by accountId];
    for(AggregateResult agr : results){
        Account acc = new Account();
        acc.id = (Id)agr.get('accountId');
        acc.AvgRating__C = (Decimal)agr.get('ar');
        accupdate.add(acc);
    }
    if(accupdate.size()>0)
    update accupdate;
}