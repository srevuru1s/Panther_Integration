import { LightningElement, wire } from 'lwc';
import { NavigationMixin, CurrentPageReference } from 'lightning/navigation';

export default class PageReference extends NavigationMixin(LightningElement) {

    @wire(CurrentPageReference)
    pageRef;

    connectedCallback() {
        console.log(this.pageRef);
    }

    handleCreate(event) {
        event.preventDefault();

            this[NavigationMixin.Navigate]({
            type: "standard__objectPage",
            attributes: {
                actionName: "new",
                objectApiName: "Account"
            }
            });

    }

    handleView(event) {
        event.preventDefault();

        this[NavigationMixin.Navigate]({
            type: "standard__recordPage",
            attributes: {
                actionName: "view",
                recordId: "001ao00001TcnZbAAJ",
                objectApiName: "Account"
            }
        });
    }

    handleEdit(event) {
        event.preventDefault();

        this[NavigationMixin.Navigate]({
            type: "standard__objectPage",
            attributes: {
                actionName: "edit",
                recordId: "001ao00001TcnZbAAJ",
                objectApiName: "Account"
            }
            });
    }
}