public with sharing class HttpUtility {

    public static HttpResponse sendRequest(
        String endpoint,
        String method
    ) {

        HttpRequest request = new HttpRequest();

        request.setEndpoint(endpoint);

        request.setMethod(method);

        request.setHeader(
            'Content-Type',
            'application/json'
        );

        request.setTimeout(20000);

        Http http = new Http();

        HttpResponse response =
            http.send(request);

        return response;
    }
}