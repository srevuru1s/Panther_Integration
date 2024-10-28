import { LightningElement, wire } from 'lwc';
import getAccount from '@salesforce/apex/ContactService.getAccount';

export default class DataTable extends LightningElement {

    data = [];
    columns = [
        { label : 'Name', fieldName : 'RecordUrl', wrapText: true, type: 'url', 
            typeAttributes : {
                label: {
                    fieldName : 'Name'
                },
                target: '_blank'
            }},
        { label : 'Phone', fieldName : 'Phone'},
        { label : 'Rating', fieldName : 'Rating'},
        { label : 'Annual Revenue', fieldName : 'AnnualRevenue', type : 'currency'},
        { label : 'Created Date', fieldName : 'CreatedDate', type : 'date'},
        { label : 'Active', fieldName : 'Active__c'},
        { label : 'Owner', fieldName : 'OwnerId'},
        { label: 'Owner Name', fieldName: 'OwnerName' },
        { label: 'Website', fieldName: 'Website', type : 'url', wrapText: true }

        
    ];

    @wire(getAccount) 
        wiredAccount({data, error}) {
            console.log('Account list :', data);
            console.table(data);
            if (data) {
                console.log('we have the data');
                this.data = data.map((item) => {
                    return {...item, OwnerName: item.Owner.Name, RecordUrl : location.protocol+location.host+'lightning/r/Account/'+item.Id+'/view',
                            Ownerurl : location.protocol+location.host+'lightning/r/User/'+item.OwnerId+'/view'
                    }
                    
                });
                console.log('The map data:', this.data);
            } else if (error) {
                console.error('We got the error:', this.error);
            }
        }
}