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

Presentation link : https://docs.google.com/presentation/d/1Wuo2xZ-M2JAuLOgDf2ZxQB7MiUovNPefWO8pLc0nj3Y/edit?slide=id.g3a84f118624_0_73#slide=id.g3a84f118624_0_73
