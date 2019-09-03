import 'package:flutter/material.dart';
import 'package:flutter_category/blocs/bloc_provider.dart';
import 'package:flutter_category/blocs/categories_bloc.dart';
import 'package:flutter_category/events/back_button_event.dart';
import 'package:flutter_category/events/event_bus_instance.dart';
import 'package:flutter_category/ui/categories_route.dart';

class MainView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainView> {

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _backButtonPress() async {
    EventBusInstance.eventBus.fire(BackButtonEvent());
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _backButtonPress,
      child: Scaffold(
        body: Center(
          child: BlocProvider<CategoriesBloc>(
            builder: (_, bloc) => bloc ?? CategoriesBloc(),
            child: CategoriesRoute(),
          ),
        ),
      ),
    );
  }
}
