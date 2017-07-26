public class SampleComponentClass {
    @AuraEnabled
    public static List<Contact> getContacts(){
        return[select id,Name,Phone from Contact Limit 10];
    }

}