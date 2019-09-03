import 'package:flutter_category/blocs/bloc_base.dart';
import 'package:flutter_category/models/category_model.dart';
import 'package:flutter_category/repositories/repoository.dart';

class EditCategoryBloc extends BlocBase{
  final repository = Repository();

  Future<void> updateCategory(CategoryModel category) => repository.updateCategory(category);
}