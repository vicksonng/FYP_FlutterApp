import 'package:untitled/models/product.dart';

class SalesBuyXGetY {
  int id;
  int productID;
  int promotionID;
  int buyX;
  int getYFree;
  String startDate;
  String endDate;
  bool isSelected = false;
  bool restrictedOne;

  SalesBuyXGetY(
      {this.id, this.productID, this.promotionID, this.buyX, this.getYFree, this.startDate, this.endDate, this.restrictedOne});


  factory SalesBuyXGetY.fromJson(Map<String, dynamic> json) {
    return new SalesBuyXGetY(
      id: json['id'],
      productID: json['productID'],
      promotionID: json['promotionID'],
      buyX: json['buyX'],
      getYFree: json['getYFree'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      restrictedOne: json['restrictedOne']
    );
  }

  double calPrice(int qty, double subTotal){
    var currentSinglePrice = subTotal / qty.toDouble();
    var times = (qty.toDouble() ~/(this.buyX + this.getYFree));
    var numberOfFree = times * this.getYFree;
    var numberOfPaid = qty - numberOfFree;
    double newPrice = numberOfPaid * currentSinglePrice;
    return newPrice;
  }

}