import { LightningElement, api, wire, track } from 'lwc';
import validateAddress from '@salesforce/apex/ContactAddressValidation.validateAddress';
import getRelatedContacts from '@salesforce/apex/ContactAddressValidation.getRelatedContacts';
import { RefreshEvent } from 'lightning/refresh';

export default class AccountContactAddressValidation extends LightningElement {
    @api recordId;
    @api objectApiName;
    @track contact;
    @track error;
    @track message;

    columns = [
        { label: 'Street', fieldName: 'MailingStreet', type: 'text' },
        { label: 'City', fieldName: 'MailingCity', type: 'text' },
        { label: 'Country', fieldName: 'MailingCountry', type: 'text' },
        { label: 'Postal Code', fieldName: 'MailingPostalCode', type: 'text' },
        { label: 'State', fieldName: 'MailingState', type: 'text' },
        { label: 'Address Valid', fieldName: 'AddressValid__c', type: 'checkbox' }
      ];

    contacts = [];

    @wire(getRelatedContacts, { accountId: '$recordId' })

    wiredContacts({ error, data }) {
      console.log(data);
        if (data) {
            this.contacts = data;
        } 
    }

    handleValidate() {
      validateAddress({ recordId: this.recordId })
        .then((result) => {
          this.contact = result;
          // this.message = 'button clicked';
          this.dispatchEvent(new RefreshEvent());
        })
        .catch((error) => {
          this.error = error;
        });
    }
}