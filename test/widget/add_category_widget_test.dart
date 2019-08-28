import 'package:flutter/material.dart';
import 'package:flutter_category/blocs/add_category/add_category_bloc_provider.dart';
import 'package:flutter_category/ui/add_category/add_category.dart';
import 'package:flutter_test/flutter_test.dart';

import '../widget_test_helper.dart';

void main() {
  testWidgets('AddCategory has a disable save button',
      (WidgetTester tester) async {
    await tester.pumpWidget(WidgetTestHelper.build(AddCategoryBlocProvider(
      child: AddCategory(),
    )));
    final submitButton = find.widgetWithIcon(IconButton,Icons.save);
    final btn = submitButton.evaluate().single.widget as IconButton;
    expect(btn.onPressed, isNull);
  });

   testWidgets('AddCategory has a disable save button has not selected any icon',
      (WidgetTester tester) async {
    await tester.pumpWidget(WidgetTestHelper.build(AddCategoryBlocProvider(
      child: AddCategory(),
    )));
    
    await tester.enterText(find.byType(TextFormField), 'nowytest');

    await tester.pump();
   
    final submitButton = find.widgetWithIcon(IconButton,Icons.save);
    final btn = submitButton.evaluate().single.widget as IconButton;

    expect(btn.onPressed, isNull);
  });

  testWidgets('AddCategory has a disable save button has not input any name',
      (WidgetTester tester) async {
    await tester.pumpWidget(WidgetTestHelper.build(AddCategoryBlocProvider(
      child: AddCategory(),
    )));

    await tester.tap(find.byKey(Key('Dropdown')));
    await tester.pump();
    await tester.tap(find.byKey(Key('Dropdown')));

    await tester.pump();
   
    final submitButton = find.widgetWithIcon(IconButton,Icons.save);
    final btn = submitButton.evaluate().single.widget as IconButton;

    expect(btn.onPressed, isNull);
  });

  testWidgets('AddCategory has a enable save button after data input',
      (WidgetTester tester) async {
    await tester.pumpWidget(WidgetTestHelper.build(AddCategoryBlocProvider(
      child: AddCategory(),
    )));
    
    await tester.enterText(find.byType(TextFormField), 'nowytest');

    await tester.tap(find.byKey(Key('Dropdown')));
    await tester.pump();
    await tester.tap(find.byKey(Key('Dropdown')));

    await tester.pump();
   
    final submitButton = find.widgetWithIcon(IconButton,Icons.save);
    final btn = submitButton.evaluate().single.widget as IconButton;

    expect(btn.onPressed, isNotNull);
  });
}
