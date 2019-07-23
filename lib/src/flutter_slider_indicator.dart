import 'package:flutter/material.dart';

class SliderIndicator extends StatelessWidget {
  SliderIndicator(
      {this.length,
      this.activeIndex,
      this.displayIndicatorSize = 24.0,
      this.displayIndicatorIcon,
      this.displayIndicatorActiveIcon,
      this.displayIndicatorColor,
      this.displayIndicatorActiveColor});

  final int length;
  final int activeIndex;
  final double displayIndicatorSize;
  final IconData displayIndicatorIcon;
  final IconData displayIndicatorActiveIcon;
  final Color displayIndicatorActiveColor;
  final Color displayIndicatorColor;

  @override
  Widget build(BuildContext context) {
    List<Widget> _listBullet = [];

    for (int i = 0; i < length; i++) {
      _listBullet.add(Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(
          displayIndicatorIcon == null
              ? Icons.fiber_manual_record
              : displayIndicatorActiveIcon == null
                  ? displayIndicatorIcon
                  : activeIndex == i
                      ? displayIndicatorActiveIcon
                      : displayIndicatorIcon,
          size: displayIndicatorSize,
          color: activeIndex == i
              ? (displayIndicatorActiveColor == null
                  ? Colors.blueGrey
                  : displayIndicatorActiveColor)
              : (displayIndicatorColor == null
                  ? Colors.black
                  : displayIndicatorColor),
        ),
      ));
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _listBullet,
    );
  }
}
