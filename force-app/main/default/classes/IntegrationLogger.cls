/**
 * IntegrationLogger
 *
 * Brief: Centralized logger to persist integration request/response records.
 * Responsibilities:
 *  - Create Integration_Log__c records with request, response, status, endpoint, and error info
 *  - Provide helper entry points for info, warn, and error logging
 *
 * Note: Keep logging non-throwing to avoid interrupting business flows.
 */
public with sharing class IntegrationLogger {
    // Generic log method used by convenience wrappers below.
    public static void log(String context, Integer status, String requestData, String responseData, String errorMessage, String endpoint) {
        Integration_Log__c logRecord = new Integration_Log__c();
        logRecord.Context__c = context;
        logRecord.Status__c = status;
        logRecord.Request__c = requestData;
        logRecord.Response__c = responseData;
        logRecord.Error_Message__c = errorMessage;
        logRecord.Endpoint__c = endpoint;
        insert logRecord;
    }

    // Convenience method for informational messages (successful calls)
    public static void logInfo(String context, String message) {
        log(context, 200, message, null, null, null);
    }

    // Convenience method for errors — captures exception message
    public static void logError(String context, Exception e) {
        log(context, null, null, null, e.getMessage(), null);
    }
}