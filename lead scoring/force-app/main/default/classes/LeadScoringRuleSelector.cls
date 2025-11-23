public virtual inherited sharing class LeadScoringRuleSelector {
    public virtual List<LeadScoringRule__mdt> getRules() {
        return [
            SELECT Field__c, Value__c, Score__c, Operation__c 
            FROM LeadScoringRule__mdt
        ];
    }
}
