import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//
class WelcomeMessage extends StatelessWidget{
  Function(String) callback;

  WelcomeMessage(this.callback);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: <Widget>[
//        Image.network("https://www.hungfooktong.com/wp-content/uploads/2018/08/hft_newlogo.png"),
        Image.asset("image/p1.jpg"),
        Text("歡迎光臨鴻福堂，請問有什麼可以幫到你？\n請選擇服務："),
        new Column(
          children: <Widget>[
            FlatButton(
                color: Colors.lightGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
//                  side: BorderSide(color: Colors.red)
                ),
                onPressed:() {
                  this.callback("購買商品");
                },
                child: Text("購買商品", style: TextStyle(color: Colors.white),)

            ),
            FlatButton(
                color: Colors.lightGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
//                  side: BorderSide(color: Colors.red)
                ),
                onPressed:() {
                  this.callback("請問有什麼推薦？");
                },
                child: Text("取得推薦", style: TextStyle(color: Colors.white))
            )
          ],
        )
      ],
    );;
  }
}
