import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_category/models/category_model.dart';
import 'package:flutter_category/models/my_icons.dart';

class FirestoreProvider {
  Firestore _firestore = Firestore.instance;

  Stream<List<CategoryModel>> getAllCategories() {
    return _firestore
        .collection('categories')
        .getDocuments()
        .asStream()
        .map<List<CategoryModel>>((data) {
      List<CategoryModel> list = [];
      if (data.documents.length > 0) {
        data.documents.forEach((document) {
          list.add(CategoryModel(document.documentID,document['name'], MyIcons.icons[document.data['icon']]));
        });
      }

      return list;
    });
  }
}
