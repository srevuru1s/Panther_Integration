import { LightningElement } from 'lwc';

import { publish, createMessageContext, releaseMessageContext } from 'lightning/messageService';
import PsLwc from '@salesforce/messageChannel/PsLwc__c';

export default class PublisherComponent extends LightningElement {

    messageContext = createMessageContext();
    handleClick(event) {
        event.preventDefault();

        publish(this.messageContext, PsLwc, {
            recordName : 'Salesforce.com',
            recordId : '58965698',
            record: {
                recordName : 'Salesforce.com',
                recordId : '58965698'
            }
        });
    }

    //* releasing the message context when it is disconnected from the DOM
    disconnectedCallback() {
        releaseMessageContext(this.messageContext);
        this.messageContext = undefined;
    }

}