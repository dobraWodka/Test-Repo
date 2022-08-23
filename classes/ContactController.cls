public with sharing class ContactController {
  public ContactController() {
  }

  @AuraEnabled(cacheable=true)
  public static List<Contact> getContactList() {
    return [SELECT Id, Name, Email, Phone, Title FROM Contact LIMIT 20];
  }
  @AuraEnabled
  public static List<Account> getAccountDetails() {
    try {
      return [SELECT Id, Name FROM Account LIMIT 2];
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }
}
