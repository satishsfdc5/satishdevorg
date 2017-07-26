public class Consumer_Opp_Invoke {
    @future(Callout=true)
    public static void Consumer_Opp_Invoke_record(Id oppid){
        Opportunity OppRec = [select id,Name,CloseDate,StageName from Opportunity where Id=:oppid];
        Consumer_OPP_PartnerCLS_3.Soap consoap = new Consumer_OPP_PartnerCLS_3.Soap();
        Consumer_OPP_PartnerCLS_3.LoginResult conloginresult = consoap.Login('demosatishorg@yahoo.com','@Thapasvi10GiKYNhUw6GAV64nGGKrcvZyHA');
        Consumer_Opportunity_Cls.Publisher_Opportunity_Cls conopp= new Consumer_Opportunity_Cls.Publisher_Opportunity_Cls();
        conopp.sessionHeader = new Consumer_Opportunity_Cls.SessionHeader_element();
        conopp.sessionHeader.sessionId = conloginresult.sessionId;
        conopp.Publisher_Opp_Insert(OppRec.Name,OppRec.CloseDate,oppRec.StageName);
    }

}