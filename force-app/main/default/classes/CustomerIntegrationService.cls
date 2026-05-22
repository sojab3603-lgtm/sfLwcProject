/**
 * CustomerIntegrationService
 *
 * Brief: Service class responsible for integrating customer data with external systems.
 * Responsibilities:
 *  - Build and send HTTP requests for customer operations
 *  - Parse and map responses to internal types/wrappers
 *  - Provide retry and error handling hooks for queueable or scheduled callers
 *
 * Note: Inline comments explain method responsibilities and important parameters.
 */
public with sharing class CustomerIntegrationService {
    // Sends customer data to external API and returns status code.
    // Params:
    //  - customerWrapper: wrapper object containing customer fields to send
    //  - endpoint: target URL for the external service
    public static Integer sendCustomerData(CustomerWrapper customerWrapper, String endpoint) {
        // Build HTTP request using HttpUtility helper
        // Important: ensure CustomerWrapper is validated before calling this method
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setBody(JSON.serialize(customerWrapper));

        // Use HttpUtility to execute request and return the response status
        HttpResponse res = HttpUtility.execute(req);
        return res.getStatusCode();
    }

    // Parses response body into CustomerWrapper or null on failure.
    // Params:
    //  - responseBody: JSON string returned from external API
    public static CustomerWrapper parseResponse(String responseBody) {
        // Attempt to deserialize; callers should handle null result
        try {
            return (CustomerWrapper) JSON.deserialize(responseBody, CustomerWrapper.class);
        } catch (Exception e) {
            IntegrationLogger.logError('CustomerIntegrationService.parseResponse', e);
            return null;
        }
    }
}