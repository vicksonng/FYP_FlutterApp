//import 'package:flutter/material.dart';
//import 'package:untitled/models/cartItem.dart';
//import 'package:untitled/views/components/quantityPicker.dart';
//
//class CartProducts extends StatefulWidget{
//  @override
//  _CartProductsState createState() => _CartProductsState();
//}
//
//class _CartProductsState extends State<CartProducts>{
////  var cartItems = [
////    new CartItem(1, "鴻福堂涼茶", "https://www.hungfooktong.com/wp-content/uploads/2019/04/19202-10-1.jpg", 10, 3),
////    new CartItem(2, "雞骨草", "https://www.hungfooktong.com/wp-content/uploads/2019/04/19202-3-1.jpg", 15, 4)
////  ];
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return new ListView.builder(
//      itemCount: cartItems.length,
//      itemBuilder: (context, index){
//        return CartItemWidget(
//          cartItems[index]
//        );
//      },
//    );
//  }
//
//}
//class CartItemWidget extends StatefulWidget {
//  CartItem cartItem;
//  CartItemWidget(this.cartItem);
//
//  _CartItemWidgetState createState() => _CartItemWidgetState();
//}
//
//
//class _CartItemWidgetState extends State<CartItemWidget>{
//  CartItem cartItem;
//
//  callback(newQty) {
//
//    setState(() {
//      print("....");
//      print(newQty);
//    });
//  }
//  @override
//  void initState(){
//    super.initState();
//    cartItem = widget.cartItem;
//  }
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Card(
//      child: Row(
//        children: <Widget>[
//          Container(
//            margin: EdgeInsets.all(10),
//            child: Image.network(cartItem.picture, width: 80, height: 100,),
//
//          ),
//          Expanded(
//            child: Text(cartItem.productName, style: TextStyle(fontWeight: FontWeight.bold)),
//          ),
//          Expanded(
//            child: Container(
//              padding: EdgeInsets.all(20),
//              child: Text("\$"+ cartItem.price.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
//
//          )
//          ),
//          Container(
//            color: Colors.lightGreen,
//            child: Transform.scale(
//              scale: 1,
//              child: new QuantityPicker(cartItem.qty, callback)
//              )
//
//          ),
//
//        ],
//      ),
//    );
//  }
//}
