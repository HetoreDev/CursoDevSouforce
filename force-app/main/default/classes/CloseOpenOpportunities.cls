public with sharing class CloseOpenOpportunities implements Database.Batchable<sObject> {
    // Database.AllowCallouts - realiza chamada de serviços em um Batch
    // Database.Stateful - utilizado para monitorar a execução dos lotes

    public CloseOpenOpportunities() {

    }

    // método necessário em um Batch - o retorno pode ser Data.QueryLocator ou Iterator - Este método é responsável por pegar a massa de dados que será utilizada
    public Database.QueryLocator start(Database.BatchableContext BC){
        String query='SELECT Id, StageName FROM Opportunity WHERE lastModifiedDate <= last_n_days : 1 AND StageName != \'Closed\'';

        return Database.getQueryLocator(query);
    }

    //Esse método é responsável por processar a lógica desejada
    //List<sObject> scope é onde é feito a separação dos lotes, 1000/5 = 200, cada posição desta List conterá 200 registros 
    public void execute(Database.BatchableContext BC, List<sObject> scope){
        List<Opportunity> opps = new List<Opportunity>();

        for(sObject obj : scope){
            Opportunity opp = (Opportunity) obj;

            opp.StageName = 'Closed';

            opps.add(opp);
        }

        update opps;

    }

    //Método responsável pelo pós-processamento, pode ser utilizado para realizar um reschedule deste batch, ou envio de e-mail após a confirmação do envio
    public void finish(Database.BatchableContext BC){

    }

}

/* 
Como realizar uma chamda por Apex

CloseOpenOpportunities closeOppBatch = new CloseOpenOpportunities();

Database.executeBatch(closeOppBatch, 200);

OU

System.ScheduleBatch(closeOppBatch, 'Scheduled Batch', 5, 200);

*/
