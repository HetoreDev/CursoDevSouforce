public with sharing class SOQLClass {
    public SOQLClass() {
        /*
        [SELECT Id, Name, Type, BillingState FROM Account WHERE (Type = 'Customer - Channel' OR Type = 'Customer - Direct') AND BillingState = 'CA'];
        [SELECT Id, Name, Type, BillingState FROM Account WHERE (Type = 'Customer - Channel' OR Type = 'Customer - Direct') AND BillingState LIKE 'C%'];
        [SELECT Id, Name, Type, BillingState FROM Account WHERE (Type = 'Customer - Channel' OR Type = 'Customer - Direct') AND (NOT BillingState LIKE '%C%')];
        [SELECT Id, Name, Type, BillingState FROM Account WHERE Type IN ('Customer - Channel','Customer - Direct')];
        [SELECT Id, Name, Type, BillingState FROM Account WHERE Type IN ('Customer - Channel','Customer - Direct') LIMIT 5];
        [SELECT Id, Name, Type, BillingState FROM Account WHERE Type IN ('Customer - Channel','Customer - Direct') ORDER BY Type LIMIT 30];
        [SELECT Id, Name, Type, BillingState FROM Account WHERE Type IN ('Customer - Channel','Customer - Direct') ORDER BY Name ASC];
        [SELECT count(Id), Type FROM Account WHERE Type IN ('Customer - Channel','Customer - Direct') GROUP BY Type];
        [SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account]; 
        */
    }
}