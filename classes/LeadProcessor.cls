public with sharing class LeadProcessor implements Database.Batchable<SObject> {
  public Integer leadCount = 0;
  public Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator('select id, LeadSource from Lead');
  }
  public void execute(Database.BatchableContext bc, List<Lead> scope) {
    for (Lead l : scope) {
      l.LeadSource = 'DreamForce';
      leadCount++;
    }
  }
  public void finish(Database.BatchableContext bc) {
    System.debug('Records processed: ' + leadCount);
  }
}
