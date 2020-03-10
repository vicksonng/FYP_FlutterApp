import 'package:flutter/material.dart';

class NumberInputField extends StatefulWidget {

  final String title = "TextField Demo";

  @override
  _NumberInputFieldState createState() => _NumberInputFieldState();

}

class _NumberInputFieldState extends State<NumberInputField> {

  final myController = TextEditingController();

  textListener() {
    print("Current Text is ${myController.text}");
  }

  @override
  void dispose() {
    super.dispose();
    myController.dispose();
  }

  @override
  void initState() {
    super.initState();
    myController.addListener(textListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              controller: myController,
              onChanged: (text) {
                print("Text $text");
              },
            ),
            TextField(

            )
          ],
        ),
      ),
    );
  }

}
