public with sharing class ApexTransactionController {
    public static void saveAccount() {
        System.debug('Method started');

        //Inserir uma conta
        Account account = new Account(Name='Test Apex Transaction Acc', Phone='11999999999');
        Insert account;

        Contact contact = new Contact(Account=account, LastName = 'Test Apex Transaction Contact');
        Insert contact;

        Case caseAccount = new Case(Account=account, Subject='Test Apex Transaction Case');
        Insert caseAccount;

        System.debug('Method finished');
    }   
}