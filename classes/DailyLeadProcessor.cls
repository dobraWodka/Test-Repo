public with sharing class DailyLeadProcessor implements Schedulable {
  public void execute(SchedulableContext ctx) {
    List<Lead> leads = [SELECT id, LeadSource FROM Lead WHERE LeadSource = NULL];
    for (Lead l : leads) {
      l.LeadSource = 'Dreamforce';
    }
    update leads;
  }
}
