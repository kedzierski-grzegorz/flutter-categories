import 'dart:async';

import 'package:flutter_category/blocs/bloc_base.dart';
import 'package:flutter_category/repositories/repoository.dart';
import 'package:flutter_category/models/category_model.dart';

class CategoriesBloc extends BlocBase {
  final _repository = Repository();

  Stream<List<CategoryModel>> getAllCategories(){
    return _repository.getAllCategories();
  }

  Future<void> removeCategory(id) => _repository.removeCategory(id);
}