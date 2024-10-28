import { LightningElement } from 'lwc';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';


import ZENDESK from '@salesforce/label/c.Zendesk_Username';
import PANTHER from '@salesforce/label/c.CCPantherEmail';


export default class CustomLabelLWC extends LightningElement {

    labels = {
        zendesk : ZENDESK,
        email   : PANTHER
    }

    toastHandler(title, message, variant, mode) {

        let toast = new ShowToastEvent({
            title   ,
            message ,
            messageData : [
                'salesforce', {
                    label : 'click here', url :'https://www.google.com/'
                }
            ],
            variant ,
            mode    
        });

        //* sending the toast message to LWC 
        this.dispatchEvent(toast);
    }
    connectedCallback() {

        this.toastHandler('Success Toast', '{0} SUCCESS Message {1}', 'success', 'sticky');
    }

    
}