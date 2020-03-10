import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/models/cartItem.dart';
import 'package:untitled/view_models/cartListViewModel.dart';
import 'package:untitled/views/components/productsListComponent.dart';
import 'package:untitled/views/components/quantityPicker.dart';
import 'package:untitled/views/components/recommendedListJaccard.dart';
import 'package:untitled/views/pages/shoppingCartPage.dart';
import 'package:untitled/models/product.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;
  ProductDetailsPage(this.product);
//  final productDetailsName;
//  final productDetailsPrice;
//  final productDetailsOldPrice;
//  final productDetailsImg;
//  final productDetailsBenefits;
//  final productDetailsIngredients;
//
//  ProductDetails({
//    this.productDetailsName,
//    this.productDetailsPrice,
//    this.productDetailsOldPrice,
//    this.productDetailsImg,
//    this.productDetailsBenefits,
//    this.productDetailsIngredients
//  });

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int qty = 0;

  callback(newQty) {
      print(newQty);
      setState(() {
        qty = newQty;
      });

  }

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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: new AppBar(
          elevation: 0.1,
          backgroundColor: Colors.lightGreen,
          title: Text('商品詳情'),
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

        body: new ListView(
          children: <Widget>[
            new Hero(
              tag: widget.product.productName,
              child: Image.network(widget.product.picture),
//              child: Image.asset(
//
//                  widget.productDetailsImg, fit: BoxFit.fitHeight),
            ),
            Container(
              color: Colors.lightGreen,
              height: 50,
              padding: EdgeInsets.all(5),
              child: new Row(
                children: <Widget>[
                  Container(
                    child:  Text(widget.product.productName,
                      style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                Spacer(),

                IconButton(
                   icon: Icon(Icons.favorite_border, color: Colors.white),
                   onPressed: (){},
                 )

            ],


    )

            ),
            Container(
              color: Colors.white,
              height: 50.0,
              padding: EdgeInsets.all(5),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        new Text("優惠價 ", style: TextStyle(color: Colors.red, fontSize: 15, decoration: null, fontWeight: FontWeight.bold),),
                        new Text("\$"+ widget.product.price.toString(), style: TextStyle(color: Colors.red, fontSize: 30, decoration: null, fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        new Text("原價 ",
                          style: TextStyle(color: Colors.grey, fontSize: 15, decoration: null, fontWeight: FontWeight.bold),),
                        new Text("\$"+widget.product.oldPrice.toString(),
                          style: TextStyle(color: Colors.grey, fontSize: 30, decoration: null, fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
                color: Colors.white,
                padding: EdgeInsets.all(5),
                child: Row(
                  children: <Widget>[
                    Text(
                      "數量： ",
                      style: TextStyle(color: Colors.grey, fontSize: 15, decoration: null, fontWeight: FontWeight.bold),
                    ),
                    new QuantityPicker(0, callback),
                    Expanded(
                      child: MaterialButton(
                        onPressed: (){
                          Provider.of<CartListViewModel>(context, listen: false).addItem(new CartItem(widget.product, qty));
                          _showDialog();
                        },
                        color: Colors.green,
                        child: new Text(
                          "加入購物車",
                          style: TextStyle(color: Colors.white, fontSize: 15, decoration: null, fontWeight: FontWeight.bold),
                        )
                      )
                    )

                  ],

                 )
            ),

            Container(
              color: Colors.white,
              padding: EdgeInsets.all(5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 50,
                    child: Text("功效：")
                  ),
                  Expanded(
                      child:  Text(widget.product.benefits)
                  )
                ],
              )
            ),
            Container(
                color: Colors.white,
                padding: EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        width: 50,
                        child:  Text("材料：")
                    ),
                    Expanded(
                        child:  Text(widget.product.ingredients)
                    )
                  ],
                )
            ),
            Divider(),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(5),
              child: Text("你可能會喜歡", style: TextStyle( color: Colors.black, fontWeight: FontWeight.bold),
              )
            ),
            Container(
              height: 220,
              child: new RecommendedListJaccardComponent(widget.product.id)
//              child: new Products('ALL')
            )

          ],
        )
    );
  }
}


