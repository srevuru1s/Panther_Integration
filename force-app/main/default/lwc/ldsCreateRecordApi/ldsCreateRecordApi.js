import { LightningElement } from 'lwc';

import { createRecord } from 'lightning/uiRecordApi';

import ACCOUNT_OBJECT   from '@salesforce/schema/Account';
import NAME_FIELD       from '@salesforce/schema/Account.Name';

import CONTACT_OBJECT   from '@salesforce/schema/Contact';
import FIRST_NAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LAST_NAME_FIELD  from '@salesforce/schema/Contact.LastName';
import EMAIL_FIELD      from '@salesforce/schema/Contact.Email';
import ACCOUNTID_FIELD  from '@salesforce/schema/Contact.AccountId';

export default class LdsCreateRecordApi extends LightningElement {

    accountRecordFields = {};
    contactRecordFields = {
        [FIRST_NAME_FIELD.fieldApiName]: '',
        [LAST_NAME_FIELD.fieldApiName]: '',
        [EMAIL_FIELD.fieldApiName]: '',
        [ACCOUNTID_FIELD.fieldApiName] : ''
    };

    handleClick(event) {
        event.preventDefault();

        console.log(NAME_FIELD);
        const recordInput = {
            apiName: ACCOUNT_OBJECT.objectApiName,
            fields: this.accountRecordFields
        };

        createRecord(recordInput) //* it returns the promise -- then catch finally
        .then((result) => {
            console.log(JSON.stringify(result));
            if(result) {
                let accountId = result.id;
                console.log("🚀 ~ LdsCreateRecordApi ~ .then ~ recordId:", accountId);
                this.handleContactCreate(accountId);
            }
        })
        .catch((error) =>{
            console.error(JSON.stringify(error));
        })
        . finally(() => {
            console.log('finally'); //* it will execute always and we can uses for clean up logic
        });
    }

    handleContactCreate(accountId) {

        this.contactRecordFields[ACCOUNTID_FIELD.fieldApiName] = accountId;
        console.log('Contact Record Fields:', JSON.stringify(this.contactRecordFields));
        const recordInput = {
            apiName : CONTACT_OBJECT.objectApiName,
            fields : this.contactRecordFields
        }

        createRecord(recordInput)
        .then((result) => {
            console.log(result);
        })
        .catch((error) => {
            console.error(JSON.stringify(error));
        })
        .finally(() => {
            console.log('finally');
        })    
    }
    
    handleAccountInputChange(event) {
        event.preventDefault();
        console.log('Account Target :', event.target);
        let {name, value } = event.target;
        this.accountRecordFields[name] = value;
        console.log('The account record:' , JSON.stringify(this.accountRecordFields));
    }

    

    handleContactInputChange(event) {
        event.preventDefault();
        console.log('Contact Target :', event.target);
        let {name, value} = event.target;
      
        this.contactRecordFields[name] = value;
        console.log('The contact record:' , JSON.stringify(this.contactRecordFields));
    }

    
}