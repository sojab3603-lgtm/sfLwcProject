public with sharing class CustomerIntegrationService {

    public static void fetchCustomers() {

        String endpoint =
            'callout:CustomerAPI/users';

        try {

            HttpResponse response =
                HttpUtility.sendRequest(
                    endpoint,
                    'GET'
                );

            Integer statusCode =
                response.getStatusCode();

            if(statusCode == 200){

                List<CustomerWrapper> customers =
                    (List<CustomerWrapper>)
                    JSON.deserialize(
                        response.getBody(),
                        List<CustomerWrapper>.class
                    );

                List<Customer__c> customerRecords =
                    new List<Customer__c>();

                for(CustomerWrapper customer : customers){

                    Customer__c cust =
                        new Customer__c();

                    cust.Customer_Id__c =
                        customer.id;

                    cust.Full_Name__c =
                        customer.name;

                    cust.Email__c =
                        customer.email;

                    cust.Phone__c =
                        customer.phone;

                    if(customer.address != null){

                        cust.City__c =
                            customer.address.city;
                    }

                    customerRecords.add(cust);
                }

                if(!customerRecords.isEmpty()){

                    upsert customerRecords Customer_Id__c;
                }

                IntegrationLogger.log(
                    'Success',
                    null,
                    response.getBody(),
                    null,
                    endpoint
                );

            } else {

                IntegrationLogger.log(
                    'Failed',
                    null,
                    response.getBody(),
                    'Status Code: ' + statusCode,
                    endpoint
                );
            }

        } catch(Exception ex){

            IntegrationLogger.log(
                'Exception',
                null,
                null,
                ex.getMessage(),
                endpoint
            );
        }
    }
}