//  RecommendationList ?????????????????
 class RecommendationList extends StatefulWidget {
   @override
   _RecommendationListState createState() => _RecommendationListState();
 }
 class _RecommendationListState extends State<RecommendationList>{
   var recommendation_list = [
     {
       "name" : "鴻福堂涼茶",
       "picture": "image/鴻福堂涼茶.jpg",
       "oldPrice": 20,
       "price": 10,
       "benefits": "清熱解毒、化濕利尿、健胃消滯",
       "ingredients": "純水、蔗糖、相思藤、菊花、雞骨草、水翁花、布渣葉、金錢草、甘草、羅漢果"
     },
     {
       "name" : "雞骨草",
       "picture": "image/雞骨草.jpg",
       "oldPrice": 20,
       "price": 15,
       "benefits": "清熱解毒、舒肝止痛、袪痰止咳",
       "ingredients": "純水、蔗糖、雞骨草、蜜棗、甘草、羅漢果",
     },

   ];
   @override
   Widget build(BuildContext context) {
     return GridView.builder(
         itemCount: recommendation_list.length,
         gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
           crossAxisCount: 2,

         ),
//         itemBuilder: (BuildContext context, int index){
//           return ProductWidget(
//               productName: recommendation_list[index]['name'],
//               picture: recommendation_list[index]['picture'],
//               oldPrice: recommendation_list[index]['oldPrice'],
//               price: recommendation_list[index]['price'],
//               benefits: recommendation_list[index]['benefits'],
//               ingredients: recommendation_list[index]['ingredients']
//           );
//         }
     );
   }

 }
//class RecommendedProduct extends StatelessWidget {
//  final Product product;
//
//
////  RecommendedProduct({this.productName, this.picture, this.oldPrice, this.price, this.benefits, this.ingredients});
//  @override
//  Widget build(BuildContext context) {
//    return Card(
//        child: Hero(
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
//
//              child: GridTile(
//                  footer: Container(
//                      padding: EdgeInsets.all(5.0),
//                      color: Colors.white,
//                      child: Row(
//                        children: <Widget>[
//                          Text (productName,
//                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//                          ),
//                          Spacer(),
//                          Text(
//                            "\$$price",
//                            style: TextStyle(
//                                color: Colors.red, fontWeight: FontWeight.w800),
//                          ),
//
//                        ],
//                      )
////                  child: ListTile(
////                    leading: Text(productName,
////                      style: TextStyle(fontWeight: FontWeight.bold),
////                    ),
////                    title:Text(
////                      "\$$price",
////                      style: TextStyle(
////                        color: Colors.red, fontWeight: FontWeight.w800),
////                      ),
////                    subtitle: Text(
////                      "\$$oldPrice",
////                      style: TextStyle(
////                        color:Colors.black54,
////                        fontWeight: FontWeight.w800,
////                        decoration: TextDecoration.lineThrough),
////                      )
////
////                  ),
//                  ),
//                  child: Image.asset(
//                    picture,
//                    fit: BoxFit.cover,
//                  )
//              ),
//            ),
//          ),
//
//        )
//    );
//
//
//  }
//
//}



//          new Container(
//            height: 400,
//            child: GridTile(
//              child: Container(
//                color: Colors.white10,
//                child: Image.asset(widget.productDetailsImg, fit: BoxFit.fitHeight),
//                FittedBox(
//                  child: Image.asset(widget.productDetailsImg, ),
//                ),
//              ),
//              footer: new Container(
//                color:Colors.white,
//                child: ListTile(
//                  leading: new Text(widget.productDetailsName,
//                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
//                  title: new Row(
//                    children: <Widget>[
//                      Expanded(
//                        child: new Text("\$${widget.productDetailsOldPrice}",
//                        style: TextStyle(color: Colors.grey, decoration: TextDecoration.lineThrough),)
//                      ),
//                      Expanded(
//                        child: new Text("\$${widget.productDetailsPrice}",
//                        style: TextStyle(color: Colors.red, decoration: null, fontWeight: FontWeight.bold),),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//            ),
//          ),

//          Row(
//            children: <Widget>[
//              Expanded(
//                child: MaterialButton(onPressed: (){},
//                  color: Colors.white,
//                  textColor: Colors.grey,
//                  child: Row(
//                    children: <Widget>[
//
//                    ],
//                  )
//                )
//              )
//            ],
//          )
//        ],
//      )
//    );
//  }
//}