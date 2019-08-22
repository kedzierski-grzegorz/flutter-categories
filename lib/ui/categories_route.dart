import 'package:flutter/material.dart';
import 'package:flutter_category/blocs/firestore_bloc.dart';
import 'package:flutter_category/models/category_model.dart';
import 'package:flutter_category/ui/add_categories/add_category.dart';
import 'package:flutter_category/ui/backdrop.dart';

import 'category_item.dart';

class CategoriesRoute extends StatefulWidget {
  final FirestoreBloc bloc = FirestoreBloc();
  final List<CategoryModel> categories;

  CategoriesRoute({Key key, this.categories}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CategoriesRouteState();
}

class _CategoriesRouteState extends State<CategoriesRoute> {
  CategoryModel _currentCategory;
  CategoryModel _defaultCategory;

  @override
  void initState() {
    super.initState();
    _defaultCategory = widget.categories[0];
    widget.bloc.test();
  }

  void _onCategoryTap(CategoryModel category) {
    setState(() {
      _currentCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Backdrop(
      currentCategory:
          _currentCategory == null ? _defaultCategory : _currentCategory,
      frontPanel: _currentCategory == null
          ? AddCategory(
              category: _defaultCategory,
            )
          : AddCategory(
              category: _currentCategory,
            ),
      backPanel: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: MediaQuery.of(context).orientation == Orientation.portrait ?
        ListView.builder(
          itemCount: widget.categories.length,
          itemBuilder: (BuildContext ctx, int index) {
            return CategoryItem(
              category: widget.categories[index],
              onTap: _onCategoryTap,
            );
          },
        ) :
        GridView.builder(
          itemCount: widget.categories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 4),
          itemBuilder: (BuildContext ctx, int index){
            return CategoryItem(
              category: widget.categories[index],
              onTap: _onCategoryTap,
            );
          },
        ),
      ),
      frontTitle: Text('Categories'),
      backTitle: Text('Select a Category'),
    );
  }
}
