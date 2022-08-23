@isTest
public with sharing class PipelineAmountCalculatorTest {
  @TestSetup
  static void makeData() {
    List<Account> accs = new List<Account>();
    List<Opportunity> opps = new List<Opportunity>();

    for (Integer i = 0; i < 10; i++) {
      Account a = new Account(Name = 'Phipips');
      accs.add(a);
    }
    insert accs;
    for (Account a : accs) {
      for (Integer i = 0; i < 5; i++) {
        Opportunity o = new Opportunity();
        o.AccountId = a.Id;
        o.Amount = i * 100;
        o.StageName = 'Prospecting';
        o.Name = a.Name + ' Opp ' + i;
        o.CloseDate = Date.today().addDays(10);
        opps.add(o);
      }
    }
    insert opps;
  }
  @isTest
  static void test() {
    List<Account> oldAccs = [SELECT id, Pipeline__c FROM Account];

    Test.startTest();
    PipelineAmountCalculator btch = new PipelineAmountCalculator(oldAccs);
    Id btchId = Database.executeBatch(btch);
    if (oldAccs.size() != 0) {
      System.debug(oldAccs[0].Pipeline__c);
    } else {
      System.debug('List oldAccs is empty!');
    }
    Test.stopTest();
    List<Account> newAccs = [SELECT id, Pipeline__c FROM Account];
    if (oldAccs.size() != 0) {
      System.debug(oldAccs[0].Pipeline__c);
    } else {
      System.debug('List newAccs is empty!');
    }
  }
}
