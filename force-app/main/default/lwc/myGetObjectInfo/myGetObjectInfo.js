import { getObjectInfo, getPicklistValues, getPicklistValuesByRecordType } from 'lightning/uiObjectInfoApi';
import { LightningElement, wire } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import ACCOUNT_INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';

export default class MyGetObjectInfo extends LightningElement {
accountData;
accountError;


    @wire(getObjectInfo,{
                            objectApiName : ACCOUNT_OBJECT
                         }) accountObectInfo;

    @wire(getPicklistValuesByRecordType, {
                               recordTypeId : '$accountObectInfo.data.defaultRecordTypeId',
                               objectApiName : ACCOUNT_OBJECT
                            }) accountIdustryField({data, error})
                            {
                                if(data)
                                {
                                    console.log('Data', data);
                                    this.accountData=data.picklistFieldValues;
                                    this.accountError=null;
                                }
                                else if (error)
                                {
                                    console.log('Error',error);
                                    this.accountData=null;
                                    this.accountError=error;
                                }
                            }
}