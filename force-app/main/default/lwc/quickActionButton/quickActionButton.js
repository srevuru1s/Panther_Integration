import { LightningElement } from 'lwc';

export default class QuickActionButton extends LightningElement {

    handleSave() {
        console.log('save button has been clicked');
    }

    handleCancel() {
        console.log('cancel button has been clicked');
    }
}