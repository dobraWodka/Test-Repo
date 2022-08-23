public with sharing class DailyScheduler implements Schedulable {
  public void execute(SchedulableContext ctx) {
    CalculateProductsSum sum = new CalculateProductsSum();
    String jobId = Database.executeBatch(sum);
  }
}
