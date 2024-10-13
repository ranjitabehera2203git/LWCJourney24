import { LightningElement, wire } from 'lwc';
import { getRecords } from "lightning/uiRecordApi";
import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';
import ACCOUNT_RATING_FIELD from '@salesforce/schema/Account.Rating';
import CONTACT_NAME_FIELD from '@salesforce/schema/Contact.Name';
import CONTACT_PHONE_FIELD from '@salesforce/schema/Contact.Phone';
import OPPORTUNITY_NAME_FIELD from '@salesforce/schema/Opportunity.Name';
import OPPORTUNITY_AMOUNT_FIELD from '@salesforce/schema/Opportunity.Amount';

export default class MyGetRecordsComponent extends LightningElement {
    recordResult;
    recordError;


    @wire(getRecords,{
        records: [
            {
              recordIds: ["0012w000018bZ4fAAE"],
              fields: [ACCOUNT_NAME_FIELD, ACCOUNT_RATING_FIELD]             
            },
            {
              recordIds: ["0032w00000rfdJaAAI"],
              fields: [CONTACT_NAME_FIELD, CONTACT_PHONE_FIELD]
            },
            {
                recordIds: ["0062w00000Glq75AAB"],
                fields: [OPPORTUNITY_NAME_FIELD, OPPORTUNITY_AMOUNT_FIELD]
            }
          ]
    }) allRecords({data, error})
    {
        if(data)
        {
            console.log('Data', data);
            this.recordResult=data.results;
            console.log('Data.results', data.results);
            this.recordError=null;
        }
        else if(error)
        {
            console.log('Error', error);
            this.recordResult=null;
            this.recordError=error;
        } 
    }
}