/**
 * CustomerScheduler
 *
 * Brief: Schedulable class that triggers periodic customer processing.
 * Responsibilities:
 *  - Schedule/enqueue CustomerQueueable jobs at configured intervals
 *  - Provide a single entry point for scheduled automation
 *
 * Note: Keep scheduled logic lightweight; heavy work should be delegated to Queueable jobs.
 */
public class CustomerScheduler implements Schedulable {
    // Schedulable entry point invoked by Apex scheduler
    public void execute(SchedulableContext context) {
        // Enqueue the queueable job to process customers asynchronously
        System.enqueueJob(new CustomerQueueable(new List<Id>())); // Pass real Ids in production
    }
}