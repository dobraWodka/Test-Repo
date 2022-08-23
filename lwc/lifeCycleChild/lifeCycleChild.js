import { LightningElement, api, wire } from "lwc";
import getContactList from "@salesforce/apex/ContactController.getContactList";

export default class LifeCycleChild extends LightningElement {
  // @wire(getContactList) contacts;
  @api contact;
  @api contactName = "Agart";

  // renderedCallback() {
  //   console.log("contacts--> " + JSON.stringify(this.contacts));
  // }

  clickHandler() {
    // console.log(this.contacts);
  }
  selectHandler(event) {
    event.preventDefault();
    const selectedEvent = new CustomEvent("selected", {
      detail: this.contact.Id
    });
    this.dispatchEvent(selectedEvent);
  }
}
