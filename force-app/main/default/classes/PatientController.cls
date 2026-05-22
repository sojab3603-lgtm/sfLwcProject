public with sharing class PatientController {

    @AuraEnabled(cacheable=true)
    public static List<Patient__c> getPatients(String searchKey) {

        String searchText = '%' + searchKey + '%';

        return [
            SELECT Id,
                   Name,
                   Full_Name__c,
                   Age__c,
                   Gender__c,
                   Phone__c
            FROM Patient__c
            WHERE Full_Name__c LIKE :searchText
            ORDER BY CreatedDate DESC
        ];
    }
}