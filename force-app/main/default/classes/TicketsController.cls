public with sharing class TicketsController {
    @AuraEnabled(cacheable=true)
    public static List<Aeroporto__c> getAeroporto(String search){
        search += '%';

        return [SELECT id, Name, Estado__r.Name, Sigla__c
                FROM Aeroporto__c
                WHERE Name LIKE :search 
                OR Estado__r.Name LIKE :search
                OR Sigla__c LIKE : search
                WITH SECURITY_ENFORCED];
    }

    //Método necessário para converter a Data no padrão de 2020-12-15 para o formato brasileiro 15/12/2020
    private static Date dateParse(String dateString){
        List<String> dt = dateString.split('-');
        Date dtResult = Date.newInstance(Integer.valueOf(dt.get(0)), Integer.valueOf(dt.get(1)), Integer.valueOf(dt.get(2)));

        return dtResult;
    }

    @AuraEnabled(cacheable=true)
    public static List<RetornoVooTO> getVoos(String aeroportoOrigem, String aeroportoDestino, String dataPartida, String dataRetorno){
        Date dtPartida = dateParse(dataPartida);
        Date dtRetorno = dateParse(dataRetorno);

        List<Voo__c> voosOrigem = [SELECT Id, Name, Aeroporto_Chegada__r.Sigla__c, Aeroporto_Partida__r.Sigla__c, Valor__c, Duracao__c,
                                          Companhia__c, Hora_de_Partida__c, Hora_de_Chegada__c, Data_Partida__c, Data_Chegada__c
                                   FROM Voo__C
                                   WHERE Data_Partida__c =: dtPartida 
                                   AND Aeroporto_Partida__C =: aeroportoOrigem 
                                   AND Aeroporto_Chegada__c =: aeroportoDestino
                                   WITH SECURITY_ENFORCED];

        List<Voo__c> voosDestino = [SELECT Id, Name, Aeroporto_Chegada__r.Sigla__c, Aeroporto_Partida__r.Sigla__c, Valor__c, Duracao__c,
                                           Companhia__c, Hora_de_Partida__c, Hora_de_Chegada__c, Data_Partida__c, Data_Chegada__c
                                   FROM Voo__C
                                   WHERE Data_Partida__c =: dtRetorno 
                                   AND Aeroporto_Partida__C =: aeroportoDestino 
                                   AND Aeroporto_Chegada__c =: aeroportoOrigem
                                   WITH SECURITY_ENFORCED];

        List<RetornoVooTO> result = new List<RetornoVooTO>();
        for(Voo__c vooOrigem : voosOrigem){
            for(Voo__c vooDestino : voosDestino){
                result.add(new RetornoVooTO (vooOrigem, vooDestino));
            }
        }    

        return result;
    }

    @AuraEnabled(cacheable=true)
    public static Ticket__c createTicket(String accountId, String vooIdaId, String vooVoltaId){
        //Schema.SObjectType.Ticket__c Vai verificar se o usuário em permissão de criar umm Ticket
        if(Schema.SObjectType.Ticket__c.isCreateable()){
            Ticket__c ticket = new Ticket__c();

            if(Schema.SObjectType.Ticket__c.fields.Account__c.IsCreateable()){
                ticket.Account__c = accountId;
            }

            if(Schema.SObjectType.Ticket__c.fields.Voo_Ida__c.IsCreateable()){
                ticket.Voo_Ida__c = vooIdaId;
            }

            if(Schema.SObjectType.Ticket__c.fields.Voo_Volta__c.IsCreateable()){
                ticket.Voo_Volta__c = vooVoltaId;
            }

            if(ticket != null){
                insert ticket;        
            }
            
            return ticket;

        }else{
            //Caso não tenha, irá criar e lançar uma exceção
            throw new AuraHandledException('Você não tem permissão para criar um ticket, contate o Administrador');
        }
    }

    public class RetornoVooTO {
        @AuraEnabled
        public Voo__c vooIda;
        @AuraEnabled
        public Voo__c vooVolta;

        public RetornoVooTO(Voo__c vooIda, Voo__c vooVolta){
            this.vooIda = vooIda;
            this.vooVolta = vooVolta;
        }
    }

}