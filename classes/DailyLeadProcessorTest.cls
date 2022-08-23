@isTest
public with sharing class DailyLeadProcessorTest {
  public static String CRON_EXP = '0 30 13 12 8 ? 2022';
  @TestSetup
  static void makeData() {
    List<Lead> newLeads = new List<Lead>();
    for (Integer i = 0; i < 200; i++) {
      Lead l = new Lead();
      l.LastName = 'TestLead ' + i;
      l.Company = 'Duzy Kszak';
      l.Status = 'Open - Not Contacted';
      newLeads.add(l);
    }
    insert newLeads;
  }
  @isTest
  static void test() {
    // Map<Id, Lead> leadMap = new Map<Id, Lead>(newLeads);
    // List<Id> leadIds = new List<Id>(leadMap.keySet());
    Test.startTest();
    String jobId = System.schedule('DailyLeadProcessor', CRON_EXP, new DailyLeadProcessor());
    List<Lead> emptyLeads = [SELECT id, LeadSource FROM Lead WHERE LeadSource = 'Dreamforce'];
    System.assertEquals(0, emptyLeads.size(), 'Leads already have LeadSource');
    Test.stopTest();
    System.assertEquals(200, emptyLeads.size(), 'Only ' + emptyLeads.size() + ' leads have apropriate LeadSource');
  }
}
