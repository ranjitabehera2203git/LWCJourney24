import { LightningElement, wire, api } from 'lwc';
import searchRecords from '@salesforce/apex/customLookupController.searchRecords';
const DELAY=3000;

export default class CustomLookupComponent extends LightningElement {
    @api objectApiName = 'Account';
    recordSearchKey;
    @api objectLabel = 'Account';
    @api iconName = "standard:account";
    delayTimeout;
    selectedRecord = { recordId : '', recordName : ''};
    displayOption = false;

    get isRecordSelected(){
        return this.selectedRecord.recordId === '' ? false : true;
    }

    @wire(searchRecords,{
                          objectName : '$objectApiName',
                          searchKey : '$recordSearchKey'  }) 
    sObjectRecords;

    changeHandler(event)
    {
        window.clearTimeout(this.delayTimeout);
        let enteredInput = event.target.value;
        this.delayTimeout = setTimeout(() => {
            this.recordSearchKey = enteredInput;   
            this.displayOption = true;         
        }, DELAY);
    }

    clickHandler(event)
    {
        let selectedRecordId = event.currentTarget.dataset.item;
        console.log('Selected Record Id', selectedRecordId);
       let outPutRecord =  this.sObjectRecords.data.find((currentItem)=> currentItem.Id === selectedRecordId);
       this.selectedRecord = {recordId : outPutRecord.Id , recordName : outPutRecord.Name};
       this.displayOption = false;

    }

    removalSelector(event)
    {
        this.selectedRecord = { recordId : '', recordName : ''};
        this.displayOption = false;
    }

}