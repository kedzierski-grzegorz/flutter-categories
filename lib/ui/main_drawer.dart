import 'package:flutter/material.dart';
import 'package:flutter_category/blocs/bloc_provider.dart';
import 'package:flutter_category/blocs/image_route/image_bloc.dart';
import 'package:flutter_category/ui/route_animations/drawer_route.dart';

import 'images_route/image_route.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Menu'),
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          ),
          ListTile(
            title: Text('Main'),
            onTap: () {
              Navigator.of(context).pop();
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            },
          ),
          ListTile(
            title: Text('Images'),
            onTap: () {
              Navigator.of(context).pop();
              if (context.ancestorWidgetOfExactType(ImageRoute) == null) {
                Navigator.of(context).push(
                  DrawerRoute(
                    route: BlocProvider<ImageBloc>(
                      builder: (_, bloc) => bloc ?? ImageBloc(),
                      child: ImageRoute(),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
