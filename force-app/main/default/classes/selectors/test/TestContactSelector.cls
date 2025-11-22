/**
 * TODO : Use stub api to run test as parallel, there is no need to make usage of inserts when it can be mocked
 */
@IsTest
public class TestContactSelector {

    @IsTest
    public static void whenSelectContactById() {
        Contact contact = new Contact(LastName='Doe', FirstName='Joe', MailingStreet='1428 Post Aly', MailingCity='Seattle', MailingPostalCode='98101', MailingCountry='US', MailingState='WA');
        insert contact;

        Test.startTest();
        Contact retrievedContact = ContactSelector.getContactById(contact.Id);
        Test.stopTest();

        Assert.areEqual(retrievedContact.Id, contact.Id);
        Assert.areEqual(retrievedContact.MailingStreet, contact.MailingStreet);
    }


    @IsTest
    public static void whenSelectContactByAccountId() {
        Account account = new Account(Name = 'Test');
        insert account;
        Contact contact = new Contact(LastName='Doe', FirstName='Joe',AccountId = account.Id, MailingStreet='1428 Post Aly', MailingCity='Seattle', MailingPostalCode='98101', MailingCountry='US', MailingState='WA');
        insert contact;

        Test.startTest();
        List<Contact> retrievedContact = ContactSelector.getContactsByAccountId(account.Id);
        Test.stopTest();

        Assert.areEqual(retrievedContact.size(), 1);
        Assert.areEqual(retrievedContact.get(0).AccountId, account.Id);
        Assert.areEqual(retrievedContact.get(0).Id, contact.Id);
    }


    @IsTest
    public static void whenSelectMultipleContactsById() {
        List<Contact> contacts = new List<Contact>{
            new Contact(LastName='Doe', FirstName='Joe', MailingStreet='1428 Post Aly', MailingCity='Seattle', MailingPostalCode='98101', MailingCountry='US', MailingState='WA'),
            new Contact(LastName='Doe', FirstName='John', MailingStreet='De Bleek 7', MailingCity='Woerden', MailingPostalCode='3447 GV', MailingCountry='NL'),
            new Contact(LastName='Doe', FirstName='Joe', MailingStreet='Teststraat 1', MailingCity='Teststad', MailingPostalCode='1234 QA', MailingCountry='US', MailingState='WA'),
            new Contact(LastName='Doe', FirstName='Joe', MailingStreet='Teststraat 1', MailingCity='Teststad', MailingPostalCode='1234 QA', MailingCountry='NL')
        };
        insert contacts;  
        
        Map<Id, Contact> contactsById = new Map<Id, Contact>(contacts);
        Test.startTest();
        List<Contact> retrievedContacts = ContactSelector.getContacts(contactsById.keySet());
        Test.stopTest();

        Assert.areEqual(retrievedContacts.size(), contacts.size());
    }
}