@isTest
public with sharing class AccountProcessorTest {
  @isTest
  public static void testContactsCount() {
    List<Account> accs = new List<Account>();
    List<Contact> conts = new List<Contact>();
    List<Id> accountIds = new List<Id>();
    for (Integer i = 0; i < 5; i++) {
      Account a = new Account(Name = 'Zalupa' + i);
      accs.add(a);
    }
    insert accs;
    for (Account acc : accs) {
      Contact c = new Contact();
      c.AccountId = acc.Id;
      c.LastName = 'Zalupa Contact' + accs.indexOf(acc);
      conts.add(c);
      accountIds.add(acc.Id);
    }
    insert conts;

    Test.startTest();
    AccountProcessor.countContacts(accountIds);
    Test.stopTest();
    for (Account acc : accs) {
      System.assert(acc.Number_Of_Contacts__c == 5);
    }
  }
}
