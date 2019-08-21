import 'package:flutter/material.dart';
import 'package:flutter_category/models/category_model.dart';

import 'category_item.dart';

class CategoriesRoute extends StatefulWidget{
  final List<CategoryModel> categories;

  const CategoriesRoute({Key key, this.categories}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CategoriesRouteState();
}

class _CategoriesRouteState extends State<CategoriesRoute>{
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.categories.length,
      itemBuilder: (BuildContext ctx, int index) {
        return CategoryItem(
          category: widget.categories[index],
        );
      },
    );
  }

}