/**
 * PatientControllerTest
 *
 * Brief: Unit tests for PatientController methods.
 * Responsibilities:
 *  - Create test Patient__c records and verify getPatients returns expected results
 *  - Cover positive and edge cases for searchKey handling
 *
 * Note: Use Test.startTest/Test.stopTest when invoking cacheable or async behavior.
 */
@isTest
private class PatientControllerTest {
    public static void testGetPatients() {
        // Create test patients
        List<Patient__c> patients = new List<Patient__c>{
            new Patient__c(Name='John Doe', Age__c=30, Gender__c='M'),
            new Patient__c(Name='Jane Smith', Age__c=25, Gender__c='F')
        };
        insert patients;

        // Execute the controller method and assert results
        List<Patient__c> result = PatientController.getPatients('John');
        System.assertEquals(1, result.size());
        System.assertEquals('John Doe', result[0].Name);
    }
}