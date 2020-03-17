import 'package:untitled/models/product.dart';
class CartItem{
  final product;
  int qty;
  double subTotal;

  CartItem(this.product, this.qty);

  Map<String, dynamic> toJson() =>
      {
        'product': product,
        'qty' : qty
      };

  calSubTotal() {
    this.subTotal = this.product.currentPrice * qty.toDouble();
  }
}