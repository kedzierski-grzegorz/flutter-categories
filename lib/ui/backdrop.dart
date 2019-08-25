import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_category/blocs/add_category/add_category_bloc_provider.dart';
import 'package:flutter_category/events/back_button_event.dart';
import 'package:flutter_category/events/event_bus_instance.dart';
import 'package:flutter_category/models/category_model.dart';
import 'dart:math';

import 'package:flutter_category/ui/add_category/add_category.dart';

const double _kFlingVelocity = 2.0;

class Backdrop extends StatefulWidget {
  final CategoryModel currentCategory;
  final Widget frontPanel;
  final Widget backPanel;
  final Widget frontTitle;
  final Widget backTitle;

  const Backdrop(
      {Key key,
      this.currentCategory,
      this.frontPanel,
      this.backPanel,
      this.frontTitle,
      this.backTitle})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop>
    with SingleTickerProviderStateMixin {
  final GlobalKey _backdropkKey = GlobalKey(debugLabel: 'Backdrop');
  AnimationController _controller;
  StreamSubscription _backButtonEvent;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(microseconds: 300),
      value: 1.0,
      vsync: this,
    );

    _backButtonEvent =
        EventBusInstance.eventBus.on<BackButtonEvent>().listen((onData) {
      _hideBackdropPanel();
    });
  }

  @override
  void didUpdateWidget(Backdrop oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.currentCategory != oldWidget.currentCategory) {
      setState(() {
        _controller.fling(
            velocity:
                _backdropPanelVisible ? -_kFlingVelocity : _kFlingVelocity);
      });
    } else if (!_backdropPanelVisible) {
      setState(() {
        _controller.fling(velocity: _kFlingVelocity);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _backButtonEvent.cancel();
    super.dispose();
  }

  bool get _backdropPanelVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toogleBackdropPanelVisibility() {
    FocusScope.of(context).requestFocus(FocusNode());
    _controller.fling(
        velocity: _backdropPanelVisible ? -_kFlingVelocity : _kFlingVelocity);
  }

  void _hideBackdropPanel() {
    FocusScope.of(context).requestFocus(FocusNode());
    _controller.fling(velocity: -_kFlingVelocity);
  }

  double get _backdropHeight {
    final RenderBox renderBox = _backdropkKey.currentContext.findRenderObject();
    return renderBox.size.height;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_controller.isAnimating) return;
    _controller.value -= details.primaryDelta / _backdropHeight;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed) return;

    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / _backdropHeight;

    if (flingVelocity < 0.0)
      _controller.fling(velocity: max(_kFlingVelocity, -flingVelocity));
    else if (flingVelocity > 0.0)
      _controller.fling(velocity: max(-_kFlingVelocity, -flingVelocity));
    else
      _controller.fling(
          velocity:
              _controller.value < 0.5 ? -_kFlingVelocity : _kFlingVelocity);
  }

  Widget _buildStack(BuildContext ctx, BoxConstraints constraints) {
    const double panelTitleHeight = 50.0;
    final Size panelSize = constraints.biggest;
    final double panelTop = panelSize.height - panelTitleHeight;

    Animation<RelativeRect> panelAnimation = RelativeRectTween(
            begin: RelativeRect.fromLTRB(
                0.0, panelTop, 0.0, panelTop - panelSize.height),
            end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0))
        .animate(_controller);

    return Container(
      key: _backdropkKey,
      color: Colors.white70,
      child: Stack(
        children: <Widget>[
          widget.backPanel,
          PositionedTransition(
            rect: panelAnimation,
            child: _BackdropPanel(
              onTap: _toogleBackdropPanelVisibility,
              onVerticalDragUpdate: _handleDragUpdate,
              onVertibalDragEnd: _handleDragEnd,
              title: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text(
                  widget.currentCategory.name,
                  style: TextStyle(
                      fontSize: 26.0, color: Theme.of(context).primaryColor),
                ),
              ),
              child: widget.frontPanel,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddCategoryBlocProvider(
                        child: AddCategory(),
                      )));
            },
          )
        ],
        elevation: 0.0,
        leading: IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.close_menu,
            progress: _controller.view,
          ),
          onPressed: _toogleBackdropPanelVisibility,
        ),
        title: _BackdropTitle(
          listenable: _controller.view,
          frontTitle: widget.frontTitle,
          backTitle: widget.backTitle,
        ),
      ),
      body: LayoutBuilder(
        builder: _buildStack,
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}

class _BackdropTitle extends AnimatedWidget {
  final Widget frontTitle;
  final Widget backTitle;

  const _BackdropTitle(
      {Key key, Listenable listenable, this.frontTitle, this.backTitle})
      : super(key: key, listenable: listenable);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = this.listenable;
    return DefaultTextStyle(
      style: Theme.of(context).primaryTextTheme.title,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      child: Stack(
        children: <Widget>[
          Opacity(
            opacity: CurvedAnimation(
              parent: ReverseAnimation(animation),
              curve: Interval(0.5, 1.0),
            ).value,
            child: backTitle,
          ),
          Opacity(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Interval(0.5, 1.0),
            ).value,
            child: frontTitle,
          ),
        ],
      ),
    );
  }
}

class _BackdropPanel extends StatelessWidget {
  final VoidCallback onTap;
  final GestureDragUpdateCallback onVerticalDragUpdate;
  final GestureDragEndCallback onVertibalDragEnd;
  final Widget title;
  final Widget child;

  const _BackdropPanel(
      {Key key,
      this.onTap,
      this.onVerticalDragUpdate,
      this.onVertibalDragEnd,
      this.title,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xfff4f4fe),
      elevation: 12.0,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onVerticalDragUpdate: onVerticalDragUpdate,
            onVerticalDragEnd: onVertibalDragEnd,
            onTap: onTap,
            child: Container(
              height: 48.0,
              padding: EdgeInsets.only(top: 5.0),
              alignment: AlignmentDirectional.center,
              child: DefaultTextStyle(
                child: title,
                style: Theme.of(context).textTheme.subhead,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Divider(
            height: 1.0,
          ),
          Expanded(
            child: child,
          )
        ],
      ),
    );
  }
}
