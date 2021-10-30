public with sharing class PagamentoCartao implements IPagamento{
    public PagamentoCartao() {}

    public Decimal cobrar(Decimal valorCompra, Decimal valorPago){
        //Regra de negócio de pagamento     
            return valorPago - valorCompra;       
    }

}