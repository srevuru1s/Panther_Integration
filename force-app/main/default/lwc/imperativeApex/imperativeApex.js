import { LightningElement, track } from 'lwc';

import getAccountList from '@salesforce/apex/ContactService.getAccountList';
import createAccount from '@salesforce/apex/ContactService.createAccount';

export default class ImperativeApex extends LightningElement {

    @track records = '';
    searchValue = '';
    timer = '';

    handleKeyChange(event) {
        event.preventDefault();

        window.clearTimeout(this.timer); //* clearing the timer
        console.log('Search Key 👀 :', event.target);
        const searchKey = event.target.value;

        this.timer = setTimeout(() => {
            this.search(searchKey);
        }, 1000);

        console.log('Timer called :', this.timer);
        
    }

    search(value) {
        console.log('The value from search:', value);
        this.searchValue = value;
        console.log('Search Value :', this.searchValue);
    }

    // handleClick(event) {
    //     event.preventDefault();
    //     console.log('Handle click clicked');

    //     getAccountList({ key : this.searchValue})
    //         .then(data => {
    //             console.log('The data from Apex:', data);
    //             this.records = data;
    //         })
    //         .catch(error => {
    //             console.error('The error from apex', error);
    //             this.errors = error;
    //         })
    //         .finally(()=> {
    //             console.log('Finally Has been executed');
    //         });
    // }

    handleClick(event) {
        event.preventDefault();
        console.log('Call Apex class');

        let accObj = {
            name     : 'JSON - Account Wrapper',
            industry : 'Education',
            phone    : '5732111111'
        }

        createAccount({ params : JSON.stringify(accObj)})
            .then(data => {
                console.log('The data from Apex:', data);
                this.records = data;
                console.log('The records parameter:' , JSON.stringify(this.records));
            })
            .catch(error => {
                console.error('The error from apex', error);
                this.errors = error;
            })
            .finally(()=> {
                console.log('Finally Has been executed');
            });
    }

}