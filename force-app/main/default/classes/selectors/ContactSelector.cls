public with sharing class ContactSelector {

    public static List<Contact> getContacts(Set<Id> contactIds) {
        List<Contact> contacts = [SELECT Id, MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry, AddressValid__c FROM Contact WHERE Id IN:contactIds];
        return contacts;
    }

    public static Contact getContactById(Id contactId) {
        Contact contact = [SELECT Id, MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry, AddressValid__c FROM Contact WHERE Id =:contactId];
        return contact;        
    }

    public static List<Contact> getContactsByAccountId(Id accountId) {
        List<Contact> contacts = [SELECT Id, AccountId, MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry, AddressValid__c FROM Contact WHERE AccountId =:accountId];
        return contacts;
    }
}