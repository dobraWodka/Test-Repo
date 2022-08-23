public with sharing class PipelineAmountCalculator implements Database.Batchable<SObject>, Database.Stateful {
  public List<Account> accsToProcess = new List<Account>();
  public static Integer processedRecords = 0;
  public PipelineAmountCalculator(List<Account> passedAccs) {
    accsToProcess = passedAccs;
  }
  public List<Account> start(Database.BatchableContext bc) {
    return accsToProcess;
  }
  public void execute(Database.BatchableContext bc, List<Account> scope) {
    for (Account a : scope) {
      for (Opportunity o : a.Opportunities) {
        a.Pipeline__c += o.Amount;
        processedRecords++;
      }
    }
  }
  public void finish(Database.BatchableContext bc) {
    System.debug(processedRecords);
    AsyncApexJob job = [
      SELECT id, Status, NumberOfErrors, JobItemsProcessed
      FROM AsyncApexJob
      WHERE id = :bc.getJobId()
    ];
    System.debug(job.JobItemsProcessed);
  }
}
