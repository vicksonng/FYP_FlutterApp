import 'package:untitled/models/product.dart';

class ProductList{
  List<Product> products;

  ProductList({this.products});

  factory ProductList.fromJson(List<dynamic> parsedJson) {
    List<Product> products = new List<Product>();
    products = parsedJson;
//    products = parsedJson.map((i) => Product.fromJson(i)).toList();
    print(".......");
    print(products);

    return new ProductList(
        products: products
    );
  }

}