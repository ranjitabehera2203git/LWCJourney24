import { LightningElement, wire } from 'lwc';
import {subscribe, unsubscribe, APPLICATION_SCOPE, MessageContext} from 'lightning/messageService';
import greetMessageChannel from '@salesforce/messageChannel/greeting__c';

export default class MsgSubscriberComponent extends LightningElement {
    greeting;

    subscription = null;

    @wire(MessageContext)
    messageContext;

    connectedCallback() {
        this.subscribeToMessageChannel();
    }

    subscribeToMessageChannel() {
        if (!this.subscription) {
            this.subscription = subscribe(
                this.messageContext,
                greetMessageChannel,
                (message) => this.handleMessage(message)
            );
        }
    }

    handleMessage(message) {
        this.greeting = message.greetMsg;
    }

    disconnectedCallback() {
        this.unsubscribeToMessageChannel();
    }

    unsubscribeToMessageChannel() {
        unsubscribe(this.subscription);
        this.subscription = null;
    }


}