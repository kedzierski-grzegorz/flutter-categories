import 'package:flutter/widgets.dart';
import 'bloc_base.dart';

Type _getType<B>() => B;

class Provider<B extends BlocBase> extends InheritedWidget {
  final B bloc;

  const Provider({
    Key key,
    this.bloc,
    Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(Provider<B> oldWidget) {
    return oldWidget.bloc != bloc;
  }

  static B of<B extends BlocBase>(BuildContext context) {
    final type = _getType<Provider<B>>();
    final Provider<B> provider = context.inheritFromWidgetOfExactType(type);

    return provider.bloc;
  }
}

class BlocProvider<B extends BlocBase> extends StatefulWidget {
  final B Function(BuildContext context, B bloc) builder;
  final Widget child;

  const BlocProvider({
    Key key,
    @required this.builder,
    @required this.child,
  }) : super(key: key);

  @override
  _BlocProviderState<B> createState() => _BlocProviderState<B>();
}

class _BlocProviderState<B extends BlocBase> extends State<BlocProvider<B>> {
  B bloc;

  @override
  Widget build(BuildContext context) {
    return Provider(
      bloc: bloc,
      child: widget.child,
    );
  }

  @override
  void initState() {
    super.initState();

    if(widget.builder != null){
      bloc = widget.builder(context, bloc);
    }
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
