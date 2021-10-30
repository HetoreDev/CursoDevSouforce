public with sharing class ConceitoApex {    
        
    public void fazerPizza(Object pizza){
        Boolean isPizza = pizza instanceof Pizza;

        if(!isPizza){
            throw new PizzaException('Isso não é uma pizza');
        }else{
            ((Pizza)pizza).prepararPizza();
        }
    }

    public void testandoMetodo(){
        //String pizza = 'Portuguesa';
        Portuguesa pp = new Portuguesa();
        fazerPizza(pp);
    }

    public class PizzaException extends Exception{}
   
}

//ConceitoApex c = new ConceitoApex(); c.testandoMetodo();