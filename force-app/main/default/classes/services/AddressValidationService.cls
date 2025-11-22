/*
*   @desc
*   Class responsible to handle logics from callout responses/requests
*/
public with sharing class AddressValidationService {
    private final String COUNTRY_CODE_US = 'US';
    public AddressValidationService() {}

    public Boolean validateAddress(Contact contact) {
        String country = contact.MailingCountry;
        Boolean isUpdated = false;
        IAddressEntity addressValidation = (country == COUNTRY_CODE_US)
            ? AddressValidationCallout.validateAddressUS(contact.MailingStreet, contact.MailingCity, contact.MailingState)
            : AddressValidationCallout.validateAddressITL(contact.MailingStreet, contact.MailingPostalCode, country);
        Boolean isValid = (addressValidation != null) ? addressValidation.isValid() : false;

        if(contact.AddressValid__c != isValid) {
            contact.AddressValid__c = isValid;
            isUpdated = true;
        }        

        return isUpdated;
    }

    public List<Contact> validateAddresses(List<Contact> contacts) {
        List<Contact> contactsToUpdate = new List<Contact>();
        for(Contact contact : contacts) {
            if(validateAddress(contact)) {
                contactsToUpdate.add(contact);
            }
        }

        return contactsToUpdate;
    }  
}