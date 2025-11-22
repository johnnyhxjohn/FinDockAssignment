# Salesforce Engineer panel assignment
Johnny John Assignment

Script used to perform the bulk update on exercise 1:
```
Map<Id,Contact> contacts = new Map<Id,Contact>([SELECT Id, MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry, AddressValid__c FROM Contact LIMIT 60]);
System.debug(contacts.size());
List<Contact> updatedContacts = ContactAddressValidation.bulkAddressValidation(contacts.keySet());
System.debug(updatedContacts);
```

After execute on anonoymous apex code, change the debug perspective to "analysis" to see the entire analyse of the execution.
