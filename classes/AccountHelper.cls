public with sharing class AccountHelper {
  @AuraEnabled(cacheable=true)
  public static Boolean haveDuplicate(String accName) {
    List<Account> accs = [SELECT id, Name FROM Account WHERE Name = :accName];
    return accs.size() != 0;
  }
}
