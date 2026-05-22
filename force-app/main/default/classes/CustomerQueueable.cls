/**
 * CustomerQueueable
 *
 * Brief: Queueable job that processes customer records asynchronously.
 * Responsibilities:
 *  - Accept a list of customer Ids or wrappers and perform integration or processing logic
 *  - Handle partial failures and log outcomes via IntegrationLogger
 *  - Support chaining (if needed) by returning a next job from execute()
 *
 * Note: Inline comments provide guidance on transactional behavior and limits.
 */
public class CustomerQueueable implements System.Queueable, Database.AllowsCallouts {
    // List of customer wrappers or Ids to process
    private List<Id> customerIds;

    // Constructor accepting customer Ids to process
    public CustomerQueueable(List<Id> customerIds) {
        this.customerIds = customerIds;
    }

    // Entry point for the queueable job
    // Performs callouts via CustomerIntegrationService and logs results
    public void execute(System.QueueableContext context) {
        // Query necessary customer fields; keep fields to minimum to avoid heap limits
        List<Contact> customers = [SELECT Id, Email, Name FROM Contact WHERE Id IN :customerIds];

        for (Contact c : customers) {
            try {
                // Wrap contact data for integration
                CustomerWrapper wrapper = new CustomerWrapper(c);
                // Use integration service to send data; endpoint could be stored in Custom Settings
                Integer status = CustomerIntegrationService.sendCustomerData(wrapper, 'https://api.example.com/customers');
                // Log success or non-200 statuses
                IntegrationLogger.logInfo('CustomerQueueable.process', 'Processed Contact Id: ' + c.Id + ' Status: ' + status);
            } catch (Exception e) {
                // Log exceptions; do not rethrow to avoid job failure for entire batch
                IntegrationLogger.logError('CustomerQueueable.execute', e);
            }
        }
    }
}