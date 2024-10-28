import { LightningElement } from 'lwc';

export default class PsGetterSetter extends LightningElement {

    welcomeMessage = 'Hello Sagar';
    motivationMessage = '';
    

    get psMessage() {
        return this.motivationMessage;
    }

    set psMessage(value) {
        this.motivationMessage = value.toUpperCase();
    }

    handleClick() {
        this.welcomeMessage = 'Learn LWC From Panther Schools';

        this.psMessage = 'Motivation from PS LWC';
    }
}