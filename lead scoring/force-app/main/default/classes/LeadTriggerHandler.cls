public with sharing class LeadTriggerHandler {
    public void run() {
        if (Trigger.isBefore) {
            if (Trigger.isInsert || Trigger.isUpdate) {
                LeadScoring.calculateScore((List<Lead>)Trigger.new);
            }
        }
    }
}
