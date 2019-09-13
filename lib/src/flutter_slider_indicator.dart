import 'package:flutter/material.dart';

class SliderIndicator extends StatefulWidget {
  SliderIndicator(
      {@required this.length,
      @required this.activeIndex,
      @required this.indicator,
      @required this.activeIndicator,
      this.animationDuration = const Duration(milliseconds: 250)});

  final int length;
  final int activeIndex;
  final Widget indicator;
  final Widget activeIndicator;
  final Duration animationDuration;

  @override
  _SliderIndicatorState createState() => _SliderIndicatorState();
}

class _SliderIndicatorState extends State<SliderIndicator> {
  GlobalKey _indicatorKey = GlobalKey();
  GlobalKey _activeIndicatorKey = GlobalKey();
  Size _indicatorSize = Size.zero;
  Size _activeIndicatorSize = Size.zero;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(_onBuildCompleted);
  }

  _onBuildCompleted(_) {
    final RenderBox indicatorBox =
        _indicatorKey.currentContext.findRenderObject();
    final RenderBox activeIndicatorBox =
        _activeIndicatorKey.currentContext.findRenderObject();
    setState(() {
      _indicatorSize = indicatorBox.size;
      _activeIndicatorSize = activeIndicatorBox.size;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _listBullet = [];

    for (int i = 0; i < widget.length; i++) {
      _listBullet.add(AnimatedOpacity(
        opacity: widget.activeIndex == i ? 0.0 : 1.0,
        duration: widget.animationDuration,
        child: widget.indicator,
      ));
    }

    return Stack(
      children: <Widget>[
        Container(
          key: _indicatorKey,
          child: Opacity(opacity: 0.0, child: widget.indicator),
        ),
        Container(
          key: _activeIndicatorKey,
          child: Opacity(opacity: 0.0, child: widget.activeIndicator),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: _listBullet,
        ),
        AnimatedPositioned(
          left:
              ((_indicatorSize.width / 2) - (_activeIndicatorSize.width / 2)) +
                  _indicatorSize.width * widget.activeIndex,
          top: (_indicatorSize.height / 2) - (_activeIndicatorSize.height / 2),
          duration: widget.animationDuration,
          child: widget.activeIndicator,
        )
      ],
    );
  }
}
