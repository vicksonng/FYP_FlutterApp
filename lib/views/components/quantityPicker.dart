import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'dart:async';

class QuantityPicker extends StatefulWidget {
  num initQty;
  Function(int) callback;
  QuantityPicker(this.initQty, this.callback);

  @override
//  _QuantityPickerState createState() => new _QuantityPickerState(this.initQty);
  _QuantityPickerState createState() => new _QuantityPickerState();


}

class _QuantityPickerState extends State<QuantityPicker> {
  NumberPicker integerNumberPicker;

  int _itemCount;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _itemCount = widget.initQty;
  }

  _handleValueChanged(num value) {
    if (value != null) {
      //`setState` will notify the framework that the internal state of this object has changed.
        setState(() => _itemCount = value);
        widget.callback(value);
    }
  }

  _handleValueChangedExternally(num value) {
    if (value != null) {
        setState(() => _itemCount = value);
        integerNumberPicker.animateInt(value);
        widget.callback(value);
      }
    }

  Future _showIntegerDialog() async {
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return new NumberPickerDialog.integer(
          minValue: 0,
          maxValue: 100,
          step: 1,
          initialIntegerValue: _itemCount,
        );
      },
    ).then( _handleValueChangedExternally);
  }

  @override
  Widget build(BuildContext context) {
    integerNumberPicker = new NumberPicker.integer(
      initialValue: _itemCount,
      minValue: 0,
      maxValue: 100,
      step: 10,
      onChanged: _handleValueChanged,
    );

    return new Container(
      color: Colors.white,
      child: new Row(
        children: <Widget>[
          Transform.scale(scale: 1,
          child:new  IconButton(
            icon: new Icon(Icons.remove),onPressed: () => setState((){
              _itemCount>0?_itemCount--:_itemCount=_itemCount;
              widget.callback(_itemCount);
            }),
          ),
          ),
//          _itemCount!=0?

         new MaterialButton(
           minWidth: 10,
             child: Text(_itemCount.toString()),
              onPressed: () => _showIntegerDialog(),
         ),

          new IconButton(icon: new Icon(Icons.add),onPressed: ()=>setState((){
            _itemCount++;
            widget.callback(_itemCount);
          }))
        ],
      ),
    );
  }


}
