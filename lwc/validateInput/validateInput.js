import { LightningElement, track } from "lwc";
import { createRecord } from "lightning/uiRecordApi";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import haveDuplicate from "@salesforce/apex/AccountHelper.haveDuplicate";

export default class ValidateInput extends LightningElement {
  @track accName = "";
  accPhone;
  @track haveDuplicate;

  handleNameChange(event) {
    this.accName = event.target.value;
  }
  handlePhoneChange(event) {
    this.accPhone = event.target.value;
  }
  save() {
    console.log(this.accName);
    haveDuplicate(this.accName)
      .then((result) => {
        console.log(result);
      })
      .catch((error) => {
        console.log(error);
      });
    console.log(this.haveDuplicate);
    const fields = {
      Name: this.accName,
      Phone: this.accPhone
    };
    const objRecordInput = { apiName: "Account", fields };

    if (!this.haveDuplicate) {
      createRecord(objRecordInput)
        .then((response) => {
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Success",
              message: "Account Created Successfully" + response,
              variant: "success"
            })
          );
        })
        .catch((error) => {
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Error",
              message: error.message,
              variant: "error"
            })
          );
        });
    } else {
      this.dispatchEvent(
        new ShowToastEvent({
          title: "Error Kurwa!",
          message: "Account with this name already exists!",
          variant: "error"
        })
      );
    }
  }

  createAccount() {}
}
