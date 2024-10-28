import { api, track, LightningElement } from 'lwc';

export default class LifeCycleHooksChild extends LightningElement {

    @api greeting;
    render;

    constructor() {
        super();
        console.log('Child constructor');
        console.log('@api public property value from parent: ', this.greeting);
    }

    connectedCallback() {
        console.log('Child connectedCallback');
        console.log('@api public property value from parent: ', this.greeting);
        //* injecting an error
        console.log(showchild.value);
    }

    renderedCallback() {
        console.log('Child renderCallback');
    }

    handleClick() {
        console.log('child handle click to see the render call back is fired');
        this.greeting = 'Updated greeting';
        this.render = 'false';
        console.log(this.render);
    }
    
    errorCallback(error, stack) {
        console.log('Error in child', error, 'stack om child', stack);
    }
    disconnectedCallback() {
        console.log('Child disconnected from parent');
    }


}