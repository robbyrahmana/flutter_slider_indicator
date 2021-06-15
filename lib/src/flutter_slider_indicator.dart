import 'package:flutter/material.dart';

/// Slider indicator widget's class
class SliderIndicator extends StatefulWidget {
  /// Animated indicator for sliders / carousels
  ///
  /// Required parameters:
  ///
  /// length - Double precise number that expressing widget's length
  ///
  /// activeIndex - Integer number that representing the current slide
  ///
  /// indicator - Widget that representing inactive slides indicators
  ///
  /// activeIndicator - Widget that representing current slide indicator
  ///
  /// Optional parameters:
  ///
  /// animationDuration - Duration of animation (default: 250ms)
  const SliderIndicator(
      {Key? key,
      required this.length,
      required this.activeIndex,
      required this.indicator,
      required this.activeIndicator,
      this.animationDuration = const Duration(milliseconds: 250)})
      : super(key: key);

  /// Widget's length
  final int length;

  /// Current slide
  final int activeIndex;

  /// Widget that representing inactive slides indicators
  final Widget indicator;

  /// Widget that representing current slide indicator
  final Widget activeIndicator;

  /// Duration of animation
  final Duration animationDuration;

  @override
  _SliderIndicatorState createState() => _SliderIndicatorState();
}

class _SliderIndicatorState extends State<SliderIndicator> {
  final GlobalKey _indicatorKey = GlobalKey();
  final GlobalKey _activeIndicatorKey = GlobalKey();
  Size _indicatorSize = Size.zero;
  Size _activeIndicatorSize = Size.zero;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback(_onBuildCompleted);
  }

  void _onBuildCompleted(_) {
    final indicatorBox =
        _indicatorKey.currentContext!.findRenderObject() as RenderBox?;
    final activeIndicatorBox =
        _activeIndicatorKey.currentContext!.findRenderObject() as RenderBox?;
    setState(() {
      _indicatorSize = indicatorBox!.size;
      _activeIndicatorSize = activeIndicatorBox!.size;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _listBullet = <Widget>[];

    for (var i = 0; i < widget.length; i++) {
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
          child: Opacity(opacity: 0, child: widget.indicator),
        ),
        Container(
          key: _activeIndicatorKey,
          child: Opacity(opacity: 0, child: widget.activeIndicator),
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
