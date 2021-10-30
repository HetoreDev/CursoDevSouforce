@IsTest
public with sharing class CarroTest {
    @IsTest
    public static void CarroTest() {
        //Carro carro = new Carro();
        //System.debug(carro.cor);

        Carro carroComCor = new Carro('Vermelho', 'SUV');
        System.debug(carroComCor.cor);
        System.debug(carroComCor.getTipoCarroceria());
    }
}