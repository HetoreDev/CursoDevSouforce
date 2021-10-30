public with sharing class AccountControllerExtension {

    public List<Contact> listContact {get;set;}//Necessário settar com get e set no caso de extensionController para VF
    List<Contact> listContactToDelete;
    public Account account {get;set;}

    public AccountControllerExtension(ApexPages.StandardController standardController) {
        //Necessário colocar o parâmetro no construtor para herdar as caracterísitcas de uma claasse de extensão de controller
        this.account = standardController.getRecord() == null ? new Account() : (Account)standardController.getRecord();
        this.listContact = new List<Contact>();
        this.listContactToDelete = new List<Contact>();

        if(this.account.Id != null){
            this.listContact = [SELECT Id, FirstName, LastName, Email FROM Contact WHERE AccountId =: this.account.Id];
        }
    }

    public Pagereference addContact(){
        //Método utilizado para referenciar para outras páginas ou apenas para atualizar a mesma página
        this.listContact.add(new Contact());

        //com o valor null, retornará para a própria pagina que chamou, refresh
        return null;
    }

    public Pagereference deleteContact(){
        //Método utilizado para referenciar para outras páginas ou apenas para atualizar a mesma página
        
        String index = ApexPages.currentPage().getParameters().get('index');
        //o index não é recebido no delContact() pois aqui ele é passado por Ajax na referência da Página

        System.debug('----------------------->' + index);

        Contact con = this.listContact.remove(Integer.valueOf(index));

        if(con.Id != null){
           listContactToDelete.add(con); 
        }

        //com o valor null, retornará para a própria pagina que chamou, refresh
        return null;
    }

    public Pagereference saveAccount(){
        upsert account;

        for(Contact contact : this.listContact){
            contact.AccountId = account.Id;

        }

        upsert this.listContact;

        if(!listContactToDelete.isEmpty()){
            delete this.listContactToDelete;
        }

        ApexPages.StandardController controller = new ApexPages.StandardController(account); 

        return controller.view();
    }

}