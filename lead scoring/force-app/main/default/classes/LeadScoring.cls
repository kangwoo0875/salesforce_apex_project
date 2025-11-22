public with sharing class LeadScoring {

    public LeadScoring() {
    }

    public static Integer calculateScore(String industry, Integer employees) {
        Integer score = 0;
        if(industry == 'Technology') score += 30;
        if(employees > 100) score += 20;
        return score;
    }
}
