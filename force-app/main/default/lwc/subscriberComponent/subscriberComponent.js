import { LightningElement, track } from 'lwc';
import PsLwc from '@salesforce/messageChannel/PsLwc__c';
import { subscribe, createMessageContext, releaseMessageContext } from 'lightning/messageService';
export default class SubscriberComponent extends LightningElement {

    messageContext = createMessageContext();
    @track responseReceived;

    connectedCallback() {
        // const callBackFun = this.handleResponse.bind(this);
        subscribe(this.messageContext, PsLwc, (response) => {
            console.log('Response Received from LMS', JSON.stringify(response));
            this.responseReceived = response;

        });
    }

    // handleResponse(response) {
    //     console.log('Response Received from LMS', JSON.stringify(response));
    //     this.responseReceived = response;
    // }

    disconnectedCallback() {
        releaseMessageContext(this.messageContext);
        this.messageContext = undefined;
    }
}