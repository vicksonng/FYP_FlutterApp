import 'package:untitled/app/app.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/app/constant.dart';

class Promotion {
  int id;
  String promotionName;
  String promotionDesc;
  String promotionImgURL;
  String promotionStartDate;
  String promotionEndDate;
  Promotion({this.id, this.promotionName, this.promotionDesc, this.promotionImgURL, this.promotionStartDate, this.promotionEndDate});


  factory Promotion.fromJson(Map<String, dynamic> json) {
    return new Promotion(
        id: json['id'],
        promotionName: json['promotionName'],
        promotionDesc: json['promotionDesc'],
        promotionImgURL: json['promotionImgURL'],
        promotionStartDate: json['promotionStartDate'],
        promotionEndDate: json['promotionEndDate'],
    );
  }
  Future<List<Promotion>> getPromotion() async {
    String urlPrefix = Constant.getUrlPrefix();
    String urlSuffix = "/promotion";
    String url = urlPrefix+urlSuffix;
    print(url);
    var response = await http.get(url);
////    print(jsonDecode(response.body));
//    var result = jsonDecode(response.body);
////    print(result[0]);

  }
//    var response = await http.get(url);
////    print(jsonDecode(response.body));
//    var result = jsonDecode(response.body);
////    print(result[0]);
//
////    print(Product.fromJson((result[0])).toString());
//
//    List<dynamic> product_list_dynamic = result.map((i) => Product.fromJson(i)).toList();
//    List<Product> product_list = new List<Product>();
//    for(int i = 0; i < product_list_dynamic.length ; i ++){
//      product_list.add(product_list_dynamic[i]);
//    }
//
////      ProductList productList = new ProductList(products: product_list);
//    return product_list;
//  }

}