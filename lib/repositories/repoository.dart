import 'package:flutter_category/models/category_model.dart';
import 'package:flutter_category/providers/firestore_provider.dart';

class Repository{
  final _firestoreProvider = FirestoreProvider();

  Stream<List<CategoryModel>> getAllCategories() => _firestoreProvider.getAllCategories();
}