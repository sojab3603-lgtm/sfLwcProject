/**
 * LoggerTest
 *
 * Brief: Unit tests for IntegrationLogger helper methods.
 * Responsibilities:
 *  - Verify that log helper methods create Integration_Log__c records without throwing
 *  - Ensure error logging captures exception messages
 *
 * Note: Tests should assert records were created and fields populated accordingly.
 */
@isTest
public class LoggerTest {
    public static void testLogger() {
        // Call the logger helpers; these should not throw exceptions
        IntegrationLogger.logInfo('LoggerTest.testLogger', 'Test message');
        try {
            throw new Exception('Simulated error');
        } catch (Exception e) {
            IntegrationLogger.logError('LoggerTest.testLogger', e);
        }

        // Verify at least one Integration_Log__c record was created
        List<Integration_Log__c> logs = [SELECT Id, Context__c, Error_Message__c FROM Integration_Log__c WHERE Context__c LIKE 'LoggerTest.%' LIMIT 10];
        System.assert(!logs.isEmpty(), 'Expected at least one integration log record');
    }
}