public with sharing class Weather {
  public Weather() {
  }
  @AuraEnabled
  public static Weather getWeather(String city) {
    String url = 'https://weatherapi-com.p.rapidapi.com/current.json?q=' + city;
    HttpRequest request = new HttpRequest();
    request.setMethod('GET');
    request.setEndpoint(url);
    request.setHeader('X-RapidAPI-Key', '0d6456940fmsh6c8b41400209dd4p15d228jsncfaecd97b03e');
    request.setHeader('X-RapidAPI-Host', 'weatherapi-com.p.rapidapi.com');
    Http http = new Http();
    HttpResponse response = http.send(request);
    Weather thisWeather = new Weather();
    thisWeather = Weather.parse(response.getBody());
    System.debug(thisWeather.Location.name);

    return thisWeather;
  }
  public class Condition {
    @AuraEnabled
    public String text;
    @AuraEnabled
    public String icon;
    @AuraEnabled
    public Integer code;
  }

  @AuraEnabled
  public Location location;
  @AuraEnabled
  public Current current;

  public class Current {
    @AuraEnabled
    public String last_updated;
    @AuraEnabled
    public Double temp_c;
    @AuraEnabled
    public Integer is_day;
    @AuraEnabled
    public Condition condition;
    @AuraEnabled
    public Double wind_kph;
    @AuraEnabled
    public Integer wind_degree;
    @AuraEnabled
    public String wind_dir;
    @AuraEnabled
    public Double pressure_mb;
    @AuraEnabled
    public Double precip_mm;
    @AuraEnabled
    public Integer humidity;
    @AuraEnabled
    public Integer cloud;
    @AuraEnabled
    public Double feelslike_c;
    @AuraEnabled
    public Double vis_km;
    @AuraEnabled
    public Double uv;
    @AuraEnabled
    public Double gust_kph;
  }

  public class Location {
    @AuraEnabled
    public String name;
    @AuraEnabled
    public String region;
    @AuraEnabled
    public String country;
    @AuraEnabled
    public Double lat;
    @AuraEnabled
    public Double lon;
    @AuraEnabled
    public String tz_id;
    @AuraEnabled
    public String localtime;
  }

  public static Weather parse(String json) {
    return (Weather) System.JSON.deserialize(json, Weather.class);
  }
}
