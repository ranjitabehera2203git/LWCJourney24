import { LightningElement, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import greetMessageChannel from '@salesforce/messageChannel/greeting__c';

export default class MsgPublisherComponent extends LightningElement {
    myMsg='Welcome To Learn LWC';
    @wire(MessageContext)
    messageContext;

    clickHandler()
    {
        const payload = { greetMsg : this.myMsg};

        publish(this.messageContext, greetMessageChannel, payload);
    }
    
}