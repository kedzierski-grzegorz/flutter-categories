import 'package:flutter/material.dart';
import 'package:flutter_category/blocs/edit_categories/edit_category_bloc.dart';

class EditCategoryBlocProvider extends InheritedWidget{
  final bloc = EditCategoryBloc();

  EditCategoryBlocProvider({Key key, Widget child}): super(key: key, child: child);

  static EditCategoryBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(EditCategoryBlocProvider) as EditCategoryBlocProvider).bloc;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}