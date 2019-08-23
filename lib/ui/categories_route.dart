import 'package:flutter/material.dart';
import 'package:flutter_category/blocs/categories_bloc.dart';
import 'package:flutter_category/blocs/categories_bloc_provider.dart';
import 'package:flutter_category/models/category_model.dart';
import 'package:flutter_category/ui/edit_categories/edit_category.dart';
import 'package:flutter_category/ui/backdrop.dart';

import 'category_item.dart';

class CategoriesRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CategoriesRouteState();
}

class _CategoriesRouteState extends State<CategoriesRoute> {
  CategoryModel _currentCategory;
  CategoryModel _defaultCategory;
  CategoriesBloc _bloc;

  List<CategoryModel> _categories = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = CategoriesBlocProvider.of(context);
    _bloc.getAllCategories().listen((data) => setState(() {
          _categories = data;
          _defaultCategory = data[0];
        }));
  }

  @override
  void initState() {
    super.initState();
    _defaultCategory = CategoryModel('', 'Test', Icons.chat);
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
          ? EditCategory(
              category: _defaultCategory,
            )
          : EditCategory(
              category: _currentCategory,
            ),
      backPanel: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: _categories.length > 0
            ? MediaQuery.of(context).orientation == Orientation.portrait
                ? ListView.builder(
                    itemCount: _categories.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return CategoryItem(
                        category: _categories[index],
                        onTap: _onCategoryTap,
                      );
                    },
                  )
                : GridView.builder(
                    itemCount: _categories.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 4),
                    itemBuilder: (BuildContext ctx, int index) {
                      return CategoryItem(
                        category: _categories[index],
                        onTap: _onCategoryTap,
                      );
                    },
                  )
            : Text('Loading'),
      ),
      frontTitle: Text('Categories'),
      backTitle: Text('Select a Category'),
    );
  }
}
