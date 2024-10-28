import { LightningElement, wire, track, api } from 'lwc';

import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';

import { getObjectInfo, getObjectInfos, getPicklistValues, getPicklistValuesByRecordType } from 'lightning/uiObjectInfoApi';

export default class ObjectInfoApi extends LightningElement {

    @api objectApiName;
    @api recordId;
    @api fieldApiName = 'Industry';
    @api label = 'Industry';
    
    @api pickListValue = 'Active__c';
    @track accountObjectInfo;
    @track industryPickList = [];
    @track activePickList = [];

    handleObjectChange(event) {
        this.objectApiName = event.target.value;
    }

    @wire(getObjectInfo, { objectApiName: '$objectApiName'})
    wiredAccountObjectInfo({error, data}) {

        if (data) {
            console.log('Account info :', data);
            this.accountObjectInfo = data;
            console.log('Variable info :', this.accountObjectInfo);
        
        } else if (error) {
            console.log(error);
        }
    }    

    @wire(getObjectInfos, { objectApiNames: [ACCOUNT_OBJECT, CONTACT_OBJECT]})
        wiredMultipleObjectInfos({error, data}) {
            if (data) {
                console.log('Multiple Object info :', data);           
            } else if (error) {
                console.log(error);
            }
        }

        get options() {
            return [
                { label: 'Education', value: 'Education'},
                { label: 'Banking', value: 'Banking' },
                {label: 'Apparel', value: 'Apparel'},
                {label: 'Technology', value: 'Technology'},
                {label: 'Chemical', value: 'Chemical'},
            ]
        
        }

    @wire(getPicklistValues, { recordTypeId : '012000000000000AAA', fieldApiName: INDUSTRY_FIELD})
        wiredPicklistValues({error, data}) {
                if (data) {
                    console.log('Picklist values :', data);
                    this.industryPickList = data.values;
                } else if (error) {
                    console.log(error);
                }
            }
        
        @wire(getPicklistValuesByRecordType, { 
            objectApiName : '$objectApiName', 
            recordTypeId: '012000000000000AAA'
        })
            wiredPicklistValuesByRecordTypeId({error, data}) {
                if (data) {
                    console.log('Picklist values by record type Id:', data);
                    this.activePickList = data.picklistFieldValues[this.fieldApiName].values;
                    
                } else if (error) {
                    
                    console.error(error);
                }
            }

}