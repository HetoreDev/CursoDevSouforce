public abstract with sharing class Pizza {
    private Integer quantidadeDeSabores{get;set;}
    
    public Pizza(Integer quantidadeDeSabores) {
        this.quantidadeDeSabores = quantidadeDeSabores;
    }

    public abstract List<String> ingredientes();

    public void prepararPizza(){
        for(String ingredidente : ingredientes()){
            System.debug(ingredidente);
        }
    }

}