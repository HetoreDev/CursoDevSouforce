import { LightningElement } from 'lwc';

export default class TicketManagerLwc extends LightningElement {

    constructor(){
        super();
        window.console.log('Sou o construtor');
    }

    connectedCallback(){
        window.console.log('Sou o connectedCallBack');
    }

    errorCallback(error, stack){
        window.console.log(error);
        window.console.log(stack);
    }

    rende(){
        window.console.log('Sou o render'); 
    }

    renderedCallback(){
        if(!this.hasLoaded){
            window.console.log('Sou o renderedCallBack'); 
            this.hasLoaded = true;   
        }        
    }

    disconnectedCallback(){
        window.console.log('componente morreu');
    }
    
    handlerClick(event){
        const e = new CustomEvent('buttonclick', {
            detail : {value : 1,
                      data  : 2}
        });

        this.dispatchEvent(e);
    }
}