public virtual with sharing class Garrafa {
    protected String tipoDeRosca;

    public Garrafa() {
        tipoDeRosca = 'Padrão';
    }

    public virtual void abrirGarrafa(){
        System.debug('Tipo de Rosca: '+tipoDeRosca);
        if(tipoDeRosca == 'Padrão')
        System.debug('Gire a tampa para a esquerda');
    }

}