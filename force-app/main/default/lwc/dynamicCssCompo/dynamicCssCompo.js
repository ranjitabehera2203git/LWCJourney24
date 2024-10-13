import { LightningElement } from 'lwc';

export default class DynamicCssCompo extends LightningElement {
    dafaultcss = 'default';

    addclickHandler(event) {

        let element = this.template.querySelector('p');
        element.classList.add('sadd-color');
    }

    removeclickHandler(event) {
        let element = this.template.querySelector('p');
        element.classList.remove('sadd-color');
    }
    toggleclickHandler(event) {
        let element = this.template.querySelector('p');
        element.classList.toggle('sadd-color');
    }

}