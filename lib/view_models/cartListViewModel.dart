import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:untitled/app/constant.dart';
import 'package:untitled/models/cartItem.dart';
import 'package:http/http.dart' as http;

class CartListViewModel extends ChangeNotifier {

  List<CartItem> cartList = [];

  double total = 0;

  void addItem(CartItem cartItem) {
    //Check duplicated product
    int index = isItemExist(cartItem.product.id);
    if(index != -1){
      cartList[index].qty += cartItem.qty;
    } else {
      cartList.add(cartItem);
    }
    calTotal();
    notifyListeners();
  }

  int isItemExist(int id) {
    for(int i = 0 ; i < cartList.length ; i ++) {
      if(id == cartList[i].product.id) {
        return i;
      }
    }
    return -1;
  }

  void removeItem(int productID) {
    for(int  i = 0 ; i < this.cartList.length ; i++) {
      if(productID == this.cartList[i].product.id) {
        print("Can find delete item");
        this.cartList.removeAt(i);
        print(this.cartList.length);
        break;
      }
    }
    calTotal();
    notifyListeners();
  }

  void setQty(int index, int qty) {
    cartList[index].qty = qty;
    calTotal();
    notifyListeners();
  }

  void clearCart() {
    this.cartList = [];
    this.total = 0;
    notifyListeners();
  }

  void calTotal(){
    double total = 0;
    if(this.cartList.length > 0 ){
      for(int i = 0 ; i < this.cartList.length ; i++) {

//       total += (cartList[i].product.currentPrice * cartList[i].qty);
        print(this.cartList[i].product.productName);
        print(this.cartList[i].calSubTotal());
        total+= this.cartList[i].calSubTotal();
      }
    }
    this.total = total;
    notifyListeners();
  }


  Future<int> submitOrder(userID) async {
    if(cartList.length > 0) {
      var url = Constant.createOrderUrl;
      print(url);
//    var response = await http.get(url);
//    print(jsonDecode(response.body));
//    Map<String, String> headers = {"Content-type": "application/json"};
      var cartListInfo = [];
      for(int i = 0 ; i < cartList.length ; i ++ ){
        var salesBuyXGetY = "";
        var salesDiscount = "";
        var salesDiscountRate =  "";
        var salesSpecialPrice = "";
        if(cartList[i].selectedSalesDiscountRateList.length > 0){
          for(int j = 0 ; j< cartList[i].selectedSalesDiscountRateList.length ; j ++){
            salesDiscountRate += (cartList[i].selectedSalesDiscountRateList[j].id.toString() + " ");
          }
        }
        if(cartList[i].selectedSalesBuyXGetYList.length > 0){
          for(int j = 0 ; j< cartList[i].selectedSalesBuyXGetYList.length ; j ++){
            salesBuyXGetY += (cartList[i].selectedSalesBuyXGetYList[j].id.toString() + " ");
          }
        }
        if(cartList[i].selectedSalesDiscountList.length > 0){
          for(int j = 0 ; j< cartList[i].selectedSalesDiscountList.length ; j ++){
            salesDiscount += (cartList[i].selectedSalesDiscountList[j].id.toString() + " ");
          }
        }
        if(cartList[i].selectedSalesSpecialPriceList.length > 0){
          for(int j = 0 ; j< cartList[i].selectedSalesSpecialPriceList.length ; j ++){
            salesSpecialPrice += (cartList[i].selectedSalesSpecialPriceList[j].id.toString() + " ");
          }
        }
        cartList[i].calSubTotal();
        cartListInfo.add({
          'productID': cartList[i].product.id,
          'qty': cartList[i].qty,
          'subTotal': cartList[i].subTotal,
          'salesBuyXGetYIdList' :salesBuyXGetY,
          'salesDiscountIDIdList': salesDiscount,
          'salesDiscountRateIdList': salesDiscountRate,
        });
      }
      Map data = {
        "userID" : userID,
        "cartListInfo": cartListInfo,
        "total": total,
      };
      print(data);
      var json = jsonEncode(data);
      print(jsonDecode(json));
      var  response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: json
      );
      print(response);
//      // check the status code for the result
      int statusCode = response.statusCode;
      print(statusCode);
      print(response.body);
//      var body = jsonDecode(response.body);



//      print(body);
      if(statusCode == 200){
        return 1;
      }else {
        if(response.body == "notEnoughValue"){
          return 2;
        }else {
           return 3;
        }

      }
    }

  }

}