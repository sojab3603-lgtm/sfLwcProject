public class CustomerScheduler implements Schedulable {

    public void execute(SchedulableContext context) {

        System.enqueueJob(new CustomerQueueable());
    }
}