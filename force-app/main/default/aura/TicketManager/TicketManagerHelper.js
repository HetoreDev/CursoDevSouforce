({  
    loadVoos : function(component, aeroportoOrigem, aeroportoDestino, dataPartida, dataRetorno) {
        let action = component.get('c.getVoos'); //'c.getVoos' se refere a controller Apex e a ao método que está dentro desta Apex. getVoos
        //String aeroportoOrigem, String aeroportoDestino, String dataPartida, String dataRetorno -> argumentos esperados no método getVoos do Apex
        action.setParam('aeroportoOrigem', aeroportoOrigem);
        action.setParam('aeroportoDestino', aeroportoDestino);
        action.setParam('dataPartida', dataPartida);
        action.setParam('dataRetorno', dataRetorno);

        action.setCallback(this, function(result){
            let state = result.getState();
            let toastEvent = $A.get("e.force:showToast");

            if(state == 'SUCCESS'){
                let modo24h = component.get("v.modo24h");

                let data =  result.getReturnValue();
                if(modo24h){
                    for(let i = 0; i < data.length; i++){
                        data[i].vooIda.Hora_de_Chegada__c = window.Formatter.format(data[i].vooIda.Hora_de_Chegada__c);
                        data[i].vooIda.Hora_de_Partida__c = window.Formatter.format(data[i].vooIda.Hora_de_Partida__c);

                        data[i].vooVolta.Hora_de_Chegada__c = window.Formatter.format(data[i].vooVolta.Hora_de_Chegada__c);
                        data[i].vooVolta.Hora_de_Partida__c = window.Formatter.format(data[i].vooVolta.Hora_de_Partida__c);
                    }
                }
                component.set('v.hasResult', data && data.length);
                component.set('v.voos', data);

                if(!data || data.length == 0){
                    toastEvent.setParams({
                        "title" : "Ops!",
                        "message" : "Nenhum voo encontrado com os critérios pesquisados.",
                        "type" : "warning"
                    });
                    toastEvent.fire();
                }

            } else if (state == 'ERROR'){
                window.console.error(result.getError());

                toastEvent.setParams({
                    "title" : "Ops!",
                    "message" : "Ocorreu um erro ao processar a sua solicitação.",
                    "type" : "error"
                });
                toastEvent.fire();
            }
        });

        $A.enqueueAction(action);
    },
   
    createTicket : function(component, accountId, vooIdaId, vooVoltaId){
        let action = component.get('c.createTicket');
        //createTicket(String accountId, String vooIdaId, String vooVoltaId)
        action.setParam('accountId', accountId);
        action.setParam('vooIdaId', vooIdaId);
        action.setParam('vooVoltaId', vooVoltaId);

        action.setCallback(this, function(result){
            let state = result.getState();
            let toastEvent = $A.get("e.force:showToast");

            if(state == 'SUCCESS'){
                console.log('Reservaste com sucesso meu rei!');
                window.console.log(result.getReturnValue());
               
                toastEvent.setParams({
                    "title" : "Sucesso!",
                    "message" : "Ticket reservado com sucesso.",
                    "type" : "success"
                });
                toastEvent.fire();

            } else if(state == 'ERROR'){
                window.console.error(result.getError());
     
                toastEvent.setParams({
                    "title" : "Ops!",
                    "message" : "Ocorreu um erro ao processar a sua solicitação.",
                    "type" : "error"
                });
                toastEvent.fire();

            }
        })

        $A.enqueueAction(action);
    },

    getToday : function () {
        //Esse método vai retornar a data no formato 2021-01-15
           const today = new Date();// Vai ternor o mês -1, por isso na próxima linha somamos 1 para deixar o mês corretamente, também vai de 0 até 11
           return today.getFullYear() + '-' + ((today.getMonth() + 1) > 10 ? (today.getMonth() + 1) : '0' + (today.getMonth() + 1)) + '-' + (today.getDate() > 10 ? today.getDate() : '0' + today.getDate());
        }

})