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

  double calPrice(int qty , double subTotal){
    double newPrice = subTotal;
    if(qty > this.qty){
      price -= this.price;
    }
    return newPrice;

  }
}