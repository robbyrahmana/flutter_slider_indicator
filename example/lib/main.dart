import 'package:flutter/material.dart';
import 'package:flutter_slider_indicator/flutter_slider_indicator.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}):super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Flutter Slider Indicator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Slider Indicator'),
    );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = PageController();
  double _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    _controller.addListener(() {
      setState(() {
        _currentIndex = _controller.page;
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView(
              controller: _controller,
              children: const <Widget>[
                Center(child: Text('First Page')),
                Center(child: Text('Second Page')),
                Center(child: Text('Third Page')),
              ],
            ),
          ),
          SliderIndicator(
            length: 3,
            activeIndex: _currentIndex.round(),
            indicator: const Icon(
              Icons.ac_unit,
              size: 50,
            ),
            activeIndicator: const Icon(Icons.access_alarms),
          )
        ],
      ),
    );
  }
}
