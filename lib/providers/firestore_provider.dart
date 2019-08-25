import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_category/models/category_model.dart';

class FirestoreProvider {
  Firestore _firestore = Firestore.instance;
  final String _categoriesCollectionName = 'categories';

  Stream<List<CategoryModel>> getAllCategories() {
    return _firestore
        .collection(_categoriesCollectionName)
        .snapshots()
        .map<List<CategoryModel>>((data) {
      List<CategoryModel> list = [];
      if (data.documents.length > 0) {
        data.documents.forEach((document) {
          list.add(CategoryModel(
              document.documentID, document['name'], document.data['icon']));
        });
      }

      return list;
    });
  }

  Future<void> addCategory(CategoryModel category) async {
    return _firestore
        .collection(_categoriesCollectionName)
        .add({'name': category.name, 'icon': category.icon});
  }

  Future<void> updateCategory(CategoryModel category) async {
    return _firestore
        .collection(_categoriesCollectionName)
        .document(category.id)
        .setData({'name': category.name, 'icon': category.icon});
  }

  Future<bool> existCategoryWithName(String name) async {
    await _firestore
        .collection(_categoriesCollectionName)
        .where("name", isEqualTo: name)
        .getDocuments()
        .then((data) {
          if(data.documents.length == 0){
            return false;
          } else {
            return true;
          }
        });
  }
}
