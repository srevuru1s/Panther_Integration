import { LightningElement } from 'lwc';

import template2 from './template2.html';
import mainTemplate from './lifeCycleHooksParent.html';

export default class LifeCycleHooksParent extends LightningElement {

    greetings = 'Hello World';
    childComponent = true;
    showTemplate = true;

    constructor() {
        super();
        console.log('Parent constructor');
        console.log('Accessing the parent property:', this.greetings);   
    }

    connectedCallback() {
        console.log('Parent connectedCallback');
        let parentTag = this.template
        console.log('Parent Tag:', parentTag);


    }

    renderedCallback() {
        console.log('Parent renderCallback');

        let refDetails = this.refs.lwcCard;
        console.log('Ref :', refDetails);

        let query = this.template.querySelector('lightning-card');
        console.log('Query :', query);
    }

    handleClick() {
        console.log('Handle Click to see the render call back is fired');
        this.greetings = 'Handle click button';

        this.childComponent = false;
        console.log('Disconnect the child component');

    }

    errorCallback(error, stack) {
        console.log('Error in Parent :', error.message, 'stack om Parent', stack);
    }

    handleTemplateClick() { 
        this.showTemplate = this.showTemplate ? false : true;
    }

    render() {
        console.log('Im in the render method');
        return this.showTemplate ? mainTemplate : template2;
    }

    disconnectedCallback() {
        console.log('Parent disconnected from parent');
    }

}