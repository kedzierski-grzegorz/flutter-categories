import 'package:flutter/material.dart';
import 'package:flutter_category/blocs/categories_bloc_provider.dart';
import 'package:flutter_category/ui/categories_route.dart';
import 'package:event_bus';

class MainView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainView> {

  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('dziala');
      },
      child: Scaffold(
        body: Center(
          child: CategoriesBlocProvider(
            child: CategoriesRoute(),
          ),
        ),
      ),
    );
  }
}
