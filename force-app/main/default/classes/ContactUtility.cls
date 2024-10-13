public with sharing class ContactUtility {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts()
    {
        return [Select Id, FirstName, LastName, Phone, Email, PhotoUrl from Contact
         where PhotoUrl != null
         limit 10];
    }

    @AuraEnabled(cacheable=true)
    public static List<ContactWrapper> getConByAccountId(String accId)
    {
        List<ContactWrapper> lstWrapper = new List<ContactWrapper>();
        For(Contact con :  [ Select FirstName, LastName, Title, 
                                LeadSource, Email, Phone, AccountId,
                                (Select Id from Cases) 
                                from Contact Where AccountId =: accId])
                                {
                                    ContactWrapper wrapperObject = new ContactWrapper();
                                    wrapperObject.Id=con.Id;
                                    wrapperObject.FirstName=con.FirstName;
                                    wrapperObject.LastName=con.LastName;
                                    wrapperObject.Title=con.Title;
                                    wrapperObject.Email=con.Email;
                                    wrapperObject.Phone=con.Phone;
                                    wrapperObject.numberOfCases=con.Cases.size();
                                    if(con.phone == null)
                                    {
                                        wrapperObject.isBadContact=true;
                                    }
                                    else {
                                        wrapperObject.isBadContact=false;
                                    } 
                                    lstWrapper.add(wrapperObject);
                                }
                                return lstWrapper;
        
    }

    public class ContactWrapper{
        @AuraEnabled
        public String Id;
        @AuraEnabled
        public String FirstName;
        @AuraEnabled
        public String LastName;
        @AuraEnabled
        public String Title;
        @AuraEnabled
        public String Email;
        @AuraEnabled
        public String Phone;
        @AuraEnabled
        public Integer numberOfCases;
        @AuraEnabled
        public Boolean isBadContact;
    }
}