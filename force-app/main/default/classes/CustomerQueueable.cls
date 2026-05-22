public class CustomerQueueable
implements Queueable, Database.AllowsCallouts {

    public void execute(QueueableContext context) {

        CustomerIntegrationService.fetchCustomers();
    }
}