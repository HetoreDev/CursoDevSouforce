public with sharing class ObjectSchema {
    public ObjectSchema() {
        System.debug(Schema.SObjectType.Account.getRecordTypeInfosByName());
        // Vai retornar um map com todos os Records Types disponíveis para o Object Account

        System.debug(Schema.SObjectType.Account.fields.Name);
        //Retorna informações de todos os campos do Objeto

    }
}