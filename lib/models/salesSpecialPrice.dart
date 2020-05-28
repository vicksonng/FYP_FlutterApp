class SalesSpecialPrice {
  int id;
  int productID;
  int promotionID;
  int price;
  int qty;
  String startDate;
  String endDate;
  bool isSelected = false;
  bool restrictedOne;


  SalesSpecialPrice(
      {this.id, this.productID, this.promotionID, this.price, this.qty, this.startDate, this.endDate, this.restrictedOne});


  factory SalesSpecialPrice.fromJson(Map<String, dynamic> json) {
    return new SalesSpecialPrice(
      id: json['id'],
      productID: json['productID'],
      promotionID: json['promotionID'],
      price: json['price'],
      qty: json['qty'],
      startDate: json['startDate'],
      endDate: json['this.endDate'],
      restrictedOne: json['restrictedOne']
    );
  }

  double calPrice(int qty , double subTotal, double itemPrice){
    double newPrice = subTotal.toDouble();
    var times = qty.toDouble() ~/ this.qty.toDouble();
    if(times> 0){
      var discount = itemPrice * this.qty - this.price;
      var totalDiscount = discount * times;
      newPrice -=totalDiscount;
    }

//    var remainingQty = qty - this.qty*times;
//    if(qty >= this.qty){
//      newPrice - this.price;
//    }
    return newPrice;

  }
}