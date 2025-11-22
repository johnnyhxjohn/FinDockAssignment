/*
* TODO : Create front end validations to only validate records that have address fields populated.
*/
import { LightningElement, api, wire, track } from 'lwc';
import validateAddress from '@salesforce/apex/ContactAddressValidation.validateAddress';
import getContactInfo from '@salesforce/apex/ContactAddressValidation.getContactInfo';
import { RefreshEvent } from 'lightning/refresh';

export default class ContactAddressValidation extends LightningElement {
    @api recordId;
    @api objectApiName;
    @api contact;
    @track error;
    @api warningMessage;
    @api successMessage;

    @wire(getContactInfo, { recordId: '$recordId' })
    wiredContact({ data, error }) {
        if (data) {
            this.contact = data;
        } else if (error) {
            console.error(error);
        }
    }

    isValidToValidate() {
      if (!this.contact?.MailingStreet) {
        this.warningMessage = "This contact doesn't have MailStreet populated.";
        return false;
      }
      return true;
    }

    handleValidate() {
      this.warningMessage = "";
      this.successMessage = "";
        if(this.isValidToValidate()) {
          validateAddress({ recordId: this.recordId })
            .then((result) => {
              this.contact = result;
              this.successMessage = 'Address Validated';
              this.dispatchEvent(new RefreshEvent());
            })
            .catch((error) => {
              this.error = error;
            });
          }
      }
}