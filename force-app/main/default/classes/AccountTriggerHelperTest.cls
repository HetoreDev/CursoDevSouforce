@IsTest
public class AccountTriggerHelperTest {
    @IsTest
    static void formatPhoneTest(){
        Account acc = new Account(
            Name = 'Test',
            phone = '11987654321'
        );

        //Necessário para resetar todos os indicadores como também acionar classes/methods assíncronos  
        Test.startTest();
            AccountTriggerHelper.formatPhone(acc);
            System.assertEquals('(11)9.8765-4321', acc.Phone);
        Test.stopTest();
    }

}
