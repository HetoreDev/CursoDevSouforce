public with sharing class UpdateContact {
    
    @InvocableMethod(label='Update Contact')
    public static void UpdateContacts(List<Contact> contatsList) {

            contatsList[0].put('Description', 'The description is update');
            update contatsList;

    }

    /*
    @InvocableMethod(label='Get Account Names')
    public static List<String> getAccountNames(List<ID> ids){
        List<String> accountNames = new List<String>();
        List<String> accounts = [SELECT Name FROM Account WHERE Id IN: ids];
        for(Account account : accounts){
            accountNames.add(account.Name);
        }
		return accountNames;
    }*/ 
    
}