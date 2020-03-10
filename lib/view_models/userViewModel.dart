

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:untitled/models/userSession.dart';

class UserViewModel extends ChangeNotifier {
  UserSession session;



  Future<bool> login (String userID, String password) async {
    var url = 'http://localhost:1337/user/loginMobile';
    print(url);
//    var response = await http.get(url);
//    print(jsonDecode(response.body));
//    Map<String, String> headers = {"Content-type": "application/json"};
    Map data = {
      "account" : userID,
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


    print(body);
    if(statusCode == 200){
      this.session =  UserSession.fromJson(body);
      print(this.session.userID);
      return true;
    }else {
      return false;
    }
  }

  void logout() {
    this.session = null;
  }




}