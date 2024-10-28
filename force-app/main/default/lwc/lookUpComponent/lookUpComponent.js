import { LightningElement, track } from 'lwc';
import getAccount from '@salesforce/apex/ContactService.getAccount';
import getAccountList from '@salesforce/apex/ContactService.getAccountList';


export default class LookUpComponent extends LightningElement {

    @track data = '';
    // timer = '';
    searchKey;

    connectedCallback() {
        this.handleFetchAccount();
    }

    handleChange(event) {
        event.event.preventDefault();

        // window.clearTimeout(this.timer);
        this.searchKey = event.target.value;
        console.log(`the search values : ${this.searchKey}`);
        this.callApex();
        // console.log('The key value:', this.searchKey);

        // this.timer = setTimeout(() => {
        //     this.callApex();
        // }, 2000);
        // console.log('Timer :', this.timer);
    }
    handleFetchAccount() {
        getAccount()
        .then((data) =>{
            console.table(data);
            this.data = JSON.parse(JSON.stringify(data));
            console.table(this.data);
        })  
        .catch((error) => {
            console.error('Error while fetching the data');
        })
    }
    callApex() {

        getAccountList({key : this.searchKey})
        .then((data) =>{
            console.table(data);
            this.data = JSON.parse(JSON.stringify(data));
            console.table(this.data);
        })  
        .catch((error) => {
            console.error('Error while fetching the data');
        })

    }
        
    
}