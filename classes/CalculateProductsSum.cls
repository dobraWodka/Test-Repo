public with sharing class CalculateProductsSum implements Database.Batchable<SObject>, Database.Stateful {
  public String totalSum = 'Я далбайоб';
  public Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator(
      'SELECT Id, Name, Products_Amount_Sum__c, (SELECT Id, TotalPrice FROM OpportunityLineItems)' + 'FROM Opportunity'
    );
  }
  public void execute(Database.BatchableContext bc, List<Opportunity> scope) {
    System.debug('Number of Opps: ' + scope.size());
    for (Opportunity o : scope) {
      if (o.OpportunityLineItems.size() > 0) {
        o.Products_Amount_Sum__c = 0;
        System.debug('Nuber of products in Opp ' + scope.indexOf(o) + ': ' + o.OpportunityLineItems.size());

        for (OpportunityLineItem item : o.OpportunityLineItems) {
          o.Products_Amount_Sum__c += item.TotalPrice;
        }
        System.debug('Opp : ' + scope.indexOf(o) + 'is: ' + o.Products_Amount_Sum__c);
      }
    }
    update scope;
  }
  public void finish(Database.BatchableContext bc) {
    System.debug(totalSum);

    // Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    // mail.setHtmlBody('Total sum in all opportunities is ' + totalSum);
    // mail.setSubject('Batch job complete');
    // mail.setToAddresses(new List<String>{ UserInfo.getUserEmail() });
    // Messaging.sendEmail(new List<Messaging.Email>{ mail });
  }
}
