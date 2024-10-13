import { LightningElement } from 'lwc';

export default class ConditionalRendering extends LightningElement {
    debugger;
    displayMessage=false;
    
    onchange(event)
    {
        this.displayMessage = event.target.checked;
    }
}