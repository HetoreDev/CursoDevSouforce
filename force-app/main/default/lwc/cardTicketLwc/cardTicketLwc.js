import {LightningElement, api, track, wire} from 'lwc';
import getDado from '@salesforce/apex/lookupfieldController.getObjectDetails';

export default class CardTicketLwc extends LightningElement {
    @api recordId;
    @api objectApiName;
    @track data;

    @track mensagem;
    
    @wire(getDado, {ObjectName : '$objectApiName'})
    record({error, data}){
        if(error){
            window.console.log(error);
        }else{
            this.data = data;            
        }
    }

    connectedCallback(){
        window.console.log(this.recordId);
        this.mensagem = 'Olá mundo!'; 
        
        getDado({ObjectName : this.objectApiName}).then(result => {
            window.console.log(result);
        }).catch(error => {
            window.console.log(error);
        });        
    }

    handlerClick(event){
        this.mensagem = 'Vai Corinthians!';
    }
}