import 'dart:convert';

class Dialogflow_response{
  var messageList2 = [];
  List<TextMessage> textMessageList = [];
  List<RichResponse> richResponseList = [];
  List<Suggestion> suggestionList = [];

  Dialogflow_response(this.textMessageList,this.richResponseList, this.suggestionList);

  static Dialogflow_response castResponseMessage (List<dynamic> resListMessage){
    Dialogflow_response messageList;
    List<TextMessage> textMessageList = [];
    List<RichResponse> richResponseList = [];
    List<Suggestion> suggestionList = [];
    if(resListMessage.length > 0){
      for(var i = 0 ; i < resListMessage.length ; i++) {
        if(resListMessage[i]["text"] != null){
          textMessageList.add(new TextMessage(resListMessage[i]["text"]["text"].toString()));
//          messageList2.add(new TextMessage(resListMessage[i]["text"]["text"].toString()));
          print("1");
        }else if(resListMessage[i]["quickReplies"] != null){
          for(var j = 0 ; j < resListMessage[i]["quickReplies"]["quickReplies"].length; j++){
            suggestionList.add(new Suggestion(resListMessage[i]["quickReplies"]["quickReplies"][j].toString()));
          }
          print("2");
          print(resListMessage[i]["quickReplies"]["quickReplies"]);
        }else if(resListMessage[i]["card"] != null){
          print(resListMessage[i]["card"]["title"]);
          print(resListMessage[i]["card"]["buttons"][0]["text"]);
          String title;
          String subTitle;
          String imgURL;
          String buttonText;
          String buttonURL;
          var card = resListMessage[i]["card"];
          title = card["title"];
          subTitle = card["subTitle"];
          imgURL = card["imageUri"];
          buttonText = card["buttons"][0]["text"];
          buttonURL = card["buttons"][0]["postback"];
          richResponseList.add(new RichResponse(title, subTitle, imgURL, buttonText, buttonURL));
          print("3");

        }
      }
    }
    messageList = new Dialogflow_response(textMessageList, richResponseList, suggestionList);

    return messageList;

  }


}

class TextMessage{
  final String message;

  TextMessage(this.message);

}

class RichResponse {
  final String title;
  final String subTitle;
  final String imgURL;
  final String buttonText;
  final String buttonURL;

  RichResponse(this.title, this.subTitle, this.imgURL, this.buttonText, this.buttonURL);
}

class Suggestion {
  final String suggestionText;

  Suggestion(this.suggestionText);
}