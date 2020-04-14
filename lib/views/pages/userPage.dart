import 'dart:convert';
import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/view_models/userViewModel.dart';
import 'package:untitled/app/constant.dart';
import 'package:http/http.dart' as http;

class UserPage extends StatefulWidget{
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>{
  TextEditingController _textFieldController = TextEditingController();

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("請輸入增值金額"),
          content: TextField(
              controller: _textFieldController,
              keyboardType: TextInputType.number,
//              decoration: InputDecoration(hintText: ""),
            ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
        new FlatButton(
                child: new Text('確定'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  String url = Constant.userAddValueUrl;
                  print("_textFieldController.text: "+_textFieldController.text.toString());
                  Map data = {
                    "userID" : Provider.of<UserViewModel>(context, listen: false).userID,
                    "value" : _textFieldController.text
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
                },
              ),
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

//  _displayDialog(BuildContext context) async {
//    return showDialog(
//        context: context,
//        builder: (context) {
//          return AlertDialog(
//            title: Text('請輸入增值金額'),
//            content: TextField(
//              controller: _textFieldController,
//              keyboardType: TextInputType.number,
////              decoration: InputDecoration(hintText: ""),
//            ),
//            actions: <Widget>[
//              new FlatButton(
//                child: new Text('取消'),
//                onPressed: () {
//                  Navigator.of(context).pop();
//                },
//              ),
//              new FlatButton(
//                child: new Text('確定'),
//                onPressed: () {
//                  Navigator.of(context).pop();
//                  String url = Constant.userAddValueUrl;
//                  print("_textFieldController.text: "+_textFieldController.text.toString());
//                  Map data = {
//                    "userID" : Provider.of<UserViewModel>(context, listen: false).userID,
//                    "value" : _textFieldController.text
//                  };
////                  var json = jsonEncode(data);
////                  var  response = await http.post(
////                      url,
////                      headers: {"Content-Type": "application/json"},
////                      body: json
////                  );
////                  // check the status code for the result
////                  int statusCode = response.statusCode;
////                  print(statusCode);
////                  var body = jsonDecode(response.body);
//                },
//              )
//            ],
//          );
//        });
//  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text('會員中心'),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: (){}),
        ],
      ),
        body: ListView(
          children: <Widget>[
            Container(
                height: 150,
                child: Center(
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Container(
                            child: Image.asset("image/memberIcon.png"),
                            height: 80,
                          ),
                        ),
                      ),
                      Center(
                          child: Text(
                              Provider.of<UserViewModel>(context, listen: false).user.username
                          )
                      )
                    ],
                  )
                )
//                Container(
//                  padding: EdgeInsets.only(top:10),
//                  child:  Center(
//                      child: ListView(
//                        children: <Widget>[
//                          Container(
//                            child: Image.asset("image/memberIcon.png"),
//                            height: 80,
//                          ),
//                          Container(
//                              child: Center(
//                                  child:
//                              )
//                          )
//                        ],
//                      )
//
//                  )
//                )
            ),
            Ink(
              child: ListTile(
                onTap: (){
                  _showDialog();
                },
                leading: Icon(Icons.monetization_on),
                title: Text("餘額增值"),
                trailing: Text("\$ " + Provider.of<UserViewModel>(context, listen: false).user.storedValue.toString()),
              ),
            ),
             Ink(
               child: ListTile(
                 onTap: (){},
                 leading: Icon(Icons.receipt),
                 title: Text("交易紀錄"),
               )
             )



          ],
        )
    );


  }
}

//class TextFieldAlertDialog extends StatelessWidget {
//
//  }
