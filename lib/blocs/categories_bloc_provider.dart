import 'package:flutter/material.dart';
import 'package:flutter_category/blocs/categories_bloc.dart';

class CategoriesBlocProvider extends InheritedWidget {
  final bloc = CategoriesBloc();

  CategoriesBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  static CategoriesBloc of(BuildContext context) {
    var provider = (context.inheritFromWidgetOfExactType(CategoriesBlocProvider) as CategoriesBlocProvider);
    return provider.bloc;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}