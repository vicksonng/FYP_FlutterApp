import 'package:flutter/material.dart';
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

class ProductsListCategoryComponent extends StatefulWidget {
  final String productType;

  ProductsListCategoryComponent(this.productType);
//  List<Product> product_list;

  @override
  _ProductsListCategoryComponentState createState() => _ProductsListCategoryComponentState();
}


class _ProductsListCategoryComponentState extends State<ProductsListCategoryComponent> {

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
          print(snap.data);
          if (snap.data == null) {
            return Text("No products");
          } else {
            List<Product> products = Provider.of<ProductListViewModel>(context, listen: false).getProductsCategory(widget.productType);
            return GridView.builder(
                itemCount: products.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio:
                  MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height /1.9),
                ),
                itemBuilder: (BuildContext context, int index) {
                  return ProductWidget(
                      product: products[index]
                  );
                }
//                itemCount: snap.data.length,
//                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//                  crossAxisCount: 2,
//                  childAspectRatio:
//                       MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height /1.9),
//                ),
//                itemBuilder: (BuildContext context, int index) {
//                  return ProductWidget(
//                      product: snap.data[index]
//                  );
//                }
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
//        future: getProducts(widget.productType)
          future: Provider.of<ProductListViewModel>(context, listen: false).getProductsType(widget.productType),
//        future: Provider.of<ProductListViewModel>(context, listen: false).fetchProducts(),

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
    var isSales = false;
    var userVM = Provider.of<UserViewModel>(context);

    if(product.salesBuyXGetYList.length > 0 || product.salesDiscountList.length > 0 || product.salesSpecialPriceList.length > 0){
      print("is ok");
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
        height: 280,
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
                    var response = await userVM.addSearchHistory(product.id);
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




