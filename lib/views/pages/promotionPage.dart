import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/app/constant.dart';
import 'package:untitled/models/product.dart';
import 'package:untitled/models/promotion.dart';
import 'package:untitled/models/user.dart';
import 'package:untitled/view_models/promotionPageViewModel.dart';
import 'package:untitled/view_models/promotionViewModel.dart';
import 'package:untitled/view_models/userViewModel.dart';
import 'package:untitled/views/pages/productDetailsPage.dart';
import 'package:untitled/views/pages/shoppingCartPage.dart';
import 'package:untitled/view_models/productListViewModel.dart';
import 'package:expandable/expandable.dart';
import 'package:http/http.dart' as http;


class PromotionPage extends StatefulWidget {
  _PromotionPageState createState() => _PromotionPageState();
}

class _PromotionPageState extends State<PromotionPage> {

  @override
  Widget build(BuildContext context) {
    final promotionVM = Provider.of<PromotionPageViewModel>(context);
    promotionVM.fetchPromotion();

    // TODO: implement build
    return Scaffold(
        appBar: new AppBar(
          elevation: 0.1,
          backgroundColor: Colors.lightGreen,
          title: Text('推廣活動'),
          actions: <Widget>[
            new IconButton(icon: Icon(Icons.search, color: Colors.white,),
              onPressed: () {}),
            new IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.white,),
              onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => new ShoppingCartPage()));
              })
          ],
        ),
        body: PromotionListWidget(),
//        body:Container(
//          child: PromotionListWidget()
//        )
    );
  }
}
class PromotionListWidget extends StatefulWidget{
  _PromotionListWidgetState createState() => _PromotionListWidgetState();

}
class _PromotionListWidgetState extends State<PromotionListWidget>{
  @override
  Widget _futurePromotionList(BuildContext context, AsyncSnapshot snap) {
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
            return Text("No Promotion");
          } else {
            return ListView.builder(
                itemCount: snap.data.length,
//                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//                  crossAxisCount: 2,
//                  childAspectRatio:
//                  MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height /1.9),
//                ),
                itemBuilder: (BuildContext context, int index) {
                  return PromotionWidget(snap.data[index]
//                      promotion:
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
          builder: _futurePromotionList,
//        future: getProducts(widget.productType)
          future: Provider.of<PromotionPageViewModel>(context, listen: false).getPromotion(),
        )
    );

    //return Container();
  }
}

class PromotionWidget extends StatelessWidget{
  final Promotion promotion;
  PromotionWidget(this.promotion);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      elevation: 5,

      child: Column(
        children: <Widget>[
          Container(
            height: 300,
            child: Image.network(promotion.promotionImgURL),
          ),
          Theme(
              data: Theme.of(context).copyWith(accentColor: Colors.black54, unselectedWidgetColor: Colors.grey.withOpacity(0.8)),
            child:  ExpansionTile(

              title: Container(

                child: Text(promotion.promotionName, style: TextStyle(color: Colors.black87),),
              ),
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(10),
                    child: Text(promotion.promotionDesc)
                ),
//                promotion.relatedProducts.length > 0 ? RelatedProductsWidget(promotion.relatedProducts)
                promotion.relatedProducts.length > 0 ?
                    Column(
                      children: <Widget>[
                          Row(
                            children: <Widget>[
                                        Container(
                                            padding: EdgeInsets.all(10),
                                             child: Text("相關產品：")

                                        )
                            ],
                            ),
                        Container(
                        child: RelatedProductsWidget(promotion.relatedProducts),
                        height: 250,
                        )

                      ],
                    ): Container(),

              ],
            )

          )

        ],
      )
    );
  }
}

class RelatedProductsWidget extends StatelessWidget{
  final List<int> relatedProducts;
  RelatedProductsWidget(this.relatedProducts);

  @override
  Widget build(BuildContext context) {
    List<Product> products = [];
    for(int  i = 0 ; i < relatedProducts.length ; i ++) {
      Product product = Provider.of<ProductListViewModel>(context).getSingleProduct(relatedProducts[i]);
      products.add(product);
    }

    // TODO: implement build
    if(products.length > 0 ){
      return  ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index) {
            return ProductWidget(
                product: products[index]
            );
          }
      );

    } else {
      return null;
    }

  }
}



class ProductWidget extends StatelessWidget {
  final Product product;

  ProductWidget({this.product});


  @override
  Widget build(BuildContext context) {
    var userVM = Provider.of<UserViewModel>(context);

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
//        height: ,
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
                    print("added 3");
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

//class PromotionWidget extends StatefulWidget{
//  Promotion promotion;
//  PromotionWidget(this.promotion);
//
//  _PromotionWidgetState createState() => _PromotionWidgetState();
//
//}
//
//class _PromotionWidgetState extends State<PromotionPage>{
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Card(
//
//      child: Column(
//        children: <Widget>[
//          Container(
//            height: 300,
//            child: Image.network(widget.promotion.promotionImgURL)
//          )
//
//        ],
//      )
//
//    )

//      Card(
//      child: GridTile(
//        footer:
////        trailing: Container(
////          child: Text("Fuck You"),
////        )
//
//
//      )
//
//
//
//
//      );

//  }
//}