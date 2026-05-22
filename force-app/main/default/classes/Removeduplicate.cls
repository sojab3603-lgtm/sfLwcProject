/**
 * Removeduplicate
 *
 * Brief: Utility class to remove duplicate records based on business keys.
 * Responsibilities:
 *  - Identify duplicates using a deterministic key (e.g., email or external Id)
 *  - Merge or delete duplicates while preserving the primary record
 *
 * Note: Ensure this logic is executed in batches to respect governor limits.
 */
public with sharing class Removeduplicate {
    // Removes duplicate contacts based on Email; returns number of deleted records.
    public static Integer removeDuplicateContacts() {
        // Collect contacts grouped by Email
        Map<String, List<Contact>> byEmail = new Map<String, List<Contact>>();
        for (Contact c : [SELECT Id, Email FROM Contact WHERE Email != null]) {
            if (!byEmail.containsKey(c.Email)) byEmail.put(c.Email, new List<Contact>());
            byEmail.get(c.Email).add(c);
        }

        List<Contact> toDelete = new List<Contact>();
        for (String emailKey : byEmail.keySet()) {
            List<Contact> listForEmail = byEmail.get(emailKey);
            if (listForEmail.size() > 1) {
                // Keep the first record and mark others for deletion
                for (Integer i = 1; i < listForEmail.size(); i++) {
                    toDelete.add(listForEmail[i]);
                }
            }
        }

        if (!toDelete.isEmpty()) {
            delete toDelete;
        }
        return toDelete.size();
    }
}