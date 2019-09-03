import 'package:flutter_category/blocs/bloc_base.dart';
import 'package:flutter_category/models/category_model.dart';
import 'package:flutter_category/repositories/repoository.dart';

class AddCategoryBloc extends BlocBase {
  final _repository = Repository();

  Future<bool> existCategoryWithName(String name) async =>
      await _repository.existCategoryWithName(name);

  Future<void> addCategory(CategoryModel category) => 
      _repository.addCategory(category);
}
