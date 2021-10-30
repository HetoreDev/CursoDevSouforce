import { LightningElement } from 'lwc';

export default class TemplatesForEach extends LightningElement {
    connectedCallback(){
        this.data = [
             {name: 'Hetore Martins'},
             {name: 'Lucas Gullaci'},
             {name: 'Arthur Anelli'},
             {name: 'Fernando Sousa'}           
            ] 
     }
}