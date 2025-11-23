public with sharing class LeadScoringBatch implements Database.Batchable<SObject> {
    
    public Database.QueryLocator start(Database.BatchableContext BC) {
        Set<String> fields = new Set<String>{'Id'};
        // Dynamically fetch fields used in rules to ensure we don't get "SObject row was retrieved via SOQL without querying..."
        for(LeadScoringRule__mdt rule : new LeadScoringRuleSelector().getRules()) {
            if(String.isNotBlank(rule.Field__c)) {
                fields.add(rule.Field__c);
            }
        }
        
        String query = 'SELECT ' + String.join(new List<String>(fields), ',') + ' FROM Lead';
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext BC, List<Lead> scope) {
        // Calculate score in memory
        LeadScoring.calculateScore(scope);
        // Update to persist (this will fire triggers again, but that's acceptable for this scope)
        update scope;
    }

    public void finish(Database.BatchableContext BC) {
        // Optional: Log completion
    }
}
