public with sharing class Collections {
    public Collections() {
        String[] myArray = new List<String>(); // Não é possível inicializar com uma instancia própria, pois não há construtor para o Array no SF
        List<String> myList= new List<String>();

        myList.add('Parâmetro do tipo da minha Lista');
        myList.add(0, 'Primeira posição');// Opção de inserção na List com definição de posição na List        
        myList.remove(0);// Remove o tem item na posição do index informado
        myList.size(); // retorna em inteiro o número de posições da List / No Apex só é possível usar o size(), não o lengh()
        myList.contains('Primeira posição');// Retorna true/false para a busca de um item na List

        if(!myList.isEmpty()){
            System.debug('Sua lista não está vazia');
        }

        for(String s : myList){
            System.debug(s);
        } 

        for (Integer i = 0; i < myList.size(); i++){
            System.debug(myList[i]);
        } 
        
        Integer x = 0;
        while(x > myList.size()){
            System.debug(myList[x]);
            x++;
        }     

    }

    public void mySetList(){
        //o Set funciona semelhante a uma List, porém ele não armazena valores iguais dentro
        Set<String> mySet = new Set<String>();

        mySet.add('Banana');
        mySet.add('Pera');
        mySet.add('Banana');

        System.debug(mySet);
        System.debug(mySet.size());
        System.debug(mySet.contains('Banana'));

    }

    public void myMapList(){
        //Map<Id, objectList> myMap = new Map<Id, objectList>();
        Map<String, String> myMap = new Map<String, String>();
        
        System.debug(myMap.isEmpty());
        System.debug(myMap.size());
       
        myMap.put('Chave1', 'Valor');// No Map se usa o método put() para inserir um valor
        myMap.put('Chave2', 'Valor');// O valor pode se repetir, mas a chave não
        System.debug(myMap);

        if(myMap.containsKey('Chave1')){
            System.debug('Já existe');
        }
        
        System.debug(myMap.keySet());// retorna uma lista de todas as chaves
        System.debug(myMap.values());// retorna uma lista de todos os valores

        myMap.remove('Chave2');// Só forneço a chave 

    }
}