import 'package:firebase_storage/firebase_storage.dart';

class FireStorageProvider {
  FirebaseStorage _fireStorage = FirebaseStorage.instance;
  List<String> list = ['1', '2', '3'];

  Future<List<dynamic>> getAllImages() async {
    List<dynamic> images = [];

    for (String image in list) {
      await _fireStorage.ref().child(image + '.jpg').getDownloadURL().then((data) {
        images.add(data);
      });
    }

    return images;
  }
}
