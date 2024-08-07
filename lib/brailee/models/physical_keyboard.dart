import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sight_companion/models/models.dart';

class MyPhysicalKeyboard {
  static const List keys = [ LogicalKeyboardKey.keyD , LogicalKeyboardKey.keyS , LogicalKeyboardKey.keyA ,
  LogicalKeyboardKey.keyJ , LogicalKeyboardKey.keyK , LogicalKeyboardKey.keyL ];
  static const List letters = ["D","S","A","J","K","L"];


  static handleKeyEvent(BuildContext context, RawKeyEvent event) {

    /*if ( event is RawKeyDownEvent ) {
    }*/
    if ( event is !RawKeyDownEvent ) {
      return;
    }
    if ( MyPhysicalKeyboard.keys.contains(event.logicalKey) ) {
      Provider.of<InputState>(context,listen: false).changeDot(context,MyPhysicalKeyboard.keys.indexOf(event.logicalKey));
    } else {
      if ( event.logicalKey == LogicalKeyboardKey.space ) {
        submitButtonPress(context);
      }
    }
  }

  static keyboardButtonPressed(BuildContext context){
     FocusScope.of(context).requestFocus(Provider.of<InputState>(context, listen: false).focusNode);
     Provider.of<AppOptionsState>(context, listen: false).keyboardButtonPressed();
   }

}

