import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:untitled/app/constant.dart';
import 'package:untitled/models/promotion.dart';
import 'package:http/http.dart' as http;

class PromotionPageViewModel extends ChangeNotifier {
  List<Promotion> promotion = [];


  Future<List<Promotion>> fetchPromotion() async {
    String urlPrefix = Constant.getUrlPrefix();
    String urlSuffix = "/promotion";
    String url = urlPrefix + urlSuffix;

    List<Promotion> newPromotionList =[];
    print(url);
    var response = await http.get(url);
    var result = jsonDecode(response.body);
    print(result);
    print(result.runtimeType);

    List<dynamic> promotionListDynamic = result.map((i) => Promotion.fromJson(i)).toList();
    List<Promotion> promotionList = new List<Promotion>();
    for(int i = 0 ; i < promotionListDynamic.length ; i ++) {
      promotionList.add(promotionListDynamic[i]);
    }
    this.promotion = promotionList;
    print("....");
    print(this.promotion);
//    print(promotionList[0].toString());
//    List<dynamic> product_list_dynamic = result.involvedProducts.map((i) =>
//        Product.fromJson(i)).toList();
//    print(product_list_dynamic);
//    List<Product> product_list = new List<Product>();
//    for(int i = 0; i < product_list_dynamic.length ; i ++){
//      product_list.add(product_list_dynamic[i]);
//    }
  }
  Future<List<Promotion>> getPromotion() async {
    await this.fetchPromotion();
    return this.promotion;
  }


}