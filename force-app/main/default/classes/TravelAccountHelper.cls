public class TravelAccountHelper {

    @Future(callout=true)
    public static void fillAddress(String id){
        Account acc = [SELECT Id, BillingCity, BillingCountry, BillingPostalCode, BillingState, BillingStreet FROM Account WHERE Id =: id];

        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('http://viacep.com.br/ws/' + acc.BillingPostalCode + '/json/');

        HttpResponse response = (new Http()).send(request);

        if(response.getStatusCode() == 200){
            Map<String, Object> jsonResponse = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());

            //JSON.deserializeUntyped() -> Esse método irá pegar cada Key do JSON e jogar como String no MAP de recebimento e o Value como Object
            //{    Key       Value
            //    'CEP' : '50123-540'
            //                      }

            acc.BillingCity = String.valueOf(jsonResponse.get('localidade'));
            acc.BillingCountry = 'Brasil';
            acc.BillingPostalCode = String.valueOf(jsonResponse.get('cep'));
            acc.BillingState = String.valueOf(jsonResponse.get('uf'));
            acc.BillingStreet = String.valueOf(jsonResponse.get('logradouro'));
            // Necessário utilizar o valueOf() aqui, pois mesmo o JSON sendo String, ele não irá conseguir atribuir o valor para a Instância 
        }

        update acc;
    }

    @Future
    public static void createOpportunities(List<Id> ids){

        List<Account> accounts = [SELECT Id, TargetCountry__c FROM Account WHERE Id IN: ids];

        Map<String,String> priceBookNames = new Map<String,String>();

        for(Account acc: accounts){
            priceBookNames.put(acc.Id, acc.TargetCountry__c + ' PriceBook');
        }

        Map<String,Pricebook2> priceBooksMap = new Map<String, PriceBook2> ();

        List<Pricebook2> priceBooks = [SELECT Id
                                        , Name
                                        , (
                                            SELECT Id
                                                    , Product2Id
                                                    , Product2.Name
                                                    , ProductCode
                                                    , UnitPrice
                                            FROM PricebookEntries
                                            WHERE IsActive = true
                                        )
                                        FROM Pricebook2
                                        WHERE Name in: priceBookNames.values()
                                    ];
        for(Pricebook2 priceBook : priceBooks){
            priceBooksMap.put(priceBook.Name, priceBook);
        }
        
        List<Opportunity> opps = new List<Opportunity>();

        for (String accId : priceBookNames.keySet()) {
            
            String priceBookName = priceBookNames.get(accId);
            Pricebook2 priceBook = priceBooksMap.get(priceBookName);

            for (PricebookEntry entry : priceBook.PriceBookEntries) {
                //For criado para emular um processamento pesado que tomaria tempo do sistema
                for (Integer i = 0; i < 99000; i++) {
                    
                }

                Opportunity opp = new Opportunity(Name='Opp '+entry.Product2.Name
                                                , AccountId = accId
                                                , CloseDate = System.today().addDays(30)
                                                , StageName = 'Prospecting'
                                                , Pricebook2Id = pricebook.Id
                                            );
                opps.add(opp);
            }
            
        }

        insert opps;

        List<OpportunityLineItem> oppItems = new List<OpportunityLineItem>();

        for (Opportunity opp : opps) {
            
            String priceBookName = priceBookNames.get(opp.accountId);
            Pricebook2 priceBook = priceBooksMap.get(priceBookName);

            for (PricebookEntry entry : priceBook.PriceBookEntries) {
                //For criado para emular um processamento pesado que tomaria tempo do sistema
                for (Integer i = 0; i < 99000; i++) {

                }

                if(opp.Name.contains(entry.Product2.Name)){
                    oppItems.add(new OpportunityLineItem(OpportunityId = opp.Id
                                                                    , UnitPrice = entry.UnitPrice
                                                                    , Product2Id = entry.Product2Id
                                                                    , Quantity = 1
                                                            )
                    );
                }
                
            }
            
        }

        insert oppItems;

    }

}