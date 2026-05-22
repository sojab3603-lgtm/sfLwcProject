public with sharing class IntegrationLogger {

    public static void log(
        String status,
        String requestData,
        String responseData,
        String errorMessage,
        String endpoint
    ) {

        Integration_Log__c logRecord =
            new Integration_Log__c();

        logRecord.Status__c = status;

        logRecord.Request__c = requestData;

        logRecord.Response__c = responseData;

        logRecord.Error_Message__c = errorMessage;

        logRecord.Endpoint__c = endpoint;

        insert logRecord;
    }
}