import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:untitled/models/productList.dart';
import 'package:untitled/models/recommendations.dart';
import 'package:untitled/view_models/userViewModel.dart';
import 'package:untitled/views/pages/productDetailsPage.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:untitled/models/product.dart';
import 'package:untitled/app/app.dart';
import 'package:untitled/app/constant.dart';

class RecommendationsHorizontalComponent extends StatefulWidget {
  final Recommendations recommendations;

  RecommendationsHorizontalComponent(this.recommendations);
//  List<Product> product_list;

  @override
  _RecommendationsHorizontalComponentState createState() => _RecommendationsHorizontalComponentState();
}


class _RecommendationsHorizontalComponentState extends State<RecommendationsHorizontalComponent> {


  Future<List<Product>> getRecommendation() async {

//    String urlSuffix = '/products/getRecommendationsJaccard/' + id.toString();

//    var url = 'https://fypsailsjs.herokuapp.com/products/getRecommendationsJaccard/' + id.toString();
//    String url = Constant.recommendationsUbcfUrl + id.toString();
    String url = widget.recommendations.url;
    print(url);
    var response = await http.get(url);
    print(jsonDecode(response.body));
    var result = jsonDecode(response.body);
    print(result[0][0]);

    List<dynamic> product_list_dynamic = result.map((i) => Product.fromJson(i)).toList();
    List<Product> product_list = new List<Product>();
    for(int i = 0; i < product_list_dynamic.length ; i ++){
      product_list.add(product_list_dynamic[i]);
      print(product_list_dynamic[i]);
    }
    return product_list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            return Container();
          } else {
            return
              Container(
                height: 350,
                child: Column(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          child: Text(widget.recommendations.recommendationsName, style: TextStyle(color: Colors.black54, fontSize: 30, fontWeight: FontWeight.bold),),
                          padding: EdgeInsets.all(5),
                        )
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          child: Text(widget.recommendations.recommendationDesc, style: TextStyle(color: Colors.black54),),
                          padding: EdgeInsets.all(5),
                        )
                    ),

                    Container(
                      height: 250,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snap.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ProductWidget(
                              product: snap.data[index],
                              order:index
                            );
                          }
                      )
                    )

                  ],
                )
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
            future: getRecommendation()
        )
    );
    //return Container();
  }
}


class ProductWidget extends StatelessWidget {
  final Product product;
  final int order;

  ProductWidget({this.product, this.order});


  @override
  Widget build(BuildContext context) {
    var userVM = Provider.of<UserViewModel>(context);

    Widget crown;
    if(order == 0){
      crown = Image.asset('image/goldCrown.png');
    } else if(order==1){
      crown = Image.asset('image/sliverCrown.png');
    }else if(order ==2 ){
      crown = Image.asset('image/bronzeCrown.png');
    }else{
      crown = null;
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
        height: 100,
        child: Card(
                  child: Material(
                    child: InkWell(
                      onTap: () async {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) =>
                            new ProductDetailsPage(product)
                        ));
//                        var response = await userVM.addSearchHistory(product.id);
//                        print(response);
//                        print("added 2");
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
                          child: Container(
                            child: Stack(
                              children: <Widget>[
                                Image.network(
                                  product.picture,
                                  width: 200,
//                                height: 100,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    height:50,
                                    width:50,
                                    child: crown

                                  )
                                )
                              ],
                            )

                          )
//                    product.picture,
//                    fit: BoxFit.cover,
//                  )

                  ),
                )
            )
        )
    );
  }
}
