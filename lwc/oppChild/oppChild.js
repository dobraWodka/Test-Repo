import { LightningElement, api } from "lwc";
export default class OppChild extends LightningElement {
  @api opportunity;

  selectedOppHandler(event) {
    event.preventDefault();
    const selectedEvent = new CustomEvent("selectedopp", {
      detail: {
        Id: this.opportunity.Id,
        Products: this.opportunity.OpportunityLineItems
      }
    });
    this.dispatchEvent(selectedEvent);
  }
}
