import 'package:flutter/material.dart';
import 'package:flutter_category/models/category_model.dart';
import 'package:flutter_category/ui/categories_route.dart';

class MainView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainView> {

  List<CategoryModel> _categories = [
    CategoryModel('app', Icons.ac_unit),
    CategoryModel('test', Icons.account_balance),
    CategoryModel('works', Icons.adjust),
    CategoryModel('world', Icons.add_call),
    CategoryModel('pop', Icons.accessibility),
    CategoryModel('wild', Icons.warning),
    CategoryModel('web', Icons.web),
    CategoryModel('strike', Icons.streetview),
    CategoryModel('golf', Icons.golf_course),
    CategoryModel('state', Icons.place),
    CategoryModel('go', Icons.gps_off),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CategoriesRoute(
          categories: _categories,
        )
      ),
    );
  }
}
