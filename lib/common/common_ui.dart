import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_fish_fly/utils/color_utils.dart';

class CommonUi {
  static paddingUtils(Widget widget, double left, double top, double right,
      double bottom) {
    return Padding(
        child: widget, padding: EdgeInsets.fromLTRB(left, top, right, bottom));
  }

  static textFieldUtils(String text, TextEditingController controller,
      {double paddingLeft = 0, double paddingTop = 0, double paddingRight = 0, double paddingBottom = 0}) {
    return TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(
              paddingLeft, paddingTop, paddingRight, paddingBottom),
          labelText: text,
          border: InputBorder.none,
        ),
        obscureText: true);
  }

  static orangeContainer({Widget child}) {
    return Container(
      decoration: new BoxDecoration(
        color: ColorUtils.appWhiteColor,
        boxShadow: [
          BoxShadow(color: ColorUtils.gradientEnd14Color,
            offset: Offset(2.0, 2.0),
            blurRadius: 2.0,
            spreadRadius: 1.0),
        ],
      ),
      child:child,);
  }
}
