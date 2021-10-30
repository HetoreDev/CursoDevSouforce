public with sharing class TOReceitaAPI {

    public List<Atividade_principal> atividade_principal;
    public String data_situacao;
    public String nome;
    public String uf;
    public String telefone;
    public List<Atividade_principal> atividade_secundaria;
    public List<Qsa> qsa;
    public String situacao;    
    public String bairro;
    public String logradouro;
    public String numero;
    public String cep;
    public String municipio;
    public String porte;
    public String abertura;
    public String natureza_juridica;
    public String fantasia;
    public String cnpj;
    public String ultima_atualizacao;
    public String status;
    public String message;
    public String tipo;
    public String complemento;
    public String email;
    public String efr;
    public String motivo_situacao;
    public String situacao_especial;
    public String data_situacao_especial;
    public String capital_social;
    public String extra;
    public String billing;
    

    public TOReceitaAPI() {
    }

    public class Extra {
    }

    public class Billing {
        public Boolean free;
        public Boolean database;
    }

    public class Atividade_principal {
        public String text;
        public String code;
    }

    public class Qsa {
        public String qual;
        public String nome;
    }

    public static TOReceitaAPI parse(String json){
        return (TOReceitaAPI) System.JSON.deserialize(json, TOReceitaAPI.class);
    }

}
