import { LightningElement,api, track } from 'lwc';

export default class ToDoList extends LightningElement {

    @api objectApiName;
    @api recordId
    @api noOfReecords;
    @api fieldApiNames;

    @track listContacts =[];    
    contactDetails = 
        {
            FirstName: '',
            LastName: '',
            Email: ''
        }

        firstNameHandler(event) {
            event.preventDefault();
            console.log(event.target.value);
            this.contactDetails.FirstName = event.target.value;
        }

        lastNameHandler(event) {
            event.preventDefault();
            this.contactDetails.LastName = event.target.value;
        }

        emailHandler(event) {
            event.preventDefault();
            this.contactDetails.Email = event.target.value;
        }
        
        handleClick(event) {
            console.log(JSON.stringify(this.contactDetails));

            this.listContacts.push({...this.contactDetails});
            // this.listContacts.push(
            //     Object.assign({}, this.contactDetails)
            // );
        }    
            
        
}