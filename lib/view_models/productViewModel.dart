import 'package:untitled/models/product.dart';

class ProductViewModel {

  final Product product;

  ProductViewModel({this.product});

  String get productName {
    return this.product.productName;
  }
  String get ingredients {
    return this.product.ingredients;
  }

  String get benefits {
    return this.product.benefits;
  }

  int get price {
    return  this.product.price;
  }
  int get oldPrice {
    return this.product.oldPrice;
  }

}