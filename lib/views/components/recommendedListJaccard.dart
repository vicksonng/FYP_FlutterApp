import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:untitled/app/constant.dart';
import 'package:untitled/models/productList.dart';
import 'package:untitled/view_models/productListViewModel.dart';
import 'package:untitled/view_models/userViewModel.dart';
import 'package:untitled/views/pages/productDetailsPage.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:untitled/models/product.dart';
import 'package:untitled/app/app.dart';

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
    String urlPrefix = Constant.getUrlPrefix();
    String urlSuffix = '/products/getRecommendationsJaccard/' + id.toString();
    String url = urlPrefix +urlSuffix;
//    var url = 'https://fypsailsjs.herokuapp.com/products/getRecommendationsJaccard/' + id.toString();
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
    var productVM = Provider.of<ProductListViewModel>(context);
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
                Product product = productVM.getSingleProduct(snap.data[index].id);
                return ProductWidget(
//                        product: snap.data[index]
                          product: product

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
    var userVM = Provider.of<UserViewModel>(context);

    var isSales = false;
    if(product.salesBuyXGetYList.length > 0 || product.salesDiscountList.length > 0 || product.salesSpecialPriceList.length > 0){
      print("is ok JaccarD......");
      isSales = true;
    }

//    Future<bool> addSearchHistory() async {
////      var url = 'http://localhost:1337/user/searched';
////      var url = 'https://fypsailsjs.herokuapp.com/user/searched';
//      String urlSuffix = "/user/searched";
//      String urlPrefix = Constant.getUrlPrefix();
//      String url = urlPrefix + urlSuffix;
//      print(url);
//      print(this.product.id);
////    var response = await http.get(url);
////    print(jsonDecode(response.body));
////    Map<String, String> headers = {"Content-type": "application/json"};
//      Map data = {
//        "userID" : Provider.of<UserViewModel>(context, listen: false).userID,
//        "productID" : this.product.id,
//      };
//      var json = jsonEncode(data);
//      var  response = await http.post(
//          url,
//          headers: {"Content-Type": "application/json"},
//          body: json
//      );
//      // check the status code for the result
//      int statusCode = response.statusCode;
//      print(statusCode);
//      var body = jsonDecode(response.body);
//      print(body);
//      if(statusCode == 200){
//        return true;
//      }else {
//        return false;
//      }
//    }
    return Container(
        width: 200,
//        height: 100,
        child: Card(
            child: Hero(
              tag: product.productName,
              child: Material(
                child: InkWell(
                  onTap: () async {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) =>
                        new ProductDetailsPage(product)

                    ));
//                    var response = await userVM.addSearchHistory(product.id);
//                    print(response);
//                    print("added 3");
                    if(userVM.role == "member"){
                      var response = await userVM.addSearchHistory(product.id);
                      print(response);
                      print("added");
                    }
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
                      child: Stack(
                        children: <Widget>[
                          Image.network(product.picture),
                          isSales? new Container(
                              height: 80,
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Image.asset("image/sales.png")
                              )
                          ): Container()
                        ],

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
