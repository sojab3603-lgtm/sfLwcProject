/**
 * PatientController
 *
 * Brief: Apex controller exposing patient data to LWCs (or Aura) via @AuraEnabled methods.
 * Responsibilities:
 *  - Provide cacheable read methods for patient lists and search
 *  - Perform server-side filtering and protect against SOQL injection
 *
 * Note: Use @AuraEnabled(cacheable=true) where results are read-only to enable client-side caching.
 */
public with sharing class PatientController {
    @AuraEnabled(cacheable=true)
    public static List<Patient__c> getPatients(String searchKey) {
        // Build search pattern safely to prevent injection
        String searchText = '%' + String.escapeSingleQuotes(searchKey) + '%';
        // Query only necessary fields to reduce heap usage
        return [
            SELECT Id, Name, Age__c, Gender__c
            FROM Patient__c
            WHERE Name LIKE :searchText
            LIMIT 100
        ];
    }
}