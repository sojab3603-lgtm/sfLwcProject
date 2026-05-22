import { LightningElement, wire, track } from 'lwc';

import getPatients from '@salesforce/apex/PatientController.getPatients';

const COLUMNS = [
    { label: 'Patient Number', fieldName: 'Name' },
    { label: 'Full Name', fieldName: 'Full_Name__c' },
    { label: 'Age', fieldName: 'Age__c', type: 'number' },
    { label: 'Gender', fieldName: 'Gender__c' },
    { label: 'Phone', fieldName: 'Phone__c' }
];

export default class PatientList extends LightningElement {

    columns = COLUMNS;

    @track patients;

    searchKey = '';

    @wire(getPatients, { searchKey: '$searchKey' })
    wiredPatients({ error, data }) {

        if (data) {

            this.patients = data;

        } else if (error) {

            console.error(error);
        }
    }

    handleSearch(event) {

        this.searchKey = event.target.value;
    }
}