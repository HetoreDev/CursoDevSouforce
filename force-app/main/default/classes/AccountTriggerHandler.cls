public with sharing class AccountTriggerHandler {
    public static void onbeforeInsert(List<Account> newAccountList, Map<Id,Account> newAccountMap){        
        for(Account newAccount : newAccountList){
            if(newAccount.Phone == null) {
                newAccount.addError('Por favor informar o telefone');//Método addError é padrão do sObject        
            }else if(newAccount.Phone.length() < 11){
                newAccount.addError('Por favor informar o telefone com DDD');
            }else{
                AccountTriggerHelper.formatPhone(newAccount);
            }            
        } 
    }

    /* Este é um exemplo de método que é aplicado para trabalhar junto com @Future
    public static void onAfterInsert(List<Account> newAccountList, Map<Id,Account> newAccountMap){        

        List<String> travelAccountList = new List<String>();

        for(Account newAccount : newAccountList){
            if(newAccount.RecordTypeId == Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Travel_Detail').getRecordTypeId()){
                travelAccountList.add(newAccount.Id);

                //Validação importante para toda vez que vc for fazer a chamada de um método @Future
                if(!System.isFuture() && !System.isBatch()){
                    TravelAccountHelper.fillAddress(newAccount.Id);
                }                                               
            }
        }
        
        //Validação importante para toda vez que vc for fazer a chamada de um método @Future
        if(!System.isFuture() && !System.isBatch()){
            TravelAccountHelper.createOpportunities(travelAccountList);
        }     
        
    }
    */

    /* Este é um exemplo de método que é aplicado para trabalhar junto com Queueable
    public static void onAfterInsert(List<Account> newAccountList, Map<Id,Account> newAccountMap){        

        List<String> travelAccountList = new List<String>();

        for(Account newAccount : newAccountList){
            if(newAccount.RecordTypeId == Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Travel_Detail').getRecordTypeId()){
                travelAccountList.add(newAccount.Id);

                //Validação importante para toda vez que vc for fazer a chamada de um método @Future
                if(!System.isFuture() && !System.isBatch()){
                    TravelAccountHelper.fillAddress(newAccount.Id);
                }                                               
            }
        }
        
        System.enqueueJob(new TravelAccountQueueable(newAccountList));
        
    }
    */

    public static void onAfterInsert(List<Account> newAccountList, Map<Id,Account> newAccountMap){        

        List<String> travelAccountList = new List<String>();

        for(Account newAccount : newAccountList){
            if(newAccount.RecordTypeId == Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Travel_Detail').getRecordTypeId()){
                travelAccountList.add(newAccount.Id);                                         
            }
        }
        
        System.enqueueJob(new TravelAccountQueueable(newAccountList));
        
    }

}