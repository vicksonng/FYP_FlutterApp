

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:untitled/models/userSession.dart';
import 'package:untitled/app/constant.dart';

class UserViewModel extends ChangeNotifier {
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
    int statusCode = response.statusCode;
    print(statusCode);
    var body = jsonDecode(response.body);

    if(statusCode == 200){
//      this.userID = int.parse(response.body.userID);
      this.role = UserSession.fromJson(body).role;
      this.userID =  UserSession.fromJson(body).userID;
//      print(this.session.userID);
      return true;
    }else {
      return false;
    }
  }

  void logout() {
    this.userID = 1;
    this.role = "member";
  }




}
