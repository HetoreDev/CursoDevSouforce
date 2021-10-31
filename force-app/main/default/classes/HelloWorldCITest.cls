@IsTest
public class HelloWorldCITest {
    @IsTest
    static void HelloWorldCITest() {
        System.assertEquals(HelloWorldCI.sayHello('Hetore Martins'), 'Hello Hetore Martins');
    }
}
