

import 'package:provider/provider.dart';
import 'package:untitled/app/app.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/app/constant.dart';
import 'package:untitled/models/product.dart';
import 'package:untitled/view_models/productListViewModel.dart';

class Promotion {
  int id;
  String promotionName;
  String promotionDesc;
  String promotionImgURL;
  String promotionStartDate;
  String promotionEndDate;
  List<int> relatedProducts;
//  String involvedProducts;
//  List<dynamic> involvedProducts;
  Promotion({this.id, this.promotionName, this.promotionDesc, this.promotionImgURL, this.promotionStartDate, this.promotionEndDate, this.relatedProducts});
//  Promotion({this.id, this.promotionName, this.promotionDesc, this.promotionImgURL, this.promotionStartDate, this.promotionEndDate, this.involvedProducts});

//  Promotion (this.id, this.promotionName, this.promotionDesc, this.promotionImgURL, this.promotionStartDate, this.promotionEndDate, this.involvedProducts);




  factory Promotion.fromJson(Map<dynamic, dynamic> json) {
    var relatedProducts = json['relatedProducts'];
    print("Print RelatedProducts");
    print(relatedProducts);
    print("Print Type");
    print(relatedProducts.runtimeType);
    List<int> productIdList = [];
//    List<Product> productList = [];
    for(var i = 0 ; i < relatedProducts.length ;i ++){
      productIdList.add(relatedProducts[i]["id"]);
    }
    print("Casted");
    print(productIdList);
//    if(productList.length > 0){
//      print(productList[0]);
//
//
//    }

//    var x = json['involvedProducts'];
//    for(var i = 0 ; i < x.length ; i ++){
//      print(x[i]);
//    }
//
//    print(x.runtimeType);
//
//    String a = "1,2,3";
//    List<String> ab = a.split(",");
//    List<int> productIdList = [];
//    for(var i = 0 ; i < ab.length ; i++){
//      productIdList.add(int.parse(ab[i]));
//    }
//    print(productIdList);
//    Provider.of<ProductListViewModel>(context, listen: false).;
//
//
//    for(var i = 0 ; i < ab.length ; i ++){
//      ab[i]
//    }
//
//    print("HIHIHI");
////    List<dynamic> involvedProduct = json['involvedProducts'].map((i) => Product.fromJson(i)).toList();
//    print(involvedProduct);
//    var involvedProduct = json['involvedProducts'].map((i) => Product.fromJson(i)).toList();
//    print(involvedProduct);
    return new Promotion(
        id: json['id'],
        promotionName: json['promotionName'],
        promotionDesc: json['promotionDesc'],
        promotionImgURL: json['promotionImgURL'],
        promotionStartDate: json['promotionStartDate'],
        promotionEndDate: json['promotionEndDate'],
        relatedProducts: productIdList,
//        involvedProducts:json['involvedProducts']
    );
  }


//  Future<List<Promotion>> getPromotion() async {
//    String urlPrefix = Constant.getUrlPrefix();
//    String urlSuffix = "/promotion";
//    String url = urlPrefix+urlSuffix;
//    print(url);
//    var response = await http.get(url);
//
//////    print(jsonDecode(response.body));
////    var result = jsonDecode(response.body);
//////    print(result[0]);
//
//  }


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