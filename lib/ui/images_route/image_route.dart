import 'package:flutter/material.dart';
import 'package:flutter_category/ui/main_drawer.dart';

class ImageRoute extends StatefulWidget {
  @override
  _ImageRouteState createState() => _ImageRouteState();
}

class _ImageRouteState extends State<ImageRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      body: Container(
        child: Text('Image route'),
      ),
    );
  }
}
