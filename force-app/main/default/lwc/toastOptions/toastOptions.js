import { LightningElement, api, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { loadScript } from 'lightning/platformResourceLoader';
import pubSubLib from '@salesforce/resourceUrl/PubSub';
import { CurrentPageReference } from 'lightning/navigation';


export default class ToastOptions extends LightningElement {

    variants = [
        {label : 'Info',    value : 'info'},
        {label : 'Success', value : 'success'},
        {label : 'Warning', value : 'warning'},
        {label : 'Error',   value : 'error'},
    ]

    @wire(CurrentPageReference) pageRef;

    connectedCallback(){
        loadScript(this, pubSubLib).then(() => {
            window.console.log('PubSub carregado com sucesso!');
        }).catch(error => {
            window.console.error(error);
        });
    }

    /*
    modes = [
        {label : 'Dismissable', value : 'dismissible'},
        {label : 'Pester',      value : 'pester'},
        {label : 'Sticky',      value : 'sticky'},
    ]
    
    variant = 'info';
    mode = 'dismissible';
    */

    variant = 'info';
    @api mode;
    @api buttonLabel;

    handlerVariantChanged(event){
        this.variant = event.detail.value;

        window.pubsub.fireEvent(this.pageRef, 'selectedVariant', {
            detail: {
                variant: this.variant
            }            
        });
    }

    disconnectedCallback(){
        window.pubsub.unregisterAllListeners(this);
    }

    handlerModeChanged(event){
        this.mode = event.detail.value;
    }

    handlerToastEvent(event){
        const toast = new ShowToastEvent({
            "title" : "Título do Toast",
            "message" : "Mensagem",
            "variant" : this.variant,
            "mode" : this.mode
        });

        this.dispatchEvent(toast);
    }

}