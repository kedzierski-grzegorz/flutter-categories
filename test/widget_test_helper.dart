import 'package:flutter/material.dart';

class WidgetTestHelper {
  static Widget build(Widget widget) {
    // https://docs.flutter.io/flutter/widgets/MediaQuery-class.html
    return new MediaQuery(
      data: new MediaQueryData(),
      child: new MaterialApp(home: widget),
    );
  }
}
