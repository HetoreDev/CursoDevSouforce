public with sharing class ViewAccountDetailController {

    @TestVisible
    id accounId;
    @TestVisible
    public List<Contact> listContact {get; set;}
    public Boolean isEditMode {get; set;}

    public ViewAccountDetailController(ApexPages.StandardController standardController) {
        this.accounId = standardController.getId();
        this.listContact = getContacts();
        this.isEditMode = false;
    }

    public List<Contact> getContacts(){
        return [SELECT Id, FirstName, LastName, Email FROM Contact WHERE accountId =: this.accounId WITH SECURITY_ENFORCED];
    }

    public Pagereference newContact(){
        this.listContact.add(new Contact(AccountId = this.accounId));
        return null;
    }

    public Pagereference deleteContact(){

        String index = ApexPages.currentPage().getParameters().get('index');
        //o index não é recebido no delContact() pois aqui ele é passado por Ajax na referência da Página

        System.debug('----------------------->' + index);

        Contact con = this.listContact.remove(Integer.valueOf(index));

        if(con.Id != null){
           delete con;
        }  

        return null;
    }

    public Pagereference editContacts(){
        this.isEditMode = true;
        return null;
    }

    public Pagereference saveContacts(){        
        upsert this.listContact;
        this.isEditMode = false;
        return null;
    }

}