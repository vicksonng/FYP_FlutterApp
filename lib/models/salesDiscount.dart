class SalesDiscount {
  int id;
  int productID;
  int promotionID;
  int discount;
  int minQty;
  String startDate;
  String endDate;
  bool isSelected = false;
  bool restrictedOne;

  SalesDiscount(
      {this.id, this.productID, this.promotionID, this.discount, this.minQty, this.startDate, this.endDate , this.restrictedOne});


  factory SalesDiscount.fromJson(Map<String, dynamic> json) {
    return new SalesDiscount(
      id: json['id'],
      productID: json['productID'],
      promotionID: json['promotionID'],
      discount: json['discount'],
      minQty: json['minQty'],
      startDate: json['startDate'],
      endDate: json['this.endDate'],
      restrictedOne: json['restrictedOne']

    );
  }

  double calPrice(int qty, double subTotal){
    int times = (qty.toDouble() ~/ this.minQty);
    return subTotal - times * discount;
  }
}