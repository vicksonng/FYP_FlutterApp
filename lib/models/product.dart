import 'package:untitled/models/salesBuyXGetY.dart';
import 'package:untitled/models/salesDiscount.dart';
import 'package:untitled/models/salesDiscountRate.dart';
import 'package:untitled/models/salesSpecialPrice.dart';

class Product {
  int id;
  String productName;
  String picture;
  int oldPrice;
  int currentPrice;
  String benefits;
  String ingredients;
  String productType;
  List<SalesBuyXGetY> salesBuyXGetYList = [];
  List<SalesDiscount> salesDiscountList = [];
  List<SalesSpecialPrice> salesSpecialPriceList = [];
  List<SalesDiscountRate> salesDiscountRateList = [];


  Product(
      {this.id, this.productName, this.picture, this.oldPrice, this.currentPrice, this.benefits, this.ingredients, this.productType}
      );

  factory Product.fromJson(Map<String, dynamic> json) {
    return new Product(
        id: json['id'],
        productName: json['productName'],
        picture: json['imgURL'],
        oldPrice: json['oldPrice'],
        currentPrice: json['currentPrice'],
        benefits: json['benefits'],
        ingredients: json['ingredients'],
        productType: json['productType']
    );
  }

}

//  Product.fromJson(Map<String, dynamic> map) {
//    productName = map['productName'];
//    picture = map['imgName'];
//    oldPrice = int.parse(map['oldPrice']);
//    price = int.parse(map['currentPrice']);
//    benefits = map['benefits'];
//    ingredients = map['ingredients'];
//  }