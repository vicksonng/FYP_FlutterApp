import 'package:flutter/material.dart';
import 'package:untitled/models/cartItem.dart';
import 'package:untitled/view_models/cartListViewModel.dart';
import 'package:untitled/views/components/cart_products.dart';
import 'package:untitled/views/components/quantityPicker.dart';
import 'package:provider/provider.dart';

class ShoppingCartPage extends StatefulWidget{
  @override

 _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {


//  double totalPrice;
////  var cartItems = [
////    new CartItem(1, "鴻福堂涼茶", "https://www.hungfooktong.com/wp-content/uploads/2019/04/19202-10-1.jpg", 10, 3),
////    new CartItem(2, "雞骨草", "https://www.hungfooktong.com/wp-content/uploads/2019/04/19202-3-1.jpg", 15, 4)
////  ];
//
//  void _calTotal() {
//    double total = 0;
//    for(int i = 0 ; i < cartItems.length; i++){
//      var subTotal = cartItems[i].qty * cartItems[i].price;
//      total += subTotal;
//    }
//    setState(() {
//      totalPrice = total;
//    });
//  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    _calTotal();
  }

  @override
  Widget build(BuildContext context) {
    final cartListVM = Provider.of<CartListViewModel>(context);

    List<CartItem> cartItems = cartListVM.cartList;

    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text('我的購物車'),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: (){}),
        ],
      ),



      body: cartItems.length == 0 ? Center(child: Text('Empty')) :new ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index){
                CartItem cartItem = cartItems[index];
                callback(newQty){
                  cartListVM.setQty(index, newQty);
//                  setState(() {
////                    cartItems[index].qty = newQty;
////                    _calTotal();
//                  });
                }

                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: IconButton (
                          icon: const Icon(Icons.close),
                          onPressed: (){
                            print(cartItems[index].product.id);
                            cartListVM.removeItem(cartItems[index].product.id);
                          },
                        )
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
                        child: Image.network(cartItems[index].product.picture, width: 80, height: 100,),

                      ),
                      Expanded(
                        flex: 2,
                        child: Text(cartItems[index].product.productName, style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        flex: 1,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Text("\$"+ cartItems[index].product.price.toString(), style: TextStyle(fontWeight: FontWeight.bold)),

                          )
                      ),
                      Container(
                          color: Colors.lightGreen,
                          child: Transform.scale(
                              scale: 1,
                              child: new QuantityPicker(cartItems[index].qty, callback)
                          )

                      ),

                    ],
                  ),
                );;
              },
            ),
      bottomNavigationBar: new Container(
        margin: EdgeInsets.all(20),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child:  Text("合共 \$" + cartListVM.subTotal.toString()),
              ),
            Expanded(
              child: new MaterialButton(onPressed: (){},
                color: Colors.red,
                child:  new Text("結帳",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),

          ],

        ),
      ),
    );
  }
}