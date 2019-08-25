import 'package:flutter/material.dart';
import 'package:flutter_category/blocs/add_category/add_category_bloc.dart';

class AddCategoryBlocProvider extends InheritedWidget{
  final bloc = AddCategoryBloc();

  AddCategoryBlocProvider({Key key, Widget child}): super(key: key, child: child);

  static AddCategoryBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(AddCategoryBlocProvider) as AddCategoryBlocProvider).bloc;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}