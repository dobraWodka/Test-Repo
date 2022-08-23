public with sharing class OpportunityHandler {
  public OpportunityHandler() {
  }

  @AuraEnabled(cacheable=true)
  public static List<Opportunity> getOpps() {
    return [
      SELECT
        Id,
        Name,
        Account.Name,
        StageName,
        CloseDate,
        Amount,
        (SELECT Id, Name, Product2.Name, TotalPrice, Quantity, ListPrice, UnitPrice FROM OpportunityLineItems)
      FROM Opportunity
      LIMIT 10
    ];
  }
}
