import 'dart:convert';
import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/models/order.dart';
import 'package:untitled/view_models/userViewModel.dart';
import 'package:untitled/app/constant.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/views/pages/orderListPage.dart';


class UserPage extends StatefulWidget{

  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>{

  TextEditingController _textFieldController = TextEditingController();
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    print("init Page");

  }

//  @override
//  void setState(fn) {
//    // TODO: implement setState
//    super.setState(fn);
//    if(Provider.of<UserViewModel>(context).userID > 1){
//      Provider.of<UserViewModel>(context).fetchUser(Provider.of<UserViewModel>(context).userID);
//    }
//  }

  void _showLogoutDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("登出確認"),
          content: Text("你確認要登出系統嗎？"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("確認"),
              onPressed: () {
                Provider.of<UserViewModel>(context).logout();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                      title: new Text("通知"),
                      content: Text("已從系統登出，歡迎再次光臨鴻福堂，多謝"),
                      actions: <Widget>[
                        // usually buttons at the bottom of the dialog
                        new FlatButton(
                          child: new Text("關閉"),
                          onPressed: () {
                            Navigator.of(context).popUntil((route) => route.isFirst);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            new FlatButton(
              child: new Text("取消"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

  }
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
                  print(">>>>>>>>>>>>>");
                  print("_textFieldController.text: "+_textFieldController.text.toString());
                  print(_textFieldController.text.runtimeType);
                  var result = await Provider.of<UserViewModel>(context, listen: true).addValue(double.parse(_textFieldController.text));
                  print("Add Value: Result" + result.toString());
                  print(">>>>>>>>>>>>>");
                  Navigator.of(context).pop();
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
    final userVM = Provider.of<UserViewModel>(context);
    if(Provider.of<UserViewModel>(context, listen:false).userID > 1){
      Timer.periodic(Duration(seconds: 300), (timer) {
        Provider.of<UserViewModel>(context, listen: false).fetchUser(Provider
            .of<UserViewModel>(context)
            .userID);
        print("Updated user");
      });
    }

    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text('會員中心'),
        actions: <Widget>[
//          new IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: (){}),
        ],
      ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text("你好！ " + userVM.user.username, style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold ),),

            ),
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
                              userVM.user.username
//                              Provider.of<UserViewModel>(context, listen: false).user.username

    )
                      )
                    ],
                  )
                )
            ),
            Card(
              child: Ink(
                child: ListTile(
                  onTap: (){
                    _showDialog();
                  },
                  leading: Icon(Icons.monetization_on),
                  title: Text("餘額增值"),
                  trailing:Text("\$ " + userVM.user.storedValue.toString(), style: TextStyle(
                              color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold,
                            ),)

                    ),

                  ),



              elevation: 5,


            ),
             Card(
               child: Ink(
                   child: ListTile(
                     onTap: () async{
                        List<Order> orderList = await userVM.fetchOrder();
                        print("OKOKOKOK");

                        print(orderList[0]);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => new OrderListPage(orderList)));
                        print("PUSHEDDDDDDD");
                     },
                     leading: Icon(Icons.receipt),
                     title: Text("交易紀錄"),
                   )
               ),
               elevation: 5,


             ),
            Card(
              child: Ink(
                  child: ListTile(
                    onTap: (){
                      _showLogoutDialog();
                    },
                    leading: Icon(Icons.exit_to_app),
                    title: Text("會員登出"),
                  )
              ),
              elevation: 5,


            )



          ],
        )
    );


  }
}

//class TextFieldAlertDialog extends StatelessWidget {
//
//  }
