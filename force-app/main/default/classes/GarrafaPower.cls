public with sharing class GarrafaPower extends Garrafa{
    public GarrafaPower() {
        tipoDeRosca = 'Inversa';
    }

    public override void abrirGarrafa(){
        System.debug('Precione a tampa');
        System.debug('Gire a tampa para a direita');
    }
}