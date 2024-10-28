import { LightningElement, wire, track } from 'lwc';

import getContactList from '@salesforce/apex/ContactService.getContactList';

export default class ContactListApex extends LightningElement {

    @track records;
    @track errors;
    @track searchValue = 'e';

    @wire(getContactList, {firstName : '$searchValue'})
        // listContacts;
    
        wiredContacts({ error, data }) {
            
        if (data) {
        console.log('The list of records from SF:', data);
        console.table(data);
        //* the data is coming in array format we can run over the array loop
            let mapOfContacts = data.map((currentItem) => {
                console.log(`current Item : Name - ${currentItem.Name} Id: ${currentItem.Id}`);
                    return {...currentItem, Email: currentItem.Email ? currentItem.Email : 'No Email' };
                });

                this.records = mapOfContacts;
                
                console.log(this.records);
    
        //         //* clone the data
    //         let clonedContact = [...data];
    //         console.log('The cloned records:',JSON.stringify(clonedContact));
    //         this.records = clonedContact;
    //         console.log('The records list:', this.records);

        } else if (error) {
            console.error('The error from apex', error);
            this.errors = error;
            
        }
    }

    handleOnClick() {

        console.log('The value:', this.searchValue);
        this.searchValue = 'sa';
    }


    
}