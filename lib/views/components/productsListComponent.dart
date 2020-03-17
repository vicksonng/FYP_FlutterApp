import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/models/productList.dart';
import 'package:untitled/view_models/userViewModel.dart';
import 'package:untitled/views/pages/productDetailsPage.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:untitled/models/product.dart';

class ProductsListComponent extends StatefulWidget {
  final String productType;

  ProductsListComponent(this.productType);
//  List<Product> product_list;

  @override
  _ProductsListComponentState createState() => _ProductsListComponentState();
}


class _ProductsListComponentState extends State<ProductsListComponent> {
  Future<List<Product>> product_list;

  Future<List<Product>> getProducts(String productType) async {
//    var url = 'http://localhost:1337/products/category/' + productType;
    var url = 'https://fypsailsjs.herokuapp.com/products/category/' + productType;
    print(url);
    var response = await http.get(url);
//    print(jsonDecode(response.body));
    var result = jsonDecode(response.body);
//    print(result[0]);

//    print(Product.fromJson((result[0])).toString());

    List<dynamic> product_list_dynamic = result.map((i) => Product.fromJson(i)).toList();
    List<Product> product_list = new List<Product>();
    for(int i = 0; i < product_list_dynamic.length ; i ++){
      product_list.add(product_list_dynamic[i]);
    }

//      ProductList productList = new ProductList(products: product_list);
    return product_list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //product_list = getProducts(widget.productType);
    //print(product_list);
  }
  @override
  Widget _futureProductsList(BuildContext context, AsyncSnapshot snap) {
    switch (snap.connectionState) {
      case ConnectionState.none:
        {
          print("none");
          return Text("none");
        }
      case ConnectionState.active:
        {
          print("active");
          return Text("active");
        }
      case ConnectionState.waiting:
        {
          print("waiting");
          return Text("waiting");
        }
      case ConnectionState.done:
        {
          print("done");
//          print(snap.data);
          if (snap.data == null) {
            return Text("No products");
          } else {
            return GridView.builder(
                itemCount: snap.data.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,

                ),
                itemBuilder: (BuildContext context, int index) {
                  return ProductWidget(
                      product: snap.data[index]
                  );
                }
            );
          }
        }
        break;
      default:
        return null;
    }
  }

  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        builder: _futureProductsList,
        future: getProducts(widget.productType)
      )
    );

  //return Container();
  }
}


//    return GridView.builder(
//      itemCount: widget.product_list.length,
//      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//        crossAxisCount: 2,
//
//      ),
////        itemBuilder: (BuildContext context, int index){
////          return Product(
////            productName: widget.product_list[index]['name'],
////            picture: widget.product_list[index]['picture'],
////            oldPrice: widget.product_list[index]['oldPrice'],
////            price: widget.product_list[index]['price'],
////            benefits: widget.product_list[index]['benefits'],
////            ingredients: widget.product_list[index]['ingredients']
////          );
////        }
//        itemBuilder: (BuildContext context, int index){
//          return Product(
//              productName: widget.product_list[index]['productName'],
//              picture: widget.product_list[index]['imgName'],
//              oldPrice: widget.product_list[index]['oldPrice'],
//              price: widget.product_list[index]['currentPrice'],
//              benefits: widget.product_list[index]['benefits'],
//              ingredients: widget.product_list[index]['ingredients']
//          );
//        }
//    );



    // ver 1
//    return GridView.builder(
//      itemCount: widget.product_list.length,
//      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//        crossAxisCount: 2,
//
//      ),
////        itemBuilder: (BuildContext context, int index){
////          return Product(
////            productName: widget.product_list[index]['name'],
////            picture: widget.product_list[index]['picture'],
////            oldPrice: widget.product_list[index]['oldPrice'],
////            price: widget.product_list[index]['price'],
////            benefits: widget.product_list[index]['benefits'],
////            ingredients: widget.product_list[index]['ingredients']
////          );
////        }
//        itemBuilder: (BuildContext context, int index){
//          return Product(
//              productName: widget.product_list[index]['productName'],
//              picture: widget.product_list[index]['imgName'],
//              oldPrice: widget.product_list[index]['oldPrice'],
//              price: widget.product_list[index]['currentPrice'],
//              benefits: widget.product_list[index]['benefits'],
//              ingredients: widget.product_list[index]['ingredients']
//          );
//        }
//    );
//  }
//}

class ProductViewModel {
  Stream<String> productName;
  Stream<String> picture;
  Stream<String> oldPrice;
  Stream<String> price;
  Stream<String> ingredients;
}

class ProductWidget extends StatelessWidget {
  final Product product;

  ProductWidget({this.product});




  @override
  Widget build(BuildContext context) {


    Future<bool> addSearchHistory() async {
//      var url = 'http://localhost:1337/user/searched';
      var url = 'https://fypsailsjs.herokuapp.com/user/searched';
      print(url);
//    var response = await http.get(url);
//    print(jsonDecode(response.body));
//    Map<String, String> headers = {"Content-type": "application/json"};
      Map data = {
        "userID" : Provider.of<UserViewModel>(context, listen: false).userID,
        "productID" : this.product.id,
      };
      var json = jsonEncode(data);
      var  response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: json
      );
      // check the status code for the result
      int statusCode = response.statusCode;
      print(statusCode);
      var body = jsonDecode(response.body);


      print(body);
      if(statusCode == 200){
//        this.session =  UserSession.fromJson(body);
//        print(this.session.userID);
        return true;
      }else {
        return false;
      }
    }
    return Card(
        child: Hero(
          tag: product.productName,
          child: Material(
            child: InkWell(
              onTap: () async {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) =>
                    new ProductDetailsPage(product)
                ));
                var response = await addSearchHistory();
                print(response);
                print("added");

              },

              child: GridTile(
                  footer: Container(
                      padding: EdgeInsets.all(5.0),
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Text(product.productName,
                            style: TextStyle(color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text(
                            "\$"+product.currentPrice.toString(),
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w800),
                          ),

                        ],
                      )
                  ),
                    child: Image.network(product.picture)
//                    product.picture,
//                    fit: BoxFit.cover,
//                  )
              ),
            ),
          ),

        )
    );
  }
}


//class Product extends StatelessWidget {
//  final productName;
//  final picture;
//  final oldPrice;
//  final price;
//  final benefits;
//  final ingredients;
//
//  Product({this.productName, this.picture, this.oldPrice, this.price, this.benefits, this.ingredients});
//
//
//  @override
//  Widget build(BuildContext context) {
//    return Card(
//      child: Hero(
//          tag: productName,
//          child: Material(
//            child: InkWell(
//              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
//                  builder: (context) => new ProductDetails(
//                    productDetailsName: productName,
//                    productDetailsPrice: price,
//                    productDetailsOldPrice: oldPrice,
//                    productDetailsImg: picture,
//                    productDetailsBenefits: benefits,
//                    productDetailsIngredients: ingredients,
//
//                  ))),
//              child: GridTile(
//                footer: Container(
//                  padding: EdgeInsets.all(5.0),
//                  color: Colors.white,
//                  child: Row(
//                    children: <Widget>[
//                       Text (productName,
//                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//                       ),
//                      Spacer(),
//                      Text(
//                        "\$$price",
//                        style: TextStyle(
//                          color: Colors.red, fontWeight: FontWeight.w800),
//                      ),
//
//                    ],
//                  )
//                ),
//                child: Image.asset(
//                  picture,
//                  fit: BoxFit.cover,
//                )
//              ),
//            ),
//          ),
//
//      )
//    );
//
//
//  }

//}

