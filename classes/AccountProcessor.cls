public with sharing class AccountProcessor {
  @future
  public static void countContacts(List<Id> accountIds) {
    List<Account> accsToUpdate = [
      SELECT id, Number_Of_Contacts__c, (SELECT id FROM Contacts)
      FROM Account
      WHERE Id IN :accountIds
    ];
    for (Account thisAcc : accsToUpdate) {
      thisAcc.Number_Of_Contacts__c = thisAcc.Contacts.size();
      System.debug('Contacts.size ' + thisAcc.Contacts.size());
      System.debug('Number Of Contacts ' + thisAcc.Number_Of_Contacts__c);
    }
    update accsToUpdate;
  }

  public static Boolean haveDuplicate(String accName) {
    List<Account> accs = [SELECT id, Name FROM Account WHERE Name = :accName];
    System.debug(accs);
    return accs.size() != 0;
  }
}
