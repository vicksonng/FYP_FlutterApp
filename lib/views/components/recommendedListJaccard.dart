import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/models/productList.dart';
import 'package:untitled/views/pages/productDetailsPage.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:untitled/models/product.dart';

class RecommendedListJaccardComponent extends StatefulWidget {
  final int reqID;

  RecommendedListJaccardComponent(this.reqID);
//  List<Product> product_list;

  @override
  _RecommendedListJaccardComponentState createState() => _RecommendedListJaccardComponentState();
}


class _RecommendedListJaccardComponentState extends State<RecommendedListJaccardComponent> {
  Future<List<Product>> product_list;

  Future<List<Product>> getRecommendation(int id) async {
//    var url = 'http://localhost:1337/products/findJaccard/' + id.toString();
    var url = 'https://fypsailsjs.herokuapp.com/products/getRecommendationsJaccard/' + id.toString();
    print(url);
    var response = await http.get(url);
    print(jsonDecode(response.body));
    var result = jsonDecode(response.body);
    print(result[0][0]);
//    print("++++++");
//    print(result);
//    print(".....");
//    print(Product.fromJson((resultProduct[0])).toString());

    List<dynamic> product_list_dynamic = result.map((i) => Product.fromJson(i)).toList();
    List<Product> product_list = new List<Product>();
    for(int i = 0; i < product_list_dynamic.length ; i ++){
      product_list.add(product_list_dynamic[i]);
      print(product_list_dynamic[i]);
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
  Widget _futureRecommendedList(BuildContext context, AsyncSnapshot snap) {
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
          print("done...");
          print(snap.data);
          if (snap.data == null) {
            return Text("No products");
          } else {
            return
               ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snap.data.length,
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
            builder: _futureRecommendedList,
            future: getRecommendation(widget.reqID)
        )
    );
    //return Container();
  }
}


class ProductWidget extends StatelessWidget {
  final Product product;

  ProductWidget({this.product});


  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        height: 100,
        child: Card(
            child: Hero(
              tag: product.productName,
              child: Material(
                child: InkWell(
                  onTap: () =>
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) =>
                          new ProductDetailsPage(product)
                      )),
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
                      child: Image.network(
                          product.picture,
                          width: 200,
//                          height: 100,
                      )
//                    product.picture,
//                    fit: BoxFit.cover,
//                  )
                  ),
                ),
              ),
            )
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

