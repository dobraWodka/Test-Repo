import { LightningElement, track } from "lwc";
import getUserData from "@salesforce/apex/RandomUserData.getUserData";

export default class RandomPerson extends LightningElement {
  @track userData;
  picture;
  name = "";
  email;
  phone;
  age;

  connectedCallback() {
    getUserData()
      .then((result) => {
        console.log(result);
        this.userData = JSON.parse(JSON.stringify(result.results[0]));
        console.log("email-->", this.userData.email);
        console.log("phone-->", this.userData.phone);
        console.log("picture --> ", this.userData.picture.large);
        console.log("name --> ", this.userData.name.first + " " + this.userData.name.last);
        // console.log("age--> ", this.userData.dob.age);
        this.name = this.userData.name.first + " " + this.userData.name.last;
        this.email = this.userData.email;
        this.phone = this.userData.phone;
        this.picture = this.userData.picture.large;
        this.age = this.userData.dob.age;
      })
      .catch((error) => {
        console.log(JSON.stringify(error));
      });
  }
}
