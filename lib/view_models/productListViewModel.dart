import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:untitled/app/app.dart';
import 'package:untitled/app/constant.dart';
import 'package:untitled/models/product.dart';
import 'package:untitled/models/salesBuyXGetY.dart';
import 'package:untitled/models/salesDiscount.dart';
import 'package:untitled/models/salesDiscountRate.dart';
import 'package:untitled/models/salesSpecialPrice.dart';
//import 'package:untitled/view_models/productViewModel.dart';
import 'package:untitled/webServices.dart';
import 'package:http/http.dart' as http;

class ProductListViewModel extends ChangeNotifier {

  List<Product> products = List<Product>();

  Future<void> fetchProducts() async {
    String url = Constant.getProductUrl;
    print(url);
    var response = await http.get(url);
    var result = jsonDecode(response.body);

    List<dynamic> product_list_dynamic = result.map((i) => Product.fromJson(i)).toList();
    List<Product> product_list = new List<Product>();
    for(int i = 0; i < product_list_dynamic.length ; i ++){
      product_list.add(product_list_dynamic[i]);
    }

    this.products = product_list;

    await this.fetchSalesBuyXGetY();
    await this.fetchSalesDiscount();
    await this.fetchSalesSpecialPrice();
    await this.fetchSalesDiscountRate();
    notifyListeners();

  }

  fetchSalesBuyXGetY() async {
    String url = Constant.salesBuyXGetYUrl;
    var response = await http.get(url);
    var result = jsonDecode(response.body);
    print(response.body);
    List<dynamic> sales_list_dynamic = result.map((i) => SalesBuyXGetY.fromJson(i)).toList();
    List<SalesBuyXGetY> sales_list = new List<SalesBuyXGetY>();
    for(int i = 0; i < sales_list_dynamic.length ; i ++){
      sales_list.add(sales_list_dynamic[i]);
      print("....");
      print(sales_list[0].productID);
    }
    for(int i = 0 ; i < sales_list.length ; i++){
      for(int j = 0 ; j < this.products.length ; i ++){
        if(sales_list[i].productID == this.products[j].id){
          var isExist = false;
          for(int k = 0 ; k < this.products[j].salesBuyXGetYList.length ; k++){
            if(this.products[j].salesBuyXGetYList[k].id == sales_list[i].id){
              isExist = true;
              break;
            }
          }
          if(!isExist){
            this.products[j].salesBuyXGetYList.add(sales_list[i]);
            break;
          }
        }
      }
    }
    notifyListeners();
  }

  fetchSalesDiscount() async {
    String url = Constant.salesDiscountUrl;
    var response = await http.get(url);
    var result = jsonDecode(response.body);
    List<dynamic> sales_list_dynamic = result.map((i) => SalesDiscount.fromJson(i)).toList();
    List<SalesDiscount> sales_list = new List<SalesDiscount>();
    for(int i = 0; i < sales_list_dynamic.length ; i ++){
      sales_list.add(sales_list_dynamic[i]);
    }
    for(int i = 0 ; i < sales_list.length ; i++){
      for(int j = 0 ; j < this.products.length ; i ++){
        if(sales_list[i].productID == this.products[j].id){
          var isExist = false;
          for(int k = 0 ; k < this.products[j].salesSpecialPriceList.length ; k++){
            if(this.products[j].salesSpecialPriceList[k].id == sales_list[i].id){
              isExist = true;
              break;
            }
          }
          if(!isExist){
            this.products[j].salesDiscountList.add(sales_list[i]);
            break;
          }
        }
      }
    }
    notifyListeners();
  }
  fetchSalesDiscountRate() async {
    String url = Constant.salesDiscountRateUrl;
    var response = await http.get(url);
    var result = jsonDecode(response.body);
    List<dynamic> sales_list_dynamic = result.map((i) => SalesDiscountRate.fromJson(i)).toList();
    List<SalesDiscountRate> sales_list = new List<SalesDiscountRate>();
    for(int i = 0; i < sales_list_dynamic.length ; i ++){
      sales_list.add(sales_list_dynamic[i]);
    }
    for(int i = 0 ; i < sales_list.length ; i++){
      for(int j = 0 ; j < this.products.length ; i ++){
        if(sales_list[i].productID == this.products[j].id){
          var isExist = false;
          for(int k = 0 ; k < this.products[j].salesDiscountRateList.length ; k++){
            if(this.products[j].salesDiscountRateList[k].id == sales_list[i].id){
              isExist = true;
              break;
            }
          }
          if(!isExist){
            print(">>>>>> " + sales_list[i].restrictedOne.toString());
            this.products[j].salesDiscountRateList.add(sales_list[i]);
            break;
          }

        }
      }
    }
    notifyListeners();
  }
  fetchSalesSpecialPrice() async {
    String url = Constant.salesSpecialPriceUrl;
    var response = await http.get(url);
    var result = jsonDecode(response.body);
    List<dynamic> sales_list_dynamic = result.map((i) => SalesSpecialPrice.fromJson(i)).toList();
    List<SalesSpecialPrice> sales_list = new List<SalesSpecialPrice>();
    for(int i = 0; i < sales_list_dynamic.length ; i ++){
      sales_list.add(sales_list_dynamic[i]);
    }
    for(int i = 0 ; i < sales_list.length ; i++){
      for(int j = 0 ; j < this.products.length ; i ++){
        if(sales_list[i].productID == this.products[j].id){
          var isExist = false;
          for(int k = 0 ; k < this.products[j].salesSpecialPriceList.length ; k++){
            if(this.products[j].salesSpecialPriceList[k].id == sales_list[i].id){
              isExist = true;
              break;
            }
          }
          if(!isExist){
            this.products[j].salesSpecialPriceList.add(sales_list[i]);
            break;
          }

        }
      }
    }
    notifyListeners();
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