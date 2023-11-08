import 'package:flutter/material.dart';

abstract class CustomSizedBox {
  static Widget sizedBoxHeight(double height){
    return SizedBox(height: height,);
  }
}