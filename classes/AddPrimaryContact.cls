public with sharing class AddPrimaryContact implements Queueable {
  public Contact contact;
  public String state;
  public AddPrimaryContact(Contact cont, String stateName) {
    this.contact = cont;
    this.state = stateName;
  }
  public void execute(QueueableContext cx) {
    List<Account> accs = [SELECT id, name FROM Account WHERE BillingState = :this.state LIMIT 200];
    List<Contact> contsToInsert = new List<Contact>();
    System.debug('Accs size: ' + accs.size());
    for (Account a : accs) {
      Contact newCont = this.contact.clone(false, false, false);
      newCont.AccountId = a.Id;
      contsToInsert.add(newCont);
    }
    insert contsToInsert;
  }
}
