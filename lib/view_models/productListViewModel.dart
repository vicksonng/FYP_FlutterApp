import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:untitled/app/app.dart';
import 'package:untitled/app/constant.dart';
import 'package:untitled/models/product.dart';
//import 'package:untitled/view_models/productViewModel.dart';
import 'package:untitled/webServices.dart';
import 'package:http/http.dart' as http;

class ProductListViewModel extends ChangeNotifier {

  List<Product> products = List<Product>();

  Future<void> fetchProducts() async {
//    String urlPrefix = Constant.getUrlPrefix();
//    String urlSuffix = "/products/category/ALL";
//    String url = urlPrefix + urlSuffix;
    String url = Constant.getProductUrl;
    print(url);
    var response = await http.get(url);
    var result = jsonDecode(response.body);
//    print(result[0]);
//    print(Product.fromJson((result[0])).toString());

    List<dynamic> product_list_dynamic = result.map((i) => Product.fromJson(i)).toList();
    List<Product> product_list = new List<Product>();
    for(int i = 0; i < product_list_dynamic.length ; i ++){
      product_list.add(product_list_dynamic[i]);
    }
    this.products = product_list;
  }

  Future<List<Product>> getProductsType(String productType) async {
    await this.fetchProducts();
    if(productType == "ALL"){
      print(productType);
      return this.products;
    }else{
      print(productType);
      List<Product> productList = [];
      for(var i = 0 ; i<this.products.length ; i ++){
        if(this.products[i].productType == productType) {
          productList.add(this.products[i]);
        }
      }
      return productList;
    }
  }

  Product getSingleProduct(int productID) {
    for(var i= 0 ; i<this.products.length ; i ++) {
      if(this.products[i].id == productID){
        print("can find product");
        return this.products[i];
      }
    }
    return this.products[0];
  }

  List<Product> getProducts(List<int> productIdList){
    List<Product> productList = [];
    for(var i = 0 ; i < productIdList.length ; i++){
      for(var j = 0 ; j < this.products.length ; i++) {
        if(productIdList[i] == this.products[j].id){
          productList.add(this.products[j]);
          break;
        }
      }
    }
    return productList;
  }


//  Future<void> fetchProducts(String productType) async {
//    String urlPrefix = App.getUrlPrefix();
//    String urlSuffix = "/products/category/" + productType;
//    String url = urlPrefix + urlSuffix;
////    var url = 'http://localhost:1337/products/category/' + productType;
//////    var url = 'https://fypsailsjs.herokuapp.com/products/category/' + productType;
//    print(url);
//    var response = await http.get(url);
//    var result = jsonDecode(response.body);
////    print(result[0]);
////    print(Product.fromJson((result[0])).toString());
//
//    List<dynamic> product_list_dynamic = result.map((i) => Product.fromJson(i)).toList();
//    List<Product> product_list = new List<Product>();
//    for(int i = 0; i < product_list_dynamic.length ; i ++){
//      product_list.add(product_list_dynamic[i]);
//    }
//    this.products = product_list;
//  }

}