import 'package:flutter_category/blocs/bloc_base.dart';
import 'package:flutter_category/repositories/repoository.dart';

class ImageBloc extends BlocBase{
  final _repository = Repository();

  Future<List<dynamic>> getAllImages() => _repository.getAllImages();
}