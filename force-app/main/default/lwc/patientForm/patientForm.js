import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class PatientForm extends LightningElement {
    @api recordId;
    @api objectApiName = 'Patient__c';
    
    showSuccess = false;
    errorMessage = '';

    get submitLabel() {
        return this.recordId ? 'Update Patient' : 'Create Patient';
    }

    get isEditMode() {
        return !!this.recordId;
    }

    handleSubmit(event) {
        event.preventDefault();
        const fields = event.detail.fields;
        
        // You can add custom validation here if needed
        console.log('Submitting form with fields:', fields);
        
        // Submit the form
        this.template.querySelector('lightning-record-edit-form').submit(fields);
    }

    handleSuccess(event) {
        const recordId = event.detail.id;
        
        // Show success message
        this.showSuccess = true;
        this.errorMessage = '';
        
        // Dispatch custom event to notify parent component
        this.dispatchEvent(new CustomEvent('patientsaved', {
            detail: { recordId: recordId }
        }));

        // Show toast notification
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: this.isEditMode ? 'Patient updated successfully' : 'Patient created successfully',
                variant: 'success'
            })
        );

        // Hide success message after 3 seconds
        setTimeout(() => {
            this.showSuccess = false;
            
            // Reset form if creating new record
            if (!this.recordId) {
                this.resetForm();
            }
        }, 3000);
    }

    handleError(event) {
        // Handle form errors
        this.showSuccess = false;
        
        if (event.detail && event.detail.detail) {
            this.errorMessage = event.detail.detail;
        } else if (event.detail && event.detail.message) {
            this.errorMessage = event.detail.message;
        } else {
            this.errorMessage = 'An error occurred while saving the patient record.';
        }

        // Show toast notification
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Error',
                message: this.errorMessage,
                variant: 'error'
            })
        );

        // Hide error message after 5 seconds
        setTimeout(() => {
            this.errorMessage = '';
        }, 5000);
    }

    handleCancel() {
        // Reset form
        this.resetForm();
        
        // Dispatch cancel event to parent component
        this.dispatchEvent(new CustomEvent('cancel'));
    }

    resetForm() {
        // Reset form fields
        const inputFields = this.template.querySelectorAll('lightning-input-field');
        if (inputFields) {
            inputFields.forEach(field => {
                field.reset();
            });
        }
        
        // Clear messages
        this.showSuccess = false;
        this.errorMessage = '';
    }

    // Public method to reset the form from parent component
    @api
    reset() {
        this.resetForm();
    }
}