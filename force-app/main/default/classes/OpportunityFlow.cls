public with sharing class OpportunityFlow {
    @InvocableMethod(label='Opportunity Flow' description='Run opportunity flow by Apex')
    public static void execute(List<Opportunity> records) {
        //Regra de Negócio 
        System.debug(records); 
    }
}