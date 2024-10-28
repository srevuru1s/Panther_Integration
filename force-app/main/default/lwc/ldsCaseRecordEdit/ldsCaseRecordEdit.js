import { LightningElement, api, track } from 'lwc';

import ACCOUNT_NAME_FIELD from '@salesforce/schema/Case.AccountId';
import CONTACT_NAME_FIELD from '@salesforce/schema/Case.ContactId';
import DESCRIPTION_FIELD from '@salesforce/schema/Case.Description';

export default class LdsCaseRecordEdit extends LightningElement {

    @api recordId;
    @api objectApiName;


    @track fields = [
        { objectApiName: 'Case', fieldApiName: 'CaseNumber' },
        { objectApiName: 'Case', fieldApiName: 'Status' },
        ACCOUNT_NAME_FIELD,
        CONTACT_NAME_FIELD,
        DESCRIPTION_FIELD
    ];

    handleSubmit(event) {
        event.preventDefault(); // stop the form from submitting
        const fields = event.detail.fields;
        fields.CASE_DESCRIPTION_FIELD = 'My Custom Last Name'; // modify a field
        this.template.querySelector('lightning-record-form').submit(fields);
        
    }
}