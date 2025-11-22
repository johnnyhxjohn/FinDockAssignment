public class ContactAddressValidation {
    @AuraEnabled
    public static List<Contact> getRelatedContacts(Id accountId) {
        return ContactSelector.getContactsByAccountId(accountId);
    }

    @AuraEnabled(cacheable=true)
    public static Contact getContactInfo(Id recordId) {
        return ContactSelector.getContactById(recordId);
    }

    @AuraEnabled
    public static Contact validateAddress(Id recordId) {
        Contact contact = ContactSelector.getContactById(recordId);
        AddressValidationService addressValidationService = new AddressValidationService();
        if(addressValidationService.validateAddress(contact)) {
            update contact;
        }
        return contact;
    }

    public static List<Contact> bulkAddressValidation(Set<Id> contactIds) {
        List<Contact> contacts = ContactSelector.getContacts(contactIds);
        AddressValidationService addressValidationService = new AddressValidationService();
        List<Contact> contactsToUpdate = addressValidationService.validateAddresses(contacts);
        update contactsToUpdate;
        return contactsToUpdate;
    }
}