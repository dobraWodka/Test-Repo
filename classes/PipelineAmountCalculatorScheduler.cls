public with sharing class PipelineAmountCalculatorScheduler implements Schedulable {
  public void execute(SchedulableContext ctx) {
    Date today = Date.today();
    List<Account> accsToUpdate = [SELECT id, CreatedDate FROM Account WHERE CreatedDate < :today];
    PipelineAmountCalculator db = new PipelineAmountCalculator(accsToUpdate);
    Id dbId = Database.executeBatch(db);
  }
}
