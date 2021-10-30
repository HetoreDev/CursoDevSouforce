@IsTest
public class AccountActivitiesScheduleTest {

    @TestSetup
    static void makeData(){
        Account acc = new Account(
            Name = 'Acc Test',
            TargetCountry__c = 'United States',
            Phone = '11111111111'
        );
        insert acc;

        Opportunity opp = new Opportunity(
            Name = 'Opp Test',
            AccountId = acc.Id,
            CloseDate = System.today().addDays(30),
            StageName = 'Prospecting',
            Pricebook2Id = Test.getStandardPricebookId()
        );
        insert opp;

    }

    @IsTest
    static void testCreateActivities(){
        Test.startTest();
            String expression = '0 0 0 * * ? *';
            System.schedule('Test Schedule Job', expression, new AccountActivitiesSchedule());
        Test.stopTest();   
        
        List<Task> listTasks = [SELECT Id FROM Task];

        System.assert(!listTasks.isEmpty());
    }

}
