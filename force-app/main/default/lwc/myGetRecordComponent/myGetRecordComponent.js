import { getFieldDisplayValue, getFieldValue, getRecord } from 'lightning/uiRecordApi';
import { LightningElement, api, wire } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import RATING_FIELD from '@salesforce/schema/Account.Rating';
import ANNUALREVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';

export default class MyGetRecordComponent extends LightningElement {
    @api recordId;
    accName;
    accPhone;
    accAnualRevenue;
    accRating;

    @wire(getRecord,{
        recordId : '$recordId', 
        fields : [NAME_FIELD, RATING_FIELD, ANNUALREVENUE_FIELD, PHONE_FIELD]
    })wiredAccountRecords({data, error})
    {
        if(data)
        {
            console.log('Data', data);            
            this.accName=getFieldValue(data,NAME_FIELD);
            this.accPhone=getFieldValue(data,PHONE_FIELD);
            this.accAnualRevenue= getFieldDisplayValue(data,ANNUALREVENUE_FIELD);
             this.accRating=getFieldDisplayValue(data,RATING_FIELD);
            // this.accAnualRevenue=data.fields.AnnualRevenue.value;
            // this.accRating=data.fields.Rating.value;
        }
        else if (error)
        {
            console.log('Error', error);
        }
    }
}