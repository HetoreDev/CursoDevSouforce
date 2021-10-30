public with sharing class AccountAddressService {

    @AuraEnabled(Continuation=true cacheable=true)
    public static Object beginSearchAddress(String zipCode){

        Continuation con = new Continuation(120); //120 tempo máximo possível de timeout
        con.ContinuationMethod = 'endSearchAddress';// após o recimento de response será chamado este método

        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('http://viacep.com.br/ws/' + zipCode + '/json/');
        con.addHttpRequest(request);

        return con;
    }    

    @AuraEnabled(cacheable=true)
    public static Map<String,Object> endSearchAddress(List<String> labels, Object state){
        HttpResponse response = Continuation.getResponse(labels[0]);

        return (Map<String,Object>) JSON.deserializeUntyped(response.getBody());
    }

}
