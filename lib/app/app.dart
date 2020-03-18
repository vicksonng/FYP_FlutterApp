class App {
  static bool testing = true;
  static String urlPrefixTesting = 'http://localhost:1337';
  static String urlPrefixProduction = 'https://fypsailsjs.herokuapp.com';

  static String getUrlPrefix () {
    if(testing){
      return urlPrefixTesting;
    } else {
      return urlPrefixProduction;
    }
  }



}