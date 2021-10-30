({
    init : function(component, event, helper) {
        component.set('v.minDate', helper.getToday());
    },
    
    handleClick : function(component, event, helper){
        let aeroportoOrigem = component.get('v.aeroportoOrigem');
        let aeroportoDestino = component.get('v.aeroportoDestino');
        let dataPartida = component.get('v.dataPartida');
        let dataRetorno = component.get('v.dataRetorno');

        helper.loadVoos(component, aeroportoOrigem, aeroportoDestino, dataPartida, dataRetorno);
    },

    handlerEventClick : function(component, event, helper){
        const idVooIda = event.getParam("IdVooIda");
        const idVooVolta = event.getParam("IdVooVolta");
        const recordId = component.get('v.recordId');

        window.console.log(idVooIda, idVooVolta, recordId);

        helper.createTicket(component, recordId, idVooIda, idVooVolta);

    },

    afterScriptsLoaded : function(component, event, helper){
        window.console.log('Carregado com sucesso.');
    } 

})