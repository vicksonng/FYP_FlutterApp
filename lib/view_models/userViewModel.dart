

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:untitled/models/order.dart';
import 'package:untitled/models/orderItem.dart';
import 'package:untitled/models/user.dart';
import 'package:untitled/models/userSession.dart';
import 'package:untitled/app/constant.dart';

class UserViewModel extends ChangeNotifier {
  User user;
  var userID = 1;
  var role = "visitor";
  List<Order> orderList;


  Future<void> fetchUser(int userID) async{
    var url = Constant.fetchUserUrl + userID.toString();
    print(url);
    var response = await http.get(url);
    var statusCode = response.statusCode;

    print(statusCode);
    if(statusCode == 200) {
      var body = jsonDecode(response.body);
      print(body);
      this.user = User.fromJson(body['user']);
      notifyListeners();
    }
  }

  Future<bool> login (String username, String password) async {
//    var url = 'http://localhost:1337/user/loginMobile';
////    var url = 'https://fypsailsjs.herokuapp.com/user/loginMobile';
    var url = Constant.loginUrl;
    print(url);
    Map data = {
      "username" : username,
      "password" : password
    };
    var json = jsonEncode(data);
    var  response = await http.post(
       url,
       headers: {"Content-Type": "application/json"},
       body: json
    );
    // check the status code for the result
    var statusCode = response.statusCode;
    print(statusCode);


//    print(body.toString());
//    print(body['session']);

    if(statusCode == 200){
      var body = jsonDecode(response.body);
      print(body);
      print("statusCode == 200");
//      this.userID = int.parse(response.body.userID);
      this.role = UserSession.fromJson(body['session']).role;
      this.userID =  UserSession.fromJson(body['session']).userID;
      this.user = User.fromJson(body['user']);
      print(this.user.storedValue);
      notifyListeners();
//      print(this.session.userID);
      return true;
    }else {
      print("statusCode != 200");

      notifyListeners();
      return false;
    }

  }

  Future<bool> register (String username, String password) async{
    var url = Constant.registerUrl;
    print(url);
    Map data = {
      "username" : username,
      "password" : password
    };
    var json = jsonEncode(data);
    var  response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json
    );
    print(response);
//    return false;

//     check the status code for the result
    var statusCode = response.statusCode;
    print("StatusCode .......");
    print(statusCode);
    var body = jsonDecode(response.body);
    print(body);
//
//    print(body.toString());
//    print(body['session']);
//    print(UserSession.fromJson(body['session']).role);
//    return false;

//
    if(statusCode == 200){
      print(body['session']);
      print(UserSession.fromJson(body['session']).role);
      print(200);
      this.role = UserSession.fromJson(body['session']).role;
      this.userID =  UserSession.fromJson(body['session']).userID;
      this.user = User.fromJson(body['user']);
//      this.role = UserSession.fromJson(body['session']).role;
//      this.userID =  UserSession.fromJson(body['session']).userID;
//      this.user = User.fromJson(body['user']);
//      print(this.user.storedValue);
//      notifyListeners();
//      print(this.session.userID);
      return true;
    }else {
      print ("There is error");
      notifyListeners();
      return false;
    }

  }

  Future<bool> addValue(double value) async {
    String url = Constant.userAddValueUrl;
//    print("_textFieldController.text: "+_textFieldController.text.toString());
    //reject add value action for  the visitor.
    if(this.userID == 1) {
      return false;
    }
    Map data = {
      "userID" : this.userID,
      "value" : value
    };
    var json = jsonEncode(data);
    var  response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json
    );
    // check the status code for the result
    int statusCode = response.statusCode;
    print(statusCode);
    var body = jsonDecode(response.body);
    print(body.toString());
    if(statusCode == 200){
      print("Added value");
      this.user = User.fromJson(body[0]);
      print(this.user.storedValue);
      notifyListeners();

    }else{
      print("Error value");
      return false;
    }
  }

  void logout() {
    print("LOGOUT");
    this.userID = 1;
    this.role = "visitor";
    notifyListeners();
  }

  Future<bool> addSearchHistory(int productID) async {
    String urlSuffix = "/user/searched";
    String urlPrefix = Constant.getUrlPrefix();
    String url = urlPrefix + urlSuffix;
    print(url);
    print(productID);
    Map data = {
      "userID" : this.userID,
      "productID" : productID,
    };
    var json = jsonEncode(data);
    var  response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json
    );
    // check the status code for the result
    int statusCode = response.statusCode;
    print(statusCode);
    var body = jsonDecode(response.body);
    print(body);
    if(statusCode == 200){
      return true;
    }else {
      return false;
    }
  }

  Future<List<Order>> fetchOrder() async{


    var url = Constant.fetchOrderUrl+this.userID.toString();
    print(url);
    var response = await http.get(url);
    var statusCode = response.statusCode;

    print(statusCode);
    if(statusCode == 200){
      List<Order> orderList = [];
      var body = jsonDecode(response.body);
      for(int i = 0 ; i < body.length ; i ++) {
        List<OrderItem> orderItems = [];
        for(int j = 0 ; j < body[i]["orderItems"].length ; j ++){
          var rawItem = body[i]["orderItems"][j];
          OrderItem tempItem = new OrderItem(rawItem['productName'], rawItem['qty'], rawItem['subTotal']);
          orderItems.add(tempItem);
        }
        Order order = new Order(body[i]['order']['id'], body[i]['order']['price'], orderItems, body[i]['order']['createdAt'].split("T")[0]);
        orderList.add(order);
        print("ID = " + order.id.toString());

        print(order.toString());
        if(i == body.length -1){

          print("Fetched order!!!!!!");
          return orderList;
        }
      }
    }else {
      return [];
    }
  }








}
