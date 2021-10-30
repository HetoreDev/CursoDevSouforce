import { LightningElement, api } from 'lwc';

export default class CardTicketInLwc extends LightningElement {
    @api vooIda;
    @api vooVolta;
    @api moeda;

    reservaHandleClick(){
        let compEvent = new CustomEvent('ticketeventclick', {
           detail: {
               IdVooIda : this.vooIda,
               IdVooVolta : this.vooVolta
           } 
        });

        this.dispatchEvent(compEvent);
    }

    get vooIdaDiaDiferente(){
        return this.vooIda.Data_Partida__c !== this.vooIda.Data_Chegada__c;
    }

    get vooVoltaDiaDiferente(){
        return this.vooVolta.Data_Partida__c !== this.vooVolta.Data_Chegada__c;
    }

    get valorTotal(){
        return this.vooIda.Valor__c  + this.vooVolta.Valor__c;
    }
}