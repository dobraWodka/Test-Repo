import { LightningElement, wire } from "lwc";
import getOpps from "@salesforce/apex/OpportunityHandler.getOpps";

export default class OppParent extends LightningElement {
  selectedOpp;
  opps;
  oppToProductsMap = new Map();
  relatedProducts = [];
  @wire(getOpps)
  getOppotunities(data, error) {
    console.log("error -->" + JSON.stringify(error));
    console.log("data -->" + JSON.stringify(data.data));
    if (data) {
      this.opps = data;
    }
  }

  renderedCallback() {
    // console.log("Render Started");
  }
  oppSelected(event) {
    const opportunityId = event.detail.Id;
    console.log(this.selectedOpp);
    this.selectedOpp = this.opps.data.find((opportunity) => opportunity.Id === opportunityId);
    this.relatedProducts = this.selectedOpp.OpportunityLineItems;
  }
  get listNotEmpty() {
    return true;
  }
}
