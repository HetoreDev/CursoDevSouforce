public with sharing class SOSLClass {
    public SOSLClass() {
        /*
        [FIND {art} IN ALL FIELDS RETURNING Account(Id, Name, Type)];
        [FIND {art} IN ALL FIELDS RETURNING Account(Id, Name, Type WHERE Type = 'Customer - Channel')];
        [FIND {uni} IN ALL FIELDS RETURNING Account(Id, Name, Type, BillingState)];
        [FIND {uni} IN ALL FIELDS RETURNING Account(Id, Name, Type, BillingState WHERE BiilingState = 'NY')];
        [FIND {uni} IN ALL FIELDS RETURNING Account(Id, Name, Type, BillingState WHERE BiilingState = 'NY'), Contact(Name)];
        
        A grande diferença é que no SOSL ele irá consultar a valor especificado em todos os campos da tabela selecinada, 
        porém só exibirá o atributo que correponde aos demais campos que foram consultados
        */
    }
}