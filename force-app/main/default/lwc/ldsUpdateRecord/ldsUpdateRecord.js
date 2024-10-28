import { LightningElement, api } from 'lwc';

import { updateRecord } from 'lightning/uiRecordApi';
import ID_FIELD from '@salesforce/schema/Account.Id';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';


export default class LdsUpdateRecord extends LightningElement {

    @api recordId;
    isLoading = false;

    accountFields = {
        [NAME_FIELD.fieldApiName]: 'LDS Record Update',
        [PHONE_FIELD.fieldApiName]: '5732000698',
        
    }

    handleClick(event) {
        event.preventDefault();
        this.isLoading = true;
        this.accountFields[ID_FIELD.fieldApiName] = this.recordId;
        console.log('the button clicked :' , JSON.stringify(this.accountFields));

        const recordInput = {
            fields  : this.accountFields
        }

        updateRecord(recordInput)
            . then((response) => {
                console.log(response);
                alert('Record Updated Successfully');
            })
            . catch((error) => {
                console.error(JSON.stringify(error));
            })
            . finally(() => {
                console.log(`The record updated successfully : ${this.recordId}`);
                this.isLoading = false;
            })
    }
}