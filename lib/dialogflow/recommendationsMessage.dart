import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:untitled/models/cartItem.dart';
import 'package:untitled/models/product.dart';
import 'package:flutter/material.dart';
import 'package:untitled/view_models/cartListViewModel.dart';
import 'package:untitled/view_models/userViewModel.dart';
import 'package:untitled/views/components/quantityPicker.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:untitled/views/pages/productDetailsPage.dart';
import 'package:dart_random_choice/dart_random_choice.dart';

class RecommendationsMessage extends StatelessWidget {

  final List<Product> products;

  RecommendationsMessage(this.products);

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
//    return Container(
//      height: 400,
//      width: 400,
    return Container(
      height: 470,
      child:  Column(
        children: <Widget>[
          ListTile(
            title: Text("小幫手誠意為你推薦"),
          ),
          Flexible(
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return new SingleProductRecommendations(this.products[index]);
                },
                itemCount: this.products.length,
                viewportFraction: 0.8,
                scale: 0.4,
              )
          ),

        ],
      )
    );
//
//
//    );
  }
}


class SingleProductRecommendations extends StatelessWidget{
  Product product;
  int quantity = 0;
  Function callback;
  SingleProductRecommendations(this.product);


  @override
  Widget build(BuildContext context) {
    final userVM = Provider.of<UserViewModel>(context);
    int quantity =0;
    callback = (int quantity){
      this.quantity = quantity;
    };
    void _showDialog() {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("通知"),
            content: new Text("已成功加到購物車"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("關閉"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }


    // TODO: implement build
    return new Container(

      child:
        ListView(
          shrinkWrap: true,
          children: <Widget>[

            
            Container(
              height: 250,
             child:  Stack(
                  children: <Widget> [
                    Align(
                      alignment: Alignment.center,
                      child:Image.network(product.picture),
                    ),
                    Align(
                      child: Icon(Icons.navigate_before),
                      alignment: Alignment.centerLeft,
                    ),
                    Align(
                      child: Icon(Icons.navigate_next),
                      alignment: Alignment.centerRight,

                    )
                  ]


              ),

            ),


            Row(
              children: <Widget>[
                Text(
                  product.productName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),

              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      new Text("優惠價 ", style: TextStyle(color: Colors.red, fontSize: 15, decoration: null, fontWeight: FontWeight.bold),),
                      new Text("\$"+ product.currentPrice.toString(), style: TextStyle(color: Colors.red, fontSize: 20, decoration: null, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      new Text("原價 ",
                        style: TextStyle(color: Colors.grey, fontSize: 15, decoration: null, fontWeight: FontWeight.bold),),
                      new Text("\$"+product.oldPrice.toString(),
                        style: TextStyle(color: Colors.grey, fontSize: 20, decoration: null, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ],

            ),
//            Row(
//              children: <Widget>[
//                Text("功效："),
//                Expanded(
//                  child: Text(product.benefits),
//
//                )
//              ],
//            ),
            new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new QuantityPicker(0, callback, false),
                    Expanded(
                        child:
                        MaterialButton(
                            color: Colors.lightGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
//                         side: BorderSide(color: Colors.red)
                            ),
                            onPressed: (){
                              Provider.of<CartListViewModel>(context, listen: false).addItem(new CartItem(product, this.quantity));
                              _showDialog();
                            },
                            child: Text("加入購物車", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                        )
                    ),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    Expanded(
                        child: MaterialButton(
                            color: Colors.lightGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
//                          side: BorderSide(color: Colors.red)
                            ),
                            onPressed: () async {
                              Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (context) =>
                                  new ProductDetailsPage(product)
                              ));
                              if(userVM.role == "member"){
                                var response = await userVM.addSearchHistory(product.id);
                                print(response);
                                print("added");
                              }
                            },
                            child: Text("查看詳情", style: TextStyle(color: Colors.white),)
                        )
                    )

                  ],
                )
              ],
            )

          ],
        )
    );
    }

}

