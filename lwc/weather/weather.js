import { LightningElement } from "lwc";
import getWeather from "@salesforce/apex/Weather.getWeather";

export default class Weather extends LightningElement {
  showWeather;
  noCityFound;
  nothingFoundImg;

  weatherObj;
  localDateTime;
  localDate;
  localTime;
  locationName;
  temp;
  condition;
  wind;
  pressure;
  humidity;
  img;
  cardTitle;

  obtainWeather() {
    const city = this.template.querySelector("lightning-input").value;
    console.log(city);
    getWeather({ city: city })
      .then((result) => {
        console.log("Result --> ", result);
        this.weatherObj = JSON.parse(JSON.stringify(result));
        this.locationName = this.weatherObj.location.name;
        this.temp = this.weatherObj.current.temp_c;
        this.condition = this.weatherObj.current.condition.text;
        this.wind = this.weatherObj.current.wind_kph;
        this.pressure = this.weatherObj.current.pressure_mb;
        this.humidity = this.weatherObj.current.humidity;
        this.img = this.weatherObj.current.condition.icon;
        this.localDateTime = this.weatherObj.location.localtime;
        this.cardTitle = `Current weather in ${this.locationName}`;
        this.localDate = this.localDateTime.substring(0, 10);
        this.localTime = this.localDateTime.substring(11);
        this.showWeather = true;
      })
      .catch((error) => {
        this.showWeather = false;
        console.log("Error -->", error.body.message);
        this.noCityFound = `There is no city with the name of "${city}"`;
        this.nothingFoundImg = "https://cdn-icons-png.flaticon.com/512/2748/2748558.png";
      });
  }
}
