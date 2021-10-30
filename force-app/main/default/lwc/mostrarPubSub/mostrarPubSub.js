import { LightningElement, track, wire } from 'lwc';
import { loadScript } from 'lightning/platformResourceLoader';
import pubSubLib from '@salesforce/resourceUrl/PubSub';
import { CurrentPageReference } from 'lightning/navigation';


export default class MostrarPubSub extends LightningElement {    
    @wire(CurrentPageReference) pageRef;

    @track variant;

    connectedCallback(){
        loadScript(this, pubSubLib).then(() => {
            window.console.log('PubSub carregado com sucesso!');
            window.pubsub.registerListener('selectedVariant', this.handlerPubSub, this);
        }).catch(error => {
            window.console.error(error);
        });
    }

    handlerPubSub(event){
        this.variant = event.detail.variant;
    }

    disconnectedCallback(){
        window.pubsub.unregisterAllListeners(this);
    }


}