import getAccountList from "@salesforce/apex/getData.getAccountList";
import { LightningElement, wire } from "lwc";

export default class ApexHoursAssignment extends LightningElement {
  searchKey;
  accounts;
  error;
  noMatchesFound;
  noMatchesFoundMessage = "";
  searchStrings;
  options = [];
  @wire(getAccountList, { input: "$searchKey", options: "$options" })
  wiredData({ error, data }) {
    if (data) {
      if (data.length === 0) this.noMatchesFound = true;
      this.accounts = data;
      this.error = undefined;
    } else if (error) {
      this.error = error;
      this.accounts = undefined;
    }
  }

  handleSearch() {
    const inputCmp = this.template.querySelector("lightning-input");
    const value = inputCmp.value;
    this.options = [];
    this.searchStrings = this.template.querySelectorAll('[data-id="checkbox"]');
    this.searchStrings.forEach((item) => {
      this.options.push(item.checked);
    });
    console.log(this.options);
    if (value === "") {
      inputCmp.setCustomValidity("Enter data");
    } else {
      inputCmp.setCustomValidity("");
    }
    inputCmp.reportValidity();
    this.searchKey = value;
    this.noMatchesFoundMessage = `No matches found with keyword "${this.searchKey}"`;
    this.noMatchesFound = false;
  }
}
