@isTest
public with sharing class PipelineAmountCalculatorSchedulerTest {
  @isTest
  static void test1() {
    Test.startTest();
    String cron = '0 0 21 1/1 * ? *';
    Id jobId = System.schedule('Calculate Pipeline', cron, new PipelineAmountCalculatorScheduler());
    CronTrigger ct = [SELECT id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
    System.assertEquals(cron, ct.CronExpression);
    System.assertEquals(0, ct.TimesTriggered);
    Test.stopTest();
  }
}
