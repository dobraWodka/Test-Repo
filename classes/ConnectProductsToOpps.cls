public with sharing class ConnectProductsToOpps {
  public ConnectProductsToOpps() {
  }
  public static void connect() {
    List<Opportunity> opps = [
      SELECT Id, Name, Account.Name, StageName, CloseDate, Amount
      FROM Opportunity
      ORDER BY Name ASC
      LIMIT 10
    ];
    Pricebook2 standardBook = [SELECT Id FROM Pricebook2 WHERE IsStandard = TRUE][0];
    PricebookEntry entry = [SELECT Id, UnitPrice FROM PricebookEntry WHERE Pricebook2.Id = :standardBook.Id][0];
    for (Opportunity opp : opps) {
      opp.Pricebook2Id = standardBook.Id;
      List<OpportunityLineItem> items = new List<OpportunityLineItem>();
      update opp;
      for (Integer i = 0; i < 5; i++) {
        OpportunityLineItem item = new OpportunityLineItem();
        item.PricebookEntryId = entry.Id;
        item.OpportunityId = opp.Id;
        item.UnitPrice = entry.UnitPrice;
        item.Quantity = 3;
        items.add(item);
        System.debug(item);
        System.debug(i);
      }
      insert items;
    }
  }
}
