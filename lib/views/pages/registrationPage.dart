import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/view_models/userViewModel.dart';
import 'package:http/http.dart' as http;

class RegistrationPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final userVM = Provider.of<UserViewModel>(context);
    final accountFieldController  = TextEditingController();
    final passwordFieldController = TextEditingController();
    final passwordFieldController2 = TextEditingController();

    void _showDialog(bool isValid, String message) {
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

    bool validateInfo (){
      var username = accountFieldController.text;
      var password = passwordFieldController.text;
      var password2 = passwordFieldController2.text;
      print(username.runtimeType);
      print(password.runtimeType);
      print(password2.runtimeType);
      if(accountFieldController.text.length < 6){
        _showDialog(false, "請輸入6位以上的用戶名稱");

        return false;
      }else {
        if(passwordFieldController.text.length < 6 ){
          _showDialog(false, "請輸入6位以上的密碼");
          passwordFieldController.clear();
          passwordFieldController2.clear();

          return false;
        } else {
          if(passwordFieldController.text == passwordFieldController2.text){
            print("OK");
            return true;
          } else {
            _showDialog(false, "密碼認證失敗，請再試一次");
            passwordFieldController.clear();
            passwordFieldController2.clear();
            return false;

          }
        }
      }
    }

    // TODO: implement build
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.lightGreen,
          title: Text('會員註冊'),
          actions: <Widget>[
            new IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: (){}),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(10),
                child: Card(
                    elevation: 5,
                    child: Padding(
                        padding: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
                        child:  Column(
                          children: <Widget> [
                            Padding(
                                child: Image.network("https://www.hungfooktong.com/wp-content/uploads/2018/08/hft_newlogo.png"),
                                padding: EdgeInsets.only(top:20, bottom : 20)

                            ),

                            TextField(
                              controller: accountFieldController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: '請輸入用戶名稱（最少6個字）',
                              ),
                            ),
                            Container(
                                height: 5
                            ),
                            TextField(
                              controller: passwordFieldController,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: '請輸入密碼（最少6個字）',
                              ),
                            ),
                            Container(
                                height: 5
                            ),
                            TextField(
                              controller: passwordFieldController2,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: '請確認密碼',
                              ),
                            ),
                            MaterialButton(
                              color: Colors.lightGreen,
                              onPressed: () async {
                                print(".....");

                                bool clientValidationResult  = validateInfo();
                                if( clientValidationResult){
                                  bool isValid = await Provider.of<UserViewModel>(
                                    context, listen: false).register(
                                    accountFieldController.text, passwordFieldController.text);
                                    print(isValid);
                                    if(isValid){
                                      _showDialog(isValid, "註冊成功");

                                    }else {
                                      _showDialog(isValid, "會員註冊失敗，請再試一次");

                                    }


                                }

//                                bool isValid = await Provider.of<UserViewModel>(
//                                    context, listen: false).login(
//                                    accountFieldController.text, passwordFieldController.text);
//                                print(isValid);
//                                _showDialog(isValid);
                              },
                              child: Text(
                                "註冊",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )

                    )


                )
            )

          ],

        )
    );


  }


}