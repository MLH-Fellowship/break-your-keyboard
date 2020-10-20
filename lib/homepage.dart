import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FocusNode focusNode = FocusNode();
  int _counter = 0;
  bool _hasPressedSpaceDown = false;
  bool _hasPressedOtherKeyDown = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _toggleHasPressedSpaceDown() {
    setState(() {
      _hasPressedSpaceDown = !_hasPressedSpaceDown;
    });
  }

  void _toggleHasPressedOtherKeyDown() {
    setState(() {
      _hasPressedOtherKeyDown = !_hasPressedOtherKeyDown;
    });
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(focusNode);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RawKeyboardListener(
        autofocus: true,
        focusNode: focusNode,
        onKey: (RawKeyEvent event) {
          final hasPressedSpace =
              event.data.logicalKey == LogicalKeyboardKey.space;
          if (hasPressedSpace && event is RawKeyUpEvent) {
            _incrementCounter();
            _toggleHasPressedSpaceDown();
          } else if (hasPressedSpace && event is RawKeyDownEvent) {
            _toggleHasPressedSpaceDown();
          } else {
            _toggleHasPressedOtherKeyDown();
          }
        },
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_hasPressedOtherKeyDown) {
      return const Center(
        child: Text('Press on the spacebar 😉'),
      );
    }
    return ShowCounter(counter: _counter);
  }
}

class ShowCounter extends StatelessWidget {
  const ShowCounter({
    Key key,
    @required int counter,
  })  : _counter = counter,
        super(key: key);

  final int _counter;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          Container(
            width: double.maxFinite,
            child: Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
              softWrap: true,
              textWidthBasis: TextWidthBasis.parent,
            ),
          ),
        ],
      ),
    );
  }
}
