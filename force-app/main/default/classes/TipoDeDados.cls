public with sharing class TipoDeDados {
    public TipoDeDados() {
        String euSouUmaString = 'Aqui vai um texto';
        Boolean verdadeiroOuFalso = true;
        Integer inteiro = 1; // De -2147483648 até +2147483647
        Long longo = 1234567891; // De -2^63 até (2^63)-1 *Somente números inteiros
        Decimal pontoFlutuante1 = 1.634488578; // De -2^63 até (2^63)-1
        Double pontoFlutuante2 = 1.9999999;

        Blob b = Blob.valueOf('Eu sou um Blob'); //Formato que o Salesforce utiliza para armazenar arquivos
        System.debug(b.toString());

        Object qualquerCoisa = false; // Tipo primitivo que pode ser qualquer coisa, qualquer objeto a string e etc

        Date data1 = Date.today(); // Armazena datas
        data1 = data1.addDays(7);
        System.debug(data1);
        Date data2 = Date.today();
        System.debug(data2.dayOfYear() + ' ***');// Exibirá qual o dia do ano para este Date - dia 177 do ano
        
        Date data3 = Date.today();
        Date data4 = Date.today().addDays(-45);
        System.debug(data4.daysBetween(data3));

        Datetime dataEHora = Datetime.now();
        System.debug(dataEHora.time());//retornará somente a hora do DateTime

        Time tempo = Time.newInstance(18, 30, 2, 20);// HH/MM/SS/MS - Somente a hora de uma Data

        /*Enum Season {WINTER, SPRING, SUMMER, FALL}
          Season mySeason = Season.WINTER;

        for(Season s : Season.values()){
            System.debug(s);
        }
        */

        Id myId = 'asdfas1245';

        System.debug(myId);

    }
}