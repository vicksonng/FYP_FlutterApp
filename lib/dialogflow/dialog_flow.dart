import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:provider/provider.dart';
import 'package:untitled/models/dialogflow_response.dart';
import 'package:untitled/view_models/userViewModel.dart';

import 'facts_message.dart';

class FlutterFactsChatBot extends StatefulWidget {
  FlutterFactsChatBot({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FlutterFactsChatBotState createState() => new _FlutterFactsChatBotState();
}

class _FlutterFactsChatBotState extends State<FlutterFactsChatBot> {
  final List<Facts> messageList = <Facts>[];
  final TextEditingController _textController = new TextEditingController();
//  Function(String) callback;

  callback(String text) {
    print(text);
    _submitQuery(text);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    agentResponse("你好");
  }



  Widget _queryInputWidget(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.only(left:8.0, right: 8),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _submitQuery,
                decoration: InputDecoration.collapsed(hintText: "請輸入查詢內容"),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                  icon: Icon(Icons.send, color: Colors.green[400],),
                  onPressed: () => _submitQuery(_textController.text)),
            ),
          ],
        ),
      ),
    );
  }

  void agentResponse(query) async {
    _textController.clear();
    AuthGoogle authGoogle =
    await AuthGoogle(fileJson: "assets/fyp-sqfwqa-8dc97de3d033.json", sessionId: Provider.of<UserViewModel>(context, listen: false).userID.toString()).build();
    Dialogflow dialogFlow =
    Dialogflow(authGoogle: authGoogle, language: Language.chineseCantonese);
    AIResponse response = await dialogFlow.detectIntent(query);
//    print(json.decode());
    print(response.getMessage());
    print(response.getListMessage());
    var resListMessage = response.getListMessage();
    print(resListMessage);
    for(var i = 0 ; i <  resListMessage.length ; i++) {
      Facts message2 = castMessage(resListMessage[i]);
      print(message2.imgURL);
      print(message2.buttonText.runtimeType);
      setState(() {
        messageList.insert(0, message2);
      });
    }
//    response.getListMessage()
//    var card = CardDialogflow(response.getListMessage()[0]).title;
//    print(card);
//    Facts message = Facts(
//      text: response.getMessage() ??
//          CardDialogflow(response.getListMessage()[0]).title,
//      name: "Flutter",
//      type: false,
//    );
//    setState(() {
//      messageList.insert(0, message);
//    });
  }
  Facts castMessage(resListMessage) {
    if (resListMessage["text"] != null) {
      return new Facts(
          title: "",
          subtitle: "",
          text: resListMessage["text"]["text"][0].toString(),
          name: "小幫手",
          type: false,
          imgURL: "",
          buttonText: "",
          messageType: 0,
          callback: callback
      );
    } else{ // Card
      var card = resListMessage["card"];

      if( card["title"] == "product"){
        return new Facts(
            text: "",
            name: "小幫手",
            type: false,
            title: card["title"],
            subtitle: card["subtitle"],
            imgURL: card["imageUri"],
            buttonText: card["buttons"][0]["text"],
            messageType: 2,
            callback: callback
        );

      }else{
        return new Facts(
            text: "",
            name: "小幫手",
            type: false,
            title: card["title"],
            subtitle: card["subtitle"],
            imgURL: card["imageUri"],
            buttonText: card["buttons"][0]["text"],
            messageType: 1,
            callback: callback
        );

      }

    }
  }

  void _submitQuery(String text) {
    _textController.clear();
    Facts message = new Facts(
      text: text,
      name: "User",
      type: true,
    );
    setState(() {
      messageList.insert(0, message);
    });
    agentResponse(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("鴻福堂小幫手", style: TextStyle(color: Colors.white,)),
        backgroundColor: Colors.lightGreen,
        elevation: 0.1,
      ),
      body: Column(children: <Widget>[
        Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true, //To keep the latest messages at the bottom
              itemBuilder: (_, int index) => messageList[index],
              itemCount: messageList.length,
            )),
        _queryInputWidget(context),
      ]),
    );
  }
}