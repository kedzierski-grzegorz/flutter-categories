import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreBloc {
  void test() {
    Firestore.instance
        .collection('categories')
        .snapshots()
        .listen((data) => data.documents.forEach((doc) => print(doc['name'])));
  }
}
