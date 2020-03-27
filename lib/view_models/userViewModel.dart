

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:untitled/models/userSession.dart';

class UserViewModel extends ChangeNotifier {
//  static var json = '{"userID": 0, "role":"member}';
//  static Map<String, dynamic> map = jsonDecode(json);
//  UserSession session = new UserSession({
//    "userID": 0,
//    "role": "member"
//  });
  var userID = 1;
  var role = "member";



  Future<bool> login (String username, String password) async {
    var url = 'http://localhost:1337/user/loginMobile';
//    var url = 'https://fypsailsjs.herokuapp.com/user/loginMobile';
    print(url);
//    var response = await http.get(url);
//    print(jsonDecode(response.body));
//    Map<String, String> headers = {"Content-type": "application/json"};
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
//    var body2 = jsonEncode(body);
//    var body3 = response.body;
//
//
//    print(body);
//    print(body2);
//    print(body3);
//    print(body.userID);
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
