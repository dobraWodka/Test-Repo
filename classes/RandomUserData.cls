public with sharing class RandomUserData {
  @AuraEnabled
  public static Results getUserData() {
    try {
      String endpoint = 'https://randomuser.me/api/';
      Http http = new Http();
      HttpRequest request = new HttpRequest();
      request.setEndpoint(endpoint);
      request.setMethod('GET');
      System.debug(request);
      HttpResponse response = http.send(request);
      System.debug('Response --> ' + response.getBody());
      Results getUser = new Results();
      getUser = (Results) JSON.deserialize(response.getBody(), Results.class);
      return getUser;
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }
  public class Results {
    @AuraEnabled
    public List<ResultsWrapper> results;
  }
  public class Picture {
    @AuraEnabled
    public String large;
  }
  public class Dob {
    @AuraEnabled
    public String age;
  }
  public class Name {
    @AuraEnabled
    public String first;
    @AuraEnabled
    public String last;
  }
  public class ResultsWrapper {
    @AuraEnabled
    public String gender;
    @AuraEnabled
    public String email;
    @AuraEnabled
    public Picture picture;
    @AuraEnabled
    public Name name;
    @AuraEnabled
    public String phone;
    @AuraEnabled
    public Dob dob;
  }
}
