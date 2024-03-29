import 'package:flutter_category/models/category_model.dart';
import 'package:flutter_category/providers/fire_storage_provider.dart';
import 'package:flutter_category/providers/firestore_provider.dart';

class Repository{
  final _firestoreProvider = FirestoreProvider();
  final _fireStorageProvider = FireStorageProvider();

  Stream<List<CategoryModel>> getAllCategories() => _firestoreProvider.getAllCategories();
  Future<void> addCategory(CategoryModel category) => _firestoreProvider.addCategory(category);
  Future<void> updateCategory(CategoryModel category) => _firestoreProvider.updateCategory(category);
  Future<bool> existCategoryWithName(String name) async => await _firestoreProvider.existCategoryWithName(name);
  Future<void> removeCategory(String id) => _firestoreProvider.removeCategory(id);

  Future<List<dynamic>> getAllImages() => _fireStorageProvider.getAllImages();
}