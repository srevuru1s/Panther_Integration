import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue, getFieldDisplayValue } from 'lightning/uiRecordApi';

import NAME_FIELD from '@salesforce/schema/Account.Name';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import RATING_FIELD from '@salesforce/schema/Account.Rating';
import ANNUAL_REVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';

export default class LdsGetRecord extends LightningElement {

    @api recordId;
    @api objectApiName;

    accountRecord = '';
    /*
        Account fields : Name, Industry , Rating , AnnualRevenue, Phone
    */
    @wire(getRecord, { recordId : '$recordId', fields : [NAME_FIELD, INDUSTRY_FIELD, RATING_FIELD, ANNUAL_REVENUE_FIELD, PHONE_FIELD] })
    wiredAccountRecord({data, error}) {
        if(data) {
            console.log('data:', data);
            this.accountRecord = data.fields;
        } else if(error) {
            console.log(error);
        }
    };

    // get name() {
    //     console.log(this.account.data);
    //     console.log(NAME_FIELD);
    //     return getFieldValue(this.account.data, NAME_FIELD);
    // }
    
    // get annualRevenue() {
        
    //     return getFieldDisplayValue(this.account.data, ANNUAL_REVENUE_FIELD);
    // }
}