class Constant {
  static bool testing = true;

  static String urlPrefixTesting = 'http://localhost:1337';
  static String urlPrefixProduction = 'https://fypsailsjs.herokuapp.com';

  static String loginUrl = url("user/loginMobile");
  static String getProductUrl = url("/products/category/ALL");
  static String recommendationsUbcfUrl = url("/products/getRecommendationsUBCF/");
  static String recommendationsJaccardUrl = url("/products/getRecommendationsJaccard/");
  static String createOrderUrl = url("/order/create");
  static String recommendationsTopViewUrl = url("/products/getTopView");
  static String recommendationsTopSalesUrl = url("/products/getTopSales");




  static String url(String suffix){
    return getUrlPrefix() +suffix;
  }

  static String getUrlPrefix () {
    if(testing){
      return urlPrefixTesting;
    } else {
      return urlPrefixProduction;
    }
  }
//  static String urlID(String suffix)

}