import 'package:flutter/material.dart';
import 'package:flutter_category/blocs/bloc_provider.dart';
import 'package:flutter_category/blocs/categories_bloc.dart';
import 'package:flutter_category/blocs/edit_categories/edit_category_bloc.dart';
import 'package:flutter_category/events/category_edited_event.dart';
import 'package:flutter_category/events/event_bus_instance.dart';
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
    _bloc = Provider.of<CategoriesBloc>(context);
    _bloc.getAllCategories().listen((data) => setState(() {
          _categories = data;
          _defaultCategory = data[0];
        }));
  }

  @override
  void initState() {
    super.initState();
    _defaultCategory = CategoryModel('', 'Test', 'chat');
  }

  Future _showDialogRemove(BuildContext context, CategoryModel category) async {
    return showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          content: Text('Are you sure to remove ${category.name}'),
          title: Text('Confirm'),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
            FlatButton(
              child: Text('Yes'),
              onPressed: () async{
                await _removeCategory(category.id);
                Navigator.of(ctx).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future _removeCategory(String id) async{
    _bloc.removeCategory(id).then((data) {
      print('Deleted');
    });
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
      frontPanel: BlocProvider<EditCategoryBloc>(
        builder: (_, bloc) => bloc ?? EditCategoryBloc(),
        child: _currentCategory == null
            ? EditCategory(
                category: _defaultCategory,
              )
            : EditCategory(
                category: _currentCategory,
              ),
      ),
      backPanel: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: _categories.length > 0
            ? MediaQuery.of(context).orientation == Orientation.portrait
                ? ListView.builder(
                    itemCount: _categories.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return Dismissible(
                        key: Key(_categories[index].id),
                        child: CategoryItem(
                          category: _categories[index],
                          onTap: _onCategoryTap,
                        ),
                        onDismissed: (direction) {
                          _showDialogRemove(context,_categories[index]);
                        },
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
