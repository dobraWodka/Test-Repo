public with sharing class GetData {
  @AuraEnabled(cacheable=true)
  public static List<Account> getAccountList(
    String input,
    List<Boolean> options
  ) {
    if (input == '') {
      return new List<Account>();
    }
    String keyword = '%' + input + '%';
    String queryOptions = '';
    List<String> searchStrings = new List<String>();
    searchStrings.add('Website != Null');
    searchStrings.add('Active__c = \'Yes\'');
    searchStrings.add('Id in (select AccountId from Contact)');

    String whereClause = makeWhereClause(options, searchStrings);
    String newInput = '%' + input + '%';
    String query =
      'SELECT Id, Name, Industry, Rating, Website, AnnualRevenue ' +
      'FROM Account WHERE ' +
      whereClause +
      '\'' +
      newInput +
      '\'';
    System.debug(query);
    return Database.query(query);
  }

  public static String makeWhereClause(
    List<Boolean> options,
    List<String> searchStrings
  ) {
    String result = '';
    for (String currentSearchString : searchStrings) {
      if (
        result == '' &&
        options[searchStrings.indexOf(currentSearchString)] == true
      ) {
        result += currentSearchString;
      } else if (options[searchStrings.indexOf(currentSearchString)] == true) {
        result += ' AND ' + currentSearchString;
      }
    }
    if (result == '') {
      result += 'Name LIKE ';
    } else {
      result += ' AND Name LIKE ';
    }

    return result;
  }
}
