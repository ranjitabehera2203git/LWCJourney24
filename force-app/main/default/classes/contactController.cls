public with sharing class contactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactsForDatatable() {
        return [Select Id, Name, Title, Phone, Email, Icon__c, Rank__C, AccountId, Account.Name from Contact Where AccountId != null LIMIT 10 ];
    }
}