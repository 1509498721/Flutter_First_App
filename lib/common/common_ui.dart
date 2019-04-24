import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonUi {
  static paddingUtils(
      Widget widget, double left, double top, double right, double bottom) {
    return Padding(
        child: widget, padding: EdgeInsets.fromLTRB(left, top, right, bottom));
  }

  static textFieldUtils(String text,TextEditingController controller,
      {double paddingLeft=0,double paddingTop=0,double paddingRight=0,double paddingBottom=0}) {
    return TextField(
        controller:controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(paddingLeft, paddingTop, paddingRight, paddingBottom),
          labelText: text,
          border: InputBorder.none,
        ),
        obscureText: true);
  }
}
