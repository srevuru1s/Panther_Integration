import { LightningElement, api, track } from 'lwc';

import NAME_FIELD from '@salesforce/schema/Opportunity.Name';
import STAGE_FIELD from '@salesforce/schema/Opportunity.StageName';
import AMOUNT_FIELD from '@salesforce/schema/Opportunity.Amount';

export default class LdsRecordForm extends LightningElement {

    @api recordId;
    @api objectApiName;

    @track fields = [
        { objectApiName: 'Opportunity', fieldApiName: 'CloseDate' },
        { objectApiName: 'Opportunity', fieldApiName: 'Probability' },
        AMOUNT_FIELD,
        NAME_FIELD,
        STAGE_FIELD
    ];

    handleSuccess(event) {
        event.preventDefault();
        alert('Record Saved!');
        console.log(JSON.stringify(event.detail));
    }

    handleError(event) {
        event.preventDefault();
        console.log(JSON.stringify(event.detail));
    }

    handleSubmit(event) {
        event.preventDefault();
        console.log('Record Submitted', event.detail);

        let fields = event.detail.fields;
        console.log('Field values :', fields.NextStep);
        fields.Name = 'New Opportunity';
        fields.StageName = 'Needs Analysis';
        fields.CloseDate = new Date().toISOString().split('T')[0];
        fields.Amount = 100;
        fields.LeadSource = 'Other';
        this.template.querySelector(
            'lightning-record-form'
        ).submit(fields);
    }

    handleCancel(event) {
        event.preventDefault();
        alert('Record Cancelled!');
        console.log(event.detail);
    }

    handleLoad(event) {
        event.preventDefault();
        console.log('Record Loaded');
        
    }
}