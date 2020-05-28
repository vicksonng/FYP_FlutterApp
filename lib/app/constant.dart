class Constant {
  static bool testing = true;

  static String urlPrefixTesting = 'http://localhost:1337';
  static String urlPrefixProduction = 'https://fypsailsjs.herokuapp.com';

  static String loginUrl = url("/user/loginMobile");
  static String getProductUrl = url("/products/category/ALL");
  static String recommendationsUbcfUrl = url("/products/getRecommendationsUBCF/");
  static String recommendationsJaccardUrl = url("/products/getRecommendationsJaccard/");
  static String createOrderUrl = url("/order/create");
  static String recommendationsTopViewUrl = url("/products/getTopView");
  static String recommendationsTopSalesUrl = url("/products/getTopSales");
  static String salesBuyXGetYUrl = url("/sales/buyXGetY");
  static String salesDiscountUrl = url("/sales/discount");
  static String salesSpecialPriceUrl = url("/sales/specialPrice");
  static String salesDiscountRateUrl = url("/sales/discountRate");
  static String userAddValueUrl = url("/user/addStoredValue");
  static String categoryListUrl = url("/category/list");
  static String getPromotionUrl = url("/promotion");
  static String registerUrl = url("/user/register");
  static String fetchUserUrl = url("/user/view/");
  static String fetchOrderUrl = url("/order/list/");
  static String recommendationsIbcfUrl = url("/products/getRecommedationsIBCF/");

  static String recommendationsMessageUBCF = "以下商品推薦是我們為你度身訂造的";
  static String recommendationsMessageTopSales =  "以下商品推薦都是我們最暢銷的商品";
  static String recommendationsMessageTopView =  "以下商品推薦都是我們最多人查看的商品";
  static String recommendationsMessageIBCF = "以下商品是根據你的購物紀錄來為你度身訂造的";




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

}