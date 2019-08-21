import 'package:flutter/material.dart';

class AddCategoryRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddCategoryRouteState();
}

class _AddCategoryRouteState extends State<AddCategoryRoute> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Add category'),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(false)
        ),
      ),
      body: Material(
        child: Container(
          child: Column(
            children: <Widget>[Text('Add')],
          ),
        ),
      ),
    );
  }
}
