import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// figma size
Size designSize = Size(414, 932);

double pH(val, context) {
  return val * MediaQuery.sizeOf(context).height / designSize.height;
}

double pW(val, context) {
  return val * MediaQuery.sizeOf(context).width / designSize.width;
}

void showSnack(context, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Text(message),
    duration: const Duration(seconds: 3),
  ));
}
