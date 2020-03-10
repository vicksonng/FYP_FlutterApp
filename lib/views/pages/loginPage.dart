import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/view_models/userViewModel.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final userVM = Provider.of<UserViewModel>(context);
    final accountFieldController  = TextEditingController();
    final passwordFieldController = TextEditingController();

    void _showDialog(bool isValid) {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("通知"),
            content: isValid? new Text("登入成功") : new Text("登入失敗，請再試一次") ,
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("關閉"),
                onPressed: () {
//                  Navigator.of(context).pop();
                  if(isValid) {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  }else {
                    passwordFieldController.clear();
                    Navigator.of(context).pop();
                  }
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
        title: Text('會員登入'),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: (){}),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: accountFieldController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '帳號',
            ),
          ),
          TextField(
            controller: passwordFieldController,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '密碼',
            ),
          ),
          MaterialButton(
            color: Colors.lightGreen,
            onPressed: () async {
              print(".....");
              bool isValid = await Provider.of<UserViewModel>(
                  context, listen: false).login(
                  accountFieldController.text, passwordFieldController.text);
              print(isValid);
              _showDialog(isValid);
            },
            child: Text(
              "登入",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );

  }


}