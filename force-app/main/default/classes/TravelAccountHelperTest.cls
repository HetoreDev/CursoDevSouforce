@IsTest
public class TravelAccountHelperTest {

    @TestSetup
    static void makeData(){
        
        Product2 testProduct = new Product2(Name = 'Holiday Package 1', IsActive = true, ProductCode = '1');        
        Product2 testProduct2 = new Product2(Name = 'Holiday Package 2', IsActive = true, ProductCode = '2');         
        insert new List<Product2> {testProduct, testProduct2};

        Pricebook2 priceBook = new Pricebook2(Name = 'United States PriceBook', IsActive = true);
        insert priceBook;

        PricebookEntry standardPriceProduct = new PricebookEntry(Pricebook2Id = Test.getStandardPricebookId(), Product2Id = testProduct.Id, IsActive = true, UnitPrice = 1);
        PricebookEntry standardPriceProduct2 = new PricebookEntry(Pricebook2Id = Test.getStandardPricebookId(), Product2Id = testProduct2.Id, IsActive = true, UnitPrice = 1);
        PricebookEntry customPriceProduct = new PricebookEntry(Pricebook2Id = priceBook.Id, Product2Id = testProduct.Id, IsActive = true, UnitPrice = 1);
        PricebookEntry customPriceProduct2 = new PricebookEntry(Pricebook2Id = priceBook.Id, Product2Id = testProduct2.Id, IsActive = true, UnitPrice = 1);
        insert new List<PricebookEntry>{standardPriceProduct, standardPriceProduct2, customPriceProduct, customPriceProduct2};

        Account accTest = new Account(Name = 'Acc Test', TargetCountry__c = 'United States', Phone = '11111111111');
        insert accTest;  
        
        Account accFillAddressTest = new Account(Name = 'Acc Fill Address', TargetCountry__c = 'United States', Phone = '22222222222', BillingPostalCode = '01001-000');
        insert accFillAddressTest;
         
    }

    @IsTest
    static void testCreateOpportunities(){

        Account acc = [SELECT Id FROM Account WHERE Name = 'Acc Test'];

        Test.startTest();
            TravelAccountHelper.createOpportunities(new List<Id>{acc.Id});
            List<Opportunity> oppBeforeExecute = [SELECT Id FROM Opportunity WHERE AccountId =: acc.Id];
            //Verificação com o objetivo de assegurar que job futuro de fato foi apenas enfileirado e não executado
            //System.assert(oppBeforeExecute.isEmpty());
        Test.stopTest();

        List<Opportunity> oppAfterExecute = [SELECT Id FROM Opportunity WHERE AccountId =: acc.Id];
        
        System.assert(!oppAfterExecute.isEmpty());

    }

    @IsTest
    static void testAccountFillAddress(){

        Account accBfr = [SELECT Id FROM Account WHERE Name = 'Acc Fill Address'];
        
        Test.startTest();
            TravelAccountHelper.fillAddress(accBfr.Id);
        Test.stopTest();

        Account accAft = [SELECT Id, BillingCountry, BillingState, BillingStreet, BillingCity FROM Account WHERE Name = 'Acc Fill Address'];
        Boolean isChecked = (String.isNotEmpty(accAft.BillingCountry) && String.isNotEmpty(accAft.BillingState) && String.isNotEmpty(accAft.BillingStreet) && String.isNotEmpty(accAft.BillingCity));

        System.assertEquals(true, isChecked);

    }

}
