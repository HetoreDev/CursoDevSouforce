({
    reservaHandleClick : function(component, event, helper) {
        window.console.log('Reserva Confirmada!');
        
        let vooIda = component.get('v.vooIda');
        let vooVolta = component.get('v.vooVolta');

        let compEvent = component.getEvent('ticketEventClick');
        compEvent.setParams({
            "IdVooIda" : vooIda.Id,
            "IdVooVolta" : vooVolta.Id
        });

        compEvent.fire();
    }
})