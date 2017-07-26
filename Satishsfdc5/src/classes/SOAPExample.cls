public class SOAPExample{
    public string result{get;set;}
    string username = 'demosatishorg@yahoo.com';
    string password = '@Thapasvi10GiKYNhUw6GAV64nGGKrcvZyHA';
    public void Show(){
        PartnerSOAP.soap ps = new PartnerSOAP.soap();
        PartnerSOAP.LoginResult psession = ps.Login(username,password);
        EmployeeSOAP.SessionHeader_Element header = new EmployeeSOAP.SessionHeader_Element();
        header.sessionId = psession.sessionId;
        EmployeeSOAP.EmployeeData ed = new EmployeeSOAP.EmployeeData();
        ed.sessionHeader = header;
        result = ed.getName();        
    }
}