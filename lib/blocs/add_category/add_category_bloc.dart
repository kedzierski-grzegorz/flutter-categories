import 'package:flutter_category/repositories/repoository.dart';

class AddCategoryBloc {
  final _repository = Repository();

  Future<bool> existCategoryWithName(String name) async =>
      await _repository.existCategoryWithName(name);

  
}
