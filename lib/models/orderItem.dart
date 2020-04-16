class OrderItem{
  String productName;
  int qty;
  var subTotal;

  OrderItem(this.productName, this.qty, this.subTotal);

  OrderItem castOrderItem(rawItem){
    OrderItem tempItem = new OrderItem(rawItem['productName'], rawItem['qty'], rawItem['subTotal']);
    return tempItem;

  }

}