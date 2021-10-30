import { LightningElement } from 'lwc';

export default class TemplatesTrueOrFalse extends LightningElement {

    connectedCallback(){
        this.verdadeiro = true;
        this.false = false;
    }

}