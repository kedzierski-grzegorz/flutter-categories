import 'package:flutter_category/repositories/repoository.dart';
import 'package:test/test.dart';

void main(){
  test('Counter value should be incremented', () async {
    final repository = Repository();

    repository.getAllCategories().listen(expectAsync1((data){
      expect(data.length, greaterThan(0));
    }, count: 3));
  }, skip: true);
}