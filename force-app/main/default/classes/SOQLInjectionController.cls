public with sharing class SOQLInjectionController {

    public List<AccountWrapper> accounts {get;set;}
    public String inputName {get;set;}
    public String error {get;set;}

    public SOQLInjectionController() {
        accounts = new List<AccountWrapper>();
    }

    Public Pagereference searchAccounts(){
        String query = 'SELECT Id, Name, Phone FROM Account WHERE Name LIKE \'%' + String.escapeSingleQuotes(this.inputName) + '%\'';

        try {
            for(Account acc : Database.query(query)){
                accounts.add(new AccountWrapper(acc));
            }
            //accounts = Database.query(query);
            //accounts = [SELECT Id, Name, Phone FROM Account WHERE Name LIKE :'%' + this.inputName + '%'];

        } catch (Exception exc) {
            error = exc.getMessage(); 
        }

        return null;
    }


    public class AccountWrapper{
        public Account acc;

        public AccountWrapper(Account acc){
            this.acc = acc;
        }

        public String AccName{
            get{
                return Schema.SObjectType.Account.fields.Name.isAccessible() ? acc.Name : '';
            }
        }

        public String AccPhone{
            get{
                return Schema.SObjectType.Account.fields.Phone.isAccessible() ? acc.Phone : '';
            }
        }

    }

}