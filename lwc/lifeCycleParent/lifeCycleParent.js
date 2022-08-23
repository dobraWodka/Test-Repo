import { LightningElement, wire, api } from "lwc";
import getContactList from "@salesforce/apex/ContactController.getContactList";

export default class LifeCycleParent extends LightningElement {
  selectedContact = {};

  contacts;

  @wire(getContactList)
  getContacts(data, error) {
    console.log("data---> " + JSON.stringify(data));
    console.log("error---> " + JSON.stringify(error));

    if (data) {
      this.contacts = data;
    }
  }

  handleClick() {
    console.log("contacts--> " + JSON.stringify(this.contacts));
  }

  contactSelected(event) {
    const contactId = event.detail;
    console.log("event--> " + JSON.stringify(event));
    console.log("event.detail--> " + JSON.stringify(event.detail));
    this.selectedContact = this.contacts.data.find(
      (contact) => contact.Id === contactId
    );
  }

  get listIsNotEmpty() {
    return true;
    // return (
    //   this.contacts &&
    //   // Array.isArray(this.contacts.data) &&
    //   this.contacts.data.length
    // );
  }
}
