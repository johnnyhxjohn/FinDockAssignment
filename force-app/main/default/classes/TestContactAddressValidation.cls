/**
 * TODO : Use stub api to run test as parallel, there is no need to make usage of inserts when it can be mocked
 */
@IsTest
public class TestContactAddressValidation {
    @IsTest
    public static void testBulkValidation() {
        List<Contact> contacts = new List<Contact>{
            new Contact(LastName='Doe', FirstName='Joe', MailingStreet='1428 Post Aly', MailingCity='Seattle', MailingPostalCode='98101', MailingCountry='US', MailingState='WA'),
            new Contact(LastName='Doe', FirstName='John', MailingStreet='De Bleek 7', MailingCity='Woerden', MailingPostalCode='3447 GV', MailingCountry='NL'),
            new Contact(LastName='Doe', FirstName='Joe', MailingStreet='Teststraat 1', MailingCity='Teststad', MailingPostalCode='1234 QA', MailingCountry='US', MailingState='WA'),
            new Contact(LastName='Doe', FirstName='Joe', MailingStreet='Teststraat 1', MailingCity='Teststad', MailingPostalCode='1234 QA', MailingCountry='NL')
        };
        insert contacts;

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('MockValidAddressUS');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        
        Test.startTest();
        List<Contact> updatedContacts = ContactAddressValidation.bulkAddressValidation(new Map<Id, Contact>(contacts).keySet());
        Assert.areEqual(2, updatedContacts.size());
        Test.stopTest();
        
    }

	@IsTest
    public static void testValidAddressUS() {
        Contact contact = createContact('Doe','Joe','1428 Post Aly','Seattle','98101','US','WA');
        
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('MockValidAddressUS');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        
        Test.startTest();
        contact = ContactAddressValidation.validateAddress(contact.Id);
        Test.stopTest();
        
        Assert.areEqual(true, contact.AddressValid__c);
    }
    
    @IsTest
    public static void testValidAddressITL() {
        Contact contact = createContact('Doe', 'John', 'De Bleek 7', 'Woerden', '3447 GV', 'NL', null);
        
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('MockValidAddressITL');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        
        Test.startTest();
        contact = ContactAddressValidation.validateAddress(contact.Id);
        Test.stopTest();
        Contact updatedContact = [SELECT AddressValid__c FROM Contact WHERE Id =: contact.Id];
        Assert.areEqual(true, updatedContact.AddressValid__c);
    }
    
    @IsTest
    public static void testInvalidAddressUS() {
        Contact contact = createContact('Doe', 'Joe', 'Teststraat 1', 'Teststad', '1234 QA', 'US', 'WA');
        
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('MockInvalidAddressUS');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        
        Test.startTest();
        contact = ContactAddressValidation.validateAddress(contact.Id);
        Test.stopTest();
        
        Assert.areEqual(false, contact.AddressValid__c);
    }
    
    @IsTest
    public static void testInvalidAddressITL() {
        Contact contact = createContact('Doe', 'Joe', 'Teststraat 1', 'Teststad', '1234 QA', 'NL', null);
        
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('MockInvalidAddressITL');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        
        Test.startTest();
        contact = ContactAddressValidation.validateAddress(contact.Id);
        Test.stopTest();
        
        Assert.areEqual(false, contact.AddressValid__c);
    }

    @IsTest
    public static void testRetrieveRelatedContacts() {
        Account account = new Account(Name = 'Test');
        insert account;

        Contact contact = new Contact(LastName='Doe', FirstName='Joe', MailingStreet='Teststraat 1', MailingCity='Teststad', MailingPostalCode='1234 QA', MailingCountry='NL', AccountId=account.Id);
        insert contact;

        Test.startTest();
        List<Contact> contacts = ContactAddressValidation.getRelatedContacts(account.Id);
        Test.stopTest();
        
        Assert.areEqual(1, contacts.size());
    }

    private static Contact createContact(String lastName, String firstName, String street, String city, String zipCode, String country, String state) {
        Contact contact = new Contact(LastName=lastName, FirstName=firstName, MailingStreet=street, MailingCity=city, MailingPostalCode=zipCode, MailingCountry=country, MailingState=state);
        insert contact;
        return contact;
    }
}