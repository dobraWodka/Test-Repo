@isTest
public with sharing class LeadProcessorTest {
  @TestSetup
  static void makeData() {
    List<Lead> leads = new List<Lead>();
    for (Integer i = 0; i < 200; i++) {
      Lead l = new Lead();
      l.LastName = 'TestLead ' + i;
      l.Company = 'Kszak';
      l.Status = 'Open - Not Contacted';
      leads.add(l);
    }
    insert leads;
  }
  @isTest
  static void testLeads() {
    Test.startTest();
    LeadProcessor btch = new LeadProcessor();
    Id btchId = Database.executeBatch(btch, 200);
    Test.stopTest();
    System.assertEquals(200, [SELECT COUNT() FROM Lead WHERE LeadSource = 'DreamForce']);
  }
}
