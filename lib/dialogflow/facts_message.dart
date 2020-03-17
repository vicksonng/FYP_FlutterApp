import 'package:flutter/material.dart';

class Facts extends StatelessWidget {


  final String text;
  final String name;
  final bool type;
  final String imgURL;
  final String title;
  final String subtitle;
  final String buttonText;
  final int messageType;
//  final String = imgURL;
  Facts({this.text, this.name, this.type, this.imgURL, this.title, this.subtitle,this.buttonText, this.messageType});

  List<Widget> botMessage(context) {
    Widget messageBody;
    Widget buttons;
    if(buttonText == "1"){
      buttons = new Column(
        children: <Widget>[
          FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.red)
            ),
            onPressed:() {},
            child: Text("購買商品")

          ),
          FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.red)
              ),
              onPressed:() {},
              child: Text("取得推薦")

          )
        ],
      );

    }else{
      buttons = new Container();
    }


    if(messageType == 0){ // simple text message
      print("messageType = 0");
      messageBody = Text(text, );

    }else if (messageType == 1){ // card response
      print("messageType = 1");
      messageBody = new Column(
        children: <Widget>[
          Image.network(imgURL),
          Text(title),
          buttons
        ],
      );
    }

    return <Widget>[
      Container(
        margin: const EdgeInsets.only(right: 10.0),
        child: CircleAvatar(child: Padding(
          padding: const EdgeInsets.all(5),
          child: FlutterLogo(),
        ), backgroundColor: Colors.grey[200], radius: 12,),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(this.name,
                style: TextStyle(fontWeight: FontWeight.bold)),
            Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: messageBody,
                  )
                )
              ]
            )
          )
        ];
  }

  List<Widget> botRichMessage(context) {
    return <Widget>[
      Container(
        margin: const EdgeInsets.only(right: 10.0),
        child: CircleAvatar(child: Padding(
          padding: const EdgeInsets.all(5),
          child: FlutterLogo(),
        ), backgroundColor: Colors.grey[200], radius: 12,),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(this.name,
                style: TextStyle(fontWeight: FontWeight.bold)),
            Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(text, ),
                )
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> userMessage(context) {
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
//            Text(this.name, style: Theme.of(context).textTheme.subhead),
            Card(
                color: Colors.green[400],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(text, style: TextStyle(color: Colors.white),),
                )
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(left: 10.0),
        child: CircleAvatar(child: new Text(this.name[0]),backgroundColor: Colors.grey[200], radius: 12,),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? userMessage(context) : botMessage(context),
      ),
    );
  }
}