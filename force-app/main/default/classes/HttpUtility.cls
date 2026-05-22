/**
 * HttpUtility
 *
 * Brief: Helper class that centralizes HTTP callout construction and execution.
 * Responsibilities:
 *  - Build HttpRequest objects with common headers/timeout
 *  - Execute Http.send and return HttpResponse
 *  - Provide test hooks (e.g., injectable endpoints or mock handling)
 *
 * Note: Keep callout logic centralized to simplify retries, logging, and testing.
 */
public with sharing class HttpUtility {
    // Executes the provided HttpRequest and returns the HttpResponse.
    // Params:
    //  - request: populated HttpRequest instance ready to be sent
    public static HttpResponse execute(HttpRequest request) {
        // Default timeout provision; can be overridden by caller via request.setTimeout()
        if (request.getTimeout() == 0) {
            request.setTimeout(20000);
        }

        Http http = new Http();
        // Perform the callout and return the response to caller
        HttpResponse response = http.send(request);
        return response;
    }

    // Convenience factory to create a request with common headers
    // Params:
    //  - endpoint: target URL
    //  - method: HTTP method like 'GET' or 'POST'
    public static HttpRequest buildRequest(String endpoint, String method) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod(method);
        req.setHeader('Content-Type', 'application/json');
        req.setTimeout(20000);
        return req;
    }
}