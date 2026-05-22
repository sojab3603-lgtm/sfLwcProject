import { createElement } from '@lwc/engine-dom';
import PatientForm from 'c/patientForm';
import { ShowToastEventName } from 'lightning/platformShowToastEvent';

describe('c-patient-form', () => {
    afterEach(() => {
        // Clean up DOM after each test
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('should render the form component', () => {
        const element = createElement('c-patient-form', {
            is: PatientForm
        });
        document.body.appendChild(element);

        const card = element.shadowRoot.querySelector('lightning-card');
        expect(card).not.toBeNull();
        expect(card.title).toBe('Patient Form');
    });

    it('should show "Create Patient" label when no recordId', () => {
        const element = createElement('c-patient-form', {
            is: PatientForm
        });
        document.body.appendChild(element);

        return Promise.resolve().then(() => {
            const submitButton = element.shadowRoot.querySelector('lightning-button[type="submit"]');
            expect(submitButton.label).toBe('Create Patient');
        });
    });

    it('should show "Update Patient" label when recordId is provided', () => {
        const element = createElement('c-patient-form', {
            is: PatientForm
        });
        element.recordId = '001000000000001';
        document.body.appendChild(element);

        return Promise.resolve().then(() => {
            const submitButton = element.shadowRoot.querySelector('lightning-button[type="submit"]');
            expect(submitButton.label).toBe('Update Patient');
        });
    });

    it('should render all required input fields', () => {
        const element = createElement('c-patient-form', {
            is: PatientForm
        });
        document.body.appendChild(element);

        return Promise.resolve().then(() => {
            const inputFields = element.shadowRoot.querySelectorAll('lightning-input-field');
            expect(inputFields.length).toBeGreaterThanOrEqual(4);
            
            const fieldNames = Array.from(inputFields).map(field => field.fieldName);
            expect(fieldNames).toContain('Full_Name__c');
            expect(fieldNames).toContain('Age__c');
            expect(fieldNames).toContain('Gender__c');
            expect(fieldNames).toContain('Phone__c');
        });
    });

    it('should dispatch patientsaved event on successful form submission', () => {
        const element = createElement('c-patient-form', {
            is: PatientForm
        });
        document.body.appendChild(element);

        const handler = jest.fn();
        element.addEventListener('patientsaved', handler);

        return Promise.resolve().then(() => {
            const form = element.shadowRoot.querySelector('lightning-record-edit-form');
            form.dispatchEvent(new CustomEvent('success', {
                detail: { id: '001000000000001' }
            }));

            return Promise.resolve();
        }).then(() => {
            expect(handler).toHaveBeenCalled();
            expect(handler.mock.calls[0][0].detail.recordId).toBe('001000000000001');
        });
    });

    it('should show success message after form submission', () => {
        const element = createElement('c-patient-form', {
            is: PatientForm
        });
        document.body.appendChild(element);

        return Promise.resolve().then(() => {
            const form = element.shadowRoot.querySelector('lightning-record-edit-form');
            form.dispatchEvent(new CustomEvent('success', {
                detail: { id: '001000000000001' }
            }));

            return Promise.resolve();
        }).then(() => {
            const successAlert = element.shadowRoot.querySelector('.slds-alert_success');
            expect(successAlert).not.toBeNull();
            expect(successAlert.textContent).toContain('Patient saved successfully!');
        });
    });

    it('should show error message on form submission failure', () => {
        const element = createElement('c-patient-form', {
            is: PatientForm
        });
        document.body.appendChild(element);

        return Promise.resolve().then(() => {
            const form = element.shadowRoot.querySelector('lightning-record-edit-form');
            form.dispatchEvent(new CustomEvent('error', {
                detail: { message: 'Test error message' }
            }));

            return Promise.resolve();
        }).then(() => {
            const errorAlert = element.shadowRoot.querySelector('.slds-alert_error');
            expect(errorAlert).not.toBeNull();
            expect(errorAlert.textContent).toContain('Test error message');
        });
    });

    it('should dispatch cancel event when cancel button is clicked', () => {
        const element = createElement('c-patient-form', {
            is: PatientForm
        });
        document.body.appendChild(element);

        const handler = jest.fn();
        element.addEventListener('cancel', handler);

        return Promise.resolve().then(() => {
            const cancelButton = element.shadowRoot.querySelector('lightning-button[label="Cancel"]');
            cancelButton.click();

            return Promise.resolve();
        }).then(() => {
            expect(handler).toHaveBeenCalled();
        });
    });

    it('should reset form when reset() method is called', () => {
        const element = createElement('c-patient-form', {
            is: PatientForm
        });
        document.body.appendChild(element);

        element.showSuccess = true;
        element.errorMessage = 'Test error';

        element.reset();

        return Promise.resolve().then(() => {
            expect(element.showSuccess).toBe(false);
            expect(element.errorMessage).toBe('');
        });
    });

    it('should show toast event on success', () => {
        const element = createElement('c-patient-form', {
            is: PatientForm
        });
        document.body.appendChild(element);

        const handler = jest.fn();
        element.addEventListener(ShowToastEventName, handler);

        return Promise.resolve().then(() => {
            const form = element.shadowRoot.querySelector('lightning-record-edit-form');
            form.dispatchEvent(new CustomEvent('success', {
                detail: { id: '001000000000001' }
            }));

            return Promise.resolve();
        }).then(() => {
            expect(handler).toHaveBeenCalled();
            expect(handler.mock.calls[0][0].detail.title).toBe('Success');
            expect(handler.mock.calls[0][0].detail.variant).toBe('success');
        });
    });
});