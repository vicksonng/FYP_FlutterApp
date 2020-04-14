import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:untitled/app/app.dart';
import 'package:untitled/app/constant.dart';
import 'package:untitled/models/product.dart';
import 'package:untitled/models/promotion.dart';
import 'package:untitled/models/salesBuyXGetY.dart';
import 'package:untitled/models/salesDiscount.dart';
import 'package:untitled/models/salesDiscountRate.dart';
import 'package:untitled/models/salesSpecialPrice.dart';
//import 'package:untitled/view_models/productViewModel.dart';
import 'package:untitled/webServices.dart';
import 'package:http/http.dart' as http;


class PromotionViewModel extends ChangeNotifier{
  Promotion promotion;

  Future<List<Promotion>> fetchPromotion() async {
    String urlPrefix = Constant.getUrlPrefix();
    String urlSuffix = "/promotion";
    String url = urlPrefix + urlSuffix;
    print(url);
    var response = await http.get(url);
    var result = jsonDecode(response.body);
    print(result);
    print(result.runtimeType);
    for(int i  = 0 ; i < result.length ; i ++) {
//      this.promotion = new Promotion(result[i]);
    }


//    List<dynamic> promotionList = result.map((i) => Promotion.fromJson(i)).toList();
//    print(promotionList[0].toString());
//    List<dynamic> product_list_dynamic = result.involvedProducts.map((i) =>
//        Product.fromJson(i)).toList();
//    print(product_list_dynamic);
//    List<Product> product_list = new List<Product>();
//    for(int i = 0; i < product_list_dynamic.length ; i ++){
//      product_list.add(product_list_dynamic[i]);
//    }
  }




  }