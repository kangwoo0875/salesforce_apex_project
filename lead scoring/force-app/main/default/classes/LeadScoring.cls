public with sharing class LeadScoring {

    @TestVisible private static LeadScoringRuleSelector ruleSelector = new LeadScoringRuleSelector();

    public static void calculateScore(List<Lead> leads) {
        if (leads == null || leads.isEmpty()) return;

        List<LeadScoringRule__mdt> rules = ruleSelector.getRules();

        for (Lead l : leads) {
            Decimal score = 0;
            for (LeadScoringRule__mdt rule : rules) {
                if (matchesRule(l, rule)) {
                    score += rule.Score__c;
                }
            }
            l.Score__c = score;
        }
    }

    private static Boolean matchesRule(Lead l, LeadScoringRule__mdt rule) {
        if (String.isBlank(rule.Field__c)) return false;
        
        Object fieldValue = l.get(rule.Field__c);
        String ruleValue = rule.Value__c;
        
        if (fieldValue == null) return false;
        String fieldStr = String.valueOf(fieldValue);

        switch on rule.Operation__c {
            when 'Equals' {
                return fieldStr.equalsIgnoreCase(ruleValue);
            }
            when 'NotEquals' {
                return !fieldStr.equalsIgnoreCase(ruleValue);
            }
            when 'Contains' {
                return fieldStr.containsIgnoreCase(ruleValue);
            }
            when else {
                return false;
            }
        }
    }
}
