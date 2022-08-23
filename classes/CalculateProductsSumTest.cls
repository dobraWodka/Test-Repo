@isTest
public with sharing class CalculateProductsSumTest {
  @TestSetup
  static void makeData() {
    List<Opportunity> opps = new List<Opportunity>();
    List<OpportunityLineItem> items = new List<OpportunityLineItem>();
    Id pricebookId = Test.getStandardPricebookId();
    Product2 prod = new Product2(Name = 'Product X', ProductCode = 'Pro-X', isActive = true);
    insert prod;

    PricebookEntry pbEntry = new PricebookEntry(
      Pricebook2Id = pricebookId,
      Product2Id = prod.Id,
      UnitPrice = 100.00,
      IsActive = true
    );
    insert pbEntry;
    for (Integer i = 0; i < 10; i++) {
      Opportunity opp = new Opportunity();
      opp.Name = 'TestOpp' + i;
      opp.StageName = 'Prospecting';
      opp.CloseDate = Date.today().addDays(10);
      opps.add(opp);
    }
    insert opps;
    for (Opportunity o : opps) {
      for (Integer i = 0; i < 50; i++) {
        OpportunityLineItem item = new OpportunityLineItem();
        item.OpportunityId = o.Id;
        item.Quantity = 5;
        item.PricebookEntryId = pbEntry.Id;
        item.TotalPrice = item.Quantity * pbEntry.UnitPrice;
        items.add(item);
      }
    }
    insert items;
  }

  @isTest
  public static void test() {
    Test.startTest();
    DailyScheduler sum = new DailyScheduler();
    String cron = '0 0 0 ? * MON,TUE,WED,THU,FRI *';
    System.schedule('Jedziemy z tym gownem ziomus', cron, sum);
    Test.stopTest();
  }
}
