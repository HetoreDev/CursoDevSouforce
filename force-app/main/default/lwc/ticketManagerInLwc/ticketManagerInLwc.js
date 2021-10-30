import { LightningElement, api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
//Biblioteca que é responsável por disponibilizar o carregamento de outras bibliotecas .JS ou .CSS 
import { loadScript } from 'lightning/platformResourceLoader';
import getVoos from '@salesforce/apex/TicketsController.getVoos';
import createTicket from '@salesforce/apex/TicketsController.createTicket';
//Biblioteca que já foi carregada(upload) pra dentro da SF anteriormente
import formatterLib from '@salesforce/resourceUrl/Formatter';


export default class TicketManagerInLwc extends LightningElement {

    @api recordId;
    @api moeda;
    @api modo24h;
    
    @track voos;
    @track minDate;
    @track hasResult;
    @track aeroportoOrigem;
    @track aeroportoDestino;
    @track dtPartida;
    @track dtRetorno;

    moedas = [
        {label : 'Real R$',   value : 'BRL'},
        {label : 'Dólar US$', value : 'USD'},
        {label : 'Euro EUR€', value : 'EUR'},
    ]
 
    connectedCallback(){
        this.minDate = this.getToday();

        //método com o mesmo nome na importação que é responsável por chamar e criar a importação da biblioteca que contém os métodos de formatação de data
        loadScript(this, formatterLib).then(() => {
            window.console.log('Carregado com sucesso!');
        }).catch(error => {
            window.console.error(error);
        });

        
    }

    handlerClick(){
        window.console.log('aeroportoOrigem: ' + this.aeroportoOrigem);
        window.console.log('aeroportoDestino: ' + this.aeroportoDestino);
        window.console.log('dtPartida: ' + this.dtPartida);
        window.console.log('dtRetorno: ' + this.dtRetorno);

        this.loadVoos(this.aeroportoOrigem, this.aeroportoDestino, this.dtPartida, this.dtRetorno);
    }

    handlerEventClick(event){
        const idVooIda = event.detail.IdVooIda;
        const idVooVolta = event.detail.IdVooVolta;
        const recordId = this.recordId;

        this.createTicket(recordId, idVooIda, idVooVolta);
    }

    handlerMoedaChange(event){
        this.moeda = event.detail.value;
    }

    lookupHandlerChanged(event){
        window.console.log('entrou no handle do lookup');
        if(event.detail.name == 'aeroportoOrigem'){
            this.aeroportoOrigem = event.detail.value;
        } else if(event.detail.name == 'aeroportoDestino'){
            this.aeroportoDestino = event.detail.value;
        }
        window.console.log('event.detail.name: ' + event.detail.name);
        window.console.log('event.detail.value: ' + event.detail.value);
        
    }
    
    /*
    handleAeroportoOrigem(event){
        this.aeroportoOrigem = event.detail.value;
        window.console.log('event.detail.value: ' + event.detail.value);
    }

    handleAeroportoDestino(event){
        this.aeroportoDestino = event.detail.value;
        window.console.log('event.detail.value: ' + event.detail.value);
    }
    */

    handlerDataPartidaChanged(event){
        this.dtPartida = event.detail.value;
    }

    handlerDataRetornoChanged(event){
        this.dtRetorno = event.detail.value;
    }

    loadVoos(aeroportoOrigem, aeroportoDestino, dataPartida, dataRetorno) {
        getVoos({
            aeroportoOrigem : aeroportoOrigem,
            aeroportoDestino : aeroportoDestino,
            dataPartida : dataPartida,
            dataRetorno : dataRetorno

        }).then(data => {
            if(this.modo24h){
                for(let i = 0; i < data.length; i++){
                    //Formatter.format() Classe e método carregado por uma librarie externa
                    data[i].vooIda.Hora_de_Chegada__c = window.Formatter.format(data[i].vooIda.Hora_de_Chegada__c);
                    data[i].vooIda.Hora_de_Partida__c = window.Formatter.format(data[i].vooIda.Hora_de_Partida__c);

                    data[i].vooVolta.Hora_de_Chegada__c = window.Formatter.format(data[i].vooVolta.Hora_de_Chegada__c);
                    data[i].vooVolta.Hora_de_Partida__c = window.Formatter.format(data[i].vooVolta.Hora_de_Partida__c);
                }
            }
            this.hasResult = data && data.lenght;
            this.voos = data;

            if(!data || data.length == 0){
                this.showToast('Ops!', 'Nenhum voo encontrado com os critérios pesquisados.', 'warning');
            }

        }).catch(error => {
            window.console.log('Deu ruim: ' + error);
            this.showToast('Ops!', 'Ocorreu um erro ao processar a sua solicitação', 'error');
        });

    } 

    createTicket(accounId, vooIdaId, vooVoltaId){
        createTicket({
            accounId : accounId,
            vooIdaId : vooIdaId,
            vooVoltaId : vooVoltaId
        }).then(result => {
            window.console.log(result);
            this.showToast('Sucesso!', 'Ticket reservado com sucesso', 'success');
        }).catch(error => {
            window.console.error(error);
            this.showToast('Ops!', 'Ocorreu um erro ao processar a sua solicitação', 'error');
        });
    }

    getToday(){
        //Esse método vai retornar a data no formato 2021-01-15
        const today = new Date();// Vai ternor o mês -1, por isso na próxima linha somamos 1 para deixar o mês corretamente, também vai de 0 até 11
        return today.getFullYear() + '-' + ((today.getMonth() + 1) > 10 ? (today.getMonth() + 1) : '0' + (today.getMonth() + 1)) + '-' + (today.getDate() > 10 ? today.getDate() : '0' + today.getDate());
    }

    showToast(title, message, variant){
        const toast = new ShowToastEvent({
            "title" : title,
            "message" : message,
            "variant" : variant
        });

        this.dispatchEvent(toast);
    }

}