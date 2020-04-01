class SalesDiscountRate {
  int id;
  int productID;
  int promotionID;
  int discountRate;
  int minQty;
  String startDate;
  String endDate;
  bool isSelected = false;
  bool restrictedOne;


  SalesDiscountRate(
      {this.id, this.productID, this.promotionID, this.discountRate, this.minQty, this.startDate, this.endDate, this.restrictedOne});


  factory SalesDiscountRate.fromJson(Map<String, dynamic> json) {
    return new SalesDiscountRate(
      id: json['id'],
      productID: json['productID'],
      promotionID: json['promotionID'],
      discountRate: json['discountRate'],
      minQty: json['minQty'],
      startDate: json['startDate'],
      endDate: json['this.endDate'],
      restrictedOne: json['restrictedOne']

    );
  }

  double calPrice(int qty , double subTotal){
    double newPrice = subTotal;
    print("original price: "+ subTotal.toString());
    print(this.discountRate);
    if(qty >= this.minQty){
      print(this.discountRate.toDouble()/10);
      newPrice = newPrice * (1 - this.discountRate.toDouble()/100);
      print("new price: " + newPrice.toString());
    }
    return newPrice;
  }
}