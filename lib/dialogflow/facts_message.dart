import 'package:flutter/material.dart';
import 'package:untitled/dialogflow/dialog_flow.dart';
import 'package:untitled/dialogflow/recommendationsMessage.dart';
import 'package:untitled/models/product.dart';
import 'package:untitled/view_models/productListViewModel.dart';
import 'package:untitled/views/components/quantityPicker.dart';
import 'package:provider/provider.dart';
import 'package:untitled/views/pages/productDetailsPage.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


class Facts extends StatelessWidget {
  final String text;
  final String name;
  final bool type;
  final String imgURL;
  final String title;
  final String subtitle;
  final String buttonText;
  final int messageType;

  Function(String) callback;
  Function(int) callback2;
//  final String = imgURL;
  Facts({this.text, this.name, this.type, this.imgURL, this.title, this.subtitle,this.buttonText, this.messageType, this.callback});

  List<Widget> botMessage(context) {
    int quantity = 0;
    callback2 = (int qty){
      quantity = qty;
      print(quantity);
    };
    Widget messageBody;

    if(messageType == 0){ // simple text message
      print("messageType = 0");
      messageBody = Text(text, );

    }else if (messageType == 1){ // card response
//      print("messageType = 1");
      print("in product");
      messageBody = new Column(
        children: <Widget>[
          Image.network(imgURL),
          Text(title),
          new Column(
            children: <Widget>[
              FlatButton(
                color: Colors.lightGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
//                  side: BorderSide(color: Colors.red)
                ),
                onPressed:() {
                  callback("購買商品");
                  },
                child: Text("購買商品", style: TextStyle(color: Colors.white),)

              ),
              FlatButton(
                  color: Colors.lightGreen,
                  shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
//                  side: BorderSide(color: Colors.red)
                  ),
                onPressed:() {
                  callback("請問有什麼推薦？");
                  },
                child: Text("取得推薦", style: TextStyle(color: Colors.white))
              )
            ],
          )
        ],
      );
    } else if(messageType == 2) {
      var productIdList = subtitle.split(' ');
      List<Product> products = [];
      for(var i= 0; i< productIdList.length ; i++ ){
        Product product = Provider.of<ProductListViewModel>(context).getSingleProduct(int.parse(productIdList[i]));
        products.add(product);
      }
      messageBody = new RecommendationsMessage(products);
//      messageBody = new Container();

//      Product product = Provider.of<ProductListViewModel>(context).getSingleProduct(int.parse(subtitle));
//      messageBody = new Column(
//        children: <Widget>[
//          Image.network(product.picture),
//          Row(
//            children: <Widget>[
//              Text(
//                product.productName,
//                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//              ),
//
//            ],
//          ),
//          Row(
//            children: <Widget>[
//              Text("功效："),
//              Text(product.benefits),
//            ],
//          ),
//          new Column(
//            children: <Widget>[
//              new Row(
//                children: <Widget>[
//                  new QuantityPicker(0, callback2),
//                  Expanded(
//                      child:
//                      MaterialButton(
//                          color: Colors.lightGreen,
//                          shape: RoundedRectangleBorder(
//                            borderRadius: new BorderRadius.circular(18.0),
////                         side: BorderSide(color: Colors.red)
//                          ),
//                          onPressed: (){},
//                          child: Text("購買", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
//                      )
//                  ),
//                ],
//              ),
//              new Row(
//                children: <Widget>[
//                  Expanded(
//                      child: MaterialButton(
//                          color: Colors.lightGreen,
//                          shape: RoundedRectangleBorder(
//                            borderRadius: new BorderRadius.circular(18.0),
////                          side: BorderSide(color: Colors.red)
//                          ),
//                          onPressed: (){
//                            Navigator.of(context).push(new MaterialPageRoute(
//                                builder: (context) =>
//                                new ProductDetailsPage(product)
//                            ));
//                          },
//                          child: Text("查看詳情", style: TextStyle(color: Colors.white),)
//                      )
//                  )
//
//                ],
//              )
//            ],
//          )
//
//        ],
//      );
    }

    return <Widget>[
      Container(
        margin: const EdgeInsets.only(right: 10.0),
        child: CircleAvatar(child: Padding(
          padding: const EdgeInsets.all(5),
          child: FlutterLogo(),
        ), backgroundColor: Colors.grey[200], radius: 12,),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(this.name,
                style: TextStyle(fontWeight: FontWeight.bold)),
            Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: messageBody,
                  )
                )
              ]
            )
          )
        ];
  }

  List<Widget> botRichMessage(context) {
    return <Widget>[
      Container(
        margin: const EdgeInsets.only(right: 10.0),
        child: CircleAvatar(child: Padding(
          padding: const EdgeInsets.all(5),
          child: FlutterLogo(),
        ), backgroundColor: Colors.grey[200], radius: 12,),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(this.name,
                style: TextStyle(fontWeight: FontWeight.bold)),
            Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(text, ),
                )
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> userMessage(context) {
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
//            Text(this.name, style: Theme.of(context).textTheme.subhead),
            Card(
                color: Colors.lightGreen,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(text, style: TextStyle(color: Colors.white),),
                )
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(left: 10.0),
        child: CircleAvatar(child: new Text(this.name[0]),backgroundColor: Colors.grey[200], radius: 12,),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? userMessage(context) : botMessage(context),
      ),
    );
  }
}