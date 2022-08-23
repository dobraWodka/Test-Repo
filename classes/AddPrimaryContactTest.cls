@isTest
public with sharing class AddPrimaryContactTest {
  @TestSetup
  static void makeData() {
    List<Account> toInsert = new List<Account>();
    for (Integer i = 0; i < 100; i++) {
      Account a = new Account(Name = 'Zalupa ' + i);
      if (i < 50) {
        a.BillingState = 'CA';
      } else {
        a.BillingState = 'NY';
      }
      toInsert.add(a);
    }
    insert toInsert;
    Contact c = new Contact();
    c.LastName = 'LisanAlgaib';
    insert c;
  }
  @isTest
  public static void test() {
    Contact c = [SELECT id, name FROM Contact][0];
    AddPrimaryContact adder = new AddPrimaryContact(c, 'CA');
    Test.startTest();
    System.enqueueJob(adder);
    Test.stopTest();
    List<Account> accs = [SELECT id, name, billingstate FROM Account];
    System.assertEquals(1, accs[0].Contacts.size(), 'Contacts size in not 1');
  }
}
