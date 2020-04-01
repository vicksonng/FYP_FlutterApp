import 'package:flutter/material.dart';
import 'package:untitled/models/cartItem.dart';
import 'package:untitled/view_models/cartListViewModel.dart';
import 'package:untitled/view_models/userViewModel.dart';
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

    void _showDialog(int result) {
      String message = "";
      if(result == 0){
        message = "對不起，優惠不能同時使用，請重新選擇";
        print(message);
      } else if (result == 1 ){
        message = "系統發生錯誤，請再試一次";
      }
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("通知"),
            content: new Text(message),
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
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text('我的購物車'),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: (){}),
        ],
      ),



      body: cartItems.length == 0 ? Center(child: Text('購物車沒有商品')) :new ListView.builder(
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

                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Card(
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
                                  child: Text("\$"+ cartItems[index].product.currentPrice.toString(), style: TextStyle(fontWeight: FontWeight.bold)),

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
                      ),
                      ListTile(
                        title: Text(
                              "可用優惠：",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12
                              ),),
                        trailing: Container(
                          padding: EdgeInsets.only(right: 5),
                          child: MaterialButton(
                              onPressed: (){
                                this.setState((){
                                  cartItems[index].clearSales();
                                  cartListVM.calTotal();
                                });

                              },
                              color: Colors.grey,
                              child: Text(
                                "重設",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                          ),
                        )

                      ),
//                      Row(
//                        children: <Widget>[
//                          Container(
//                            padding: EdgeInsets.all(5),
//                            child: Text(
//                              "可用優惠：",
//                              style: TextStyle(
//                                color: Colors.black54,
//                              ),
//                            )
//                          ),
//                          Expanded(
//                            child: Align(
//                              alignment: Alignment.centerRight,
//                              child: MaterialButton(
//                                color: Colors.grey,
//                                onPressed: (){},
//                              )
//                            ),
//                          )
//
//                        ],
//
//                      ),
                      // Salesssssss
                      (cartItems[index].product.salesBuyXGetYList.length >0)?
                      Container(
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: cartItems[index].product.salesBuyXGetYList.length,
                              itemBuilder: (BuildContext ct, int i) {
                                print(cartItems[index].product.salesBuyXGetYList[i].restrictedOne.toString() +" ?????");
                                return Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.all(5),
                                    child: ListTile(
                                      title: Text("買" + cartItems[index].product.salesBuyXGetYList[i].buyX.toString() + "送" + cartItems[index].product.salesBuyXGetYList[i].getYFree.toString()),
                                      trailing: MaterialButton(
                                        child:
                                            (cartItems[index].product.salesBuyXGetYList[i].isSelected)?
                                            Text("已選取", style: TextStyle(color: Colors.white)):
                                            Text("使用優惠", style: TextStyle(color: Colors.white)),
                                        color: (cartItems[index].product.salesBuyXGetYList[i].isSelected)? Colors.lightGreen: Colors.grey,
                                        onPressed: ()  {
                                          cartItems[index].product.salesBuyXGetYList[i].isSelected = !cartItems[index].product.salesBuyXGetYList[i].isSelected;
                                          if(cartItems[index].product.salesBuyXGetYList[i].isSelected){
                                            int result = cartItems[index].addSalesBuyXGetY(cartItems[index].product.salesBuyXGetYList[i]);
//                                            print("result: " + result.toString());
//                                              print(" Rcsdfdsfsd");
                                            if(result != 2){
                                              print("result != 2");
                                              cartItems[index].product.salesBuyXGetYList[i].isSelected = !cartItems[index].product.salesBuyXGetYList[i].isSelected;
                                              _showDialog(result);
                                            }
                                          }else{
                                            cartItems[index].removeSalesBuyXGetY(cartItems[index].product.salesBuyXGetYList[i]);
                                          }
                                          cartListVM.calTotal();
//                                          this.setState((){
//
//                                          });
                                        },
                                      ),
                                      subtitle: cartItems[index].product.salesBuyXGetYList[i].restrictedOne ?
                                      Text("* 此優惠碼不能與其他優惠同時使用"): null,
                                    )

                                );
                              }
                          )
                      ):Container(),
                      (cartItems[index].product.salesDiscountList.length >0)?
                      Container(
                          child:  ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: cartItems[index].product.salesDiscountList.length,
                              itemBuilder: (BuildContext ct, int i){
                                return Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.all(5),
                                    child: ListTile(
                                      title: Text("購買" + cartItems[index].product.salesDiscountList[i].minQty.toString() + "件，即享有 \$" + cartItems[index].product.salesDiscountList[i].discount.toString()+" 折扣優惠"),
                                      trailing: MaterialButton(
                                        child:
                                            (cartItems[index].product.salesDiscountList[i].isSelected)?
                                            Text("已選取", style: TextStyle(color: Colors.white)):
                                            Text("使用優惠", style: TextStyle(color: Colors.white)),
                                        color: (cartItems[index].product.salesDiscountList[i].isSelected)? Colors.lightGreen: Colors.grey,
                                        onPressed: (){
                                          cartItems[index].product.salesDiscountList[i].isSelected = !cartItems[index].product.salesDiscountList[i].isSelected;
                                          if(cartItems[index].product.salesDiscountList[i].isSelected){
                                            int result = cartItems[index].addSalesDiscount(cartItems[index].product.salesDiscountList[i]);
                                            if(result != 2){
                                              cartItems[index].product.salesDiscountList[i].isSelected = !cartItems[index].product.salesDiscountList[i].isSelected;
                                              _showDialog(result);
                                            }
                                          }else{
                                            cartItems[index].removeSalesDiscount(cartItems[index].product.salesDiscountList[i]);
                                          }
                                          cartListVM.calTotal();
                                        },
                                      ),
                                      subtitle: (cartItems[index].product.salesDiscountList[i].restrictedOne == true)?
                                      Text("* 此優惠碼不能與其他優惠同時使用"): null,
                                    )

                                );
                              }
                          )

                      ):Container(),
                      (cartItems[index].product.salesDiscountRateList.length >0)?
                      Container(
                          child:  ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: cartItems[index].product.salesDiscountRateList.length,
                              itemBuilder: (BuildContext ct, int i){
                                return Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.all(5),
                                    child: ListTile(
                                        title: Text("購買" + cartItems[index].product.salesDiscountRateList[i].minQty.toString() + "件，即享有 " + cartItems[index].product.salesDiscountRateList[i].discountRate.toString()+"% 折扣優惠"),
                                        trailing: MaterialButton(
                                          child:
                                              (cartItems[index].product.salesDiscountRateList[i].isSelected)?
                                              Text("已選取", style: TextStyle(color: Colors.white)):
                                              Text("使用優惠", style: TextStyle(color: Colors.white)),
                                          color: (cartItems[index].product.salesDiscountRateList[i].isSelected)? Colors.lightGreen: Colors.grey,
                                          onPressed: (){
                                            cartItems[index].product.salesDiscountRateList[i].isSelected = !cartItems[index].product.salesDiscountRateList[i].isSelected;
                                            if(cartItems[index].product.salesDiscountRateList[i].isSelected){
                                              int result = cartItems[index].addSalesDiscountRate(cartItems[index].product.salesDiscountRateList[i]);
                                              if(result != 2){
                                                cartItems[index].product.salesDiscountRateList[i].isSelected = !cartItems[index].product.salesDiscountRateList[i].isSelected;
                                                _showDialog(result);
                                              }
                                            }else{
                                              cartItems[index].removeSalesDiscountRate(cartItems[index].product.salesDiscountRateList[i]);
                                            }
                                            cartListVM.calTotal();
                                          },
                                        ),
                                      subtitle: (cartItems[index].product.salesDiscountRateList[i].restrictedOne)?
                                      Text("* 此優惠碼不能與其他優惠同時使用"): null,
                                    )
                                );
                              }
                          )

                      ):Container(),
                      (cartItems[index].product.salesSpecialPriceList.length >0)?
                      Container(
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: cartItems[index].product.salesSpecialPriceList.length,
                              itemBuilder: (BuildContext ct, int i){
                                return Container(
                                        color: Colors.white,
                                        padding: EdgeInsets.all(5),
                                        child: ListTile(
                                          title: Text("購買" + cartItems[index].product.salesSpecialPriceList[i].qty.toString() + "件，只需 \$" + cartItems[index].product.salesSpecialPriceList[i].price.toString()),
                                          trailing: MaterialButton(
                                            child:
                                                (cartItems[index].product.salesSpecialPriceList[i].isSelected)?
                                                Text("已選取", style: TextStyle(color: Colors.white)):
                                                Text("使用優惠", style: TextStyle(color: Colors.white)),
                                            color: (cartItems[index].product.salesSpecialPriceList[i].isSelected)? Colors.lightGreen: Colors.grey,
                                            onPressed: (){
                                              cartItems[index].product.salesSpecialPriceList[i].isSelected = !cartItems[index].product.salesSpecialPriceList[i].isSelected;
                                              if(cartItems[index].product.salesSpecialPriceList[i].isSelected){
                                                int result = cartItems[index].addSalesSpecialPrice(cartItems[index].product.salesSpecialPriceList[i]);
                                                if(result !=  2 ){
                                                  cartItems[index].product.salesSpecialPriceList[i].isSelected = !cartItems[index].product.salesSpecialPriceList[i].isSelected;
                                                  _showDialog(result);

                                                }
                                              }else{
                                                cartItems[index].removeSpecialPrice(cartItems[index].product.salesSpecialPriceList[i]);
                                              }
                                              cartListVM.calTotal();
                                            },
                                          ),
                                          subtitle: (cartItems[index].product.salesSpecialPriceList[i].restrictedOne)?
                                          Text("* 此優惠碼不能與其他優惠同時使用"): null,
                                        )

                                );

                              }
                          )
                      ):Container(),
                    ],
                );
              },
            ),
      bottomNavigationBar: new Container(
        margin: EdgeInsets.all(20),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child:  Text("合共 \$" + cartListVM.total.toString()),
              ),
            Expanded(
              child: new MaterialButton(onPressed: (){
                cartListVM.submitOrder(Provider.of<UserViewModel>(context).userID);
              },
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