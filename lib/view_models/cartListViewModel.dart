import 'package:flutter/cupertino.dart';
import 'package:untitled/models/cartItem.dart';

class CartListViewModel extends ChangeNotifier {

  List<CartItem> cartList = [];

  double subTotal = 0;

  void addItem(CartItem cartItem) {
    //Check duplicated product
    int index = isItemExist(cartItem.product.id);
    if(index != -1){
      cartList[index].qty += cartItem.qty;
    } else {
      cartList.add(cartItem);
    }
    calTotal();
    notifyListeners();
  }

  int isItemExist(int id) {
    for(int i = 0 ; i < cartList.length ; i ++) {
      if(id == cartList[i].product.id) {
        return i;
      }
    }
    return -1;
  }

  void removeItem(int productID) {
    for(int  i = 0 ; i < cartList.length ; i++) {
      if(productID == cartList[i].product.id) {
        print("Can find delete item");
        cartList.removeAt(i);
        print(cartList.length);
        break;
      }
    }
    calTotal();
    notifyListeners();
  }

  void setQty(int index, int qty) {
    cartList[index].qty = qty;
    calTotal();
    notifyListeners();
  }

  void clearCart() {
    cartList = [];
    subTotal = 0;
    notifyListeners();
  }

  void calTotal(){
    subTotal = 0;
    if(cartList.length > 0 ){
      for(int i = 0 ; i < cartList.length ; i++) {
        subTotal += (cartList[i].product.price * cartList[i].qty);
      }
    }
  }

}