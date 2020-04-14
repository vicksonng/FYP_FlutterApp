

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:untitled/models/user.dart';
import 'package:untitled/models/userSession.dart';
import 'package:untitled/app/constant.dart';

class UserViewModel extends ChangeNotifier {
  User user;
  var userID = 1;
  var role = "member";

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
    var body = jsonDecode(response.body);

    print(body.toString());
    print(body['session']);

    if(statusCode == 200){
//      this.userID = int.parse(response.body.userID);
      this.role = UserSession.fromJson(body['session']).role;
      this.userID =  UserSession.fromJson(body['session']).userID;
      this.user = User.fromJson(body['user']);
      print(this.user.storedValue);
      notifyListeners();
//      print(this.session.userID);
      return true;
    }else {
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
    print(body['session']);
    print(UserSession.fromJson(body['session']).role);
//    return false;

//
    if(statusCode == 200){
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
      notifyListeners();
      return false;
    }

  }

  void logout() {
    this.userID = 1;
    this.role = "member";
    notifyListeners();
  }




}
