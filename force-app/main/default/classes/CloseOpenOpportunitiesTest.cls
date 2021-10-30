@IsTest
public class CloseOpenOpportunitiesTest {

    @TestSetup
    static void makeData(){
        Account accTest = new Account(
            Name = 'Acc Test',
            TargetCountry__c = 'United States',
            Phone = '11111111111'
        );
        insert accTest;

        Opportunity opp = new Opportunity(
            Name = 'Opp Test',
            AccountId = accTest.Id,
            CloseDate = System.today().addDays(30),
            StageName = 'Prospecting',
            Pricebook2Id = Test.getStandardPricebookId()
        );
        insert opp;
        
    }

    @IsTest
    static void testCloseOpportunities(){

        Test.startTest();
            Database.executeBatch(new CloseOpenOpportunities());
        Test.stopTest();

        // StageName = 'Closed' -> no método onde seria executado, tem que estar com esse StageName
        List<Opportunity> closedOpp = [SELECT Id FROM Opportunity WHERE StageName = 'Closed'];

        System.assert(!closedOpp.isEmpty());

    }

}