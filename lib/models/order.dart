import 'package:untitled/models/orderItem.dart';

class Order{
  int id;
  var total;
  List<OrderItem>itemList;
  String date;

  Order(this.id, this.total, this.itemList, this.date);


}