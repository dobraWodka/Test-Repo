import { LightningElement, api, track } from "lwc";

export default class OppProduct extends LightningElement {
  @api product;
  @track showDetails = false;
  selectProductHandler() {
    this.showDetails = this.switchBoolean(this.showDetails);
    console.log("Value is now " + this.showDetails);
  }

  switchBoolean(varToSwitch) {
    if (varToSwitch === true) return false;
    return true;
  }
}
