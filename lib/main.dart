import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

void main() => runApp(ConfettiApp());

const _confettiSize = 100.0;

class ConfettiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: true,
      checkerboardOffscreenLayers: true,
      title: 'Confetti',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: ConfettiScene(),
    );
  }
}

class ConfettiScene extends StatefulWidget {
  ConfettiScene();

  @override
  createState() => _ConfettiScene();
}

class _ConfettiScene extends State<ConfettiScene> {
  final _random = math.Random();

  Timer _timer;
  double _height = 0.0;
  double _width = 0.0;
  bool _showBlur = false;
  bool _showOpacity = false;
  int _numConfetti = 5;

  @override
  initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 125), (Timer t) {
      setState(() {
        _height += _random.nextInt(20);
        _width += _random.nextInt(10) - 1;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final confetti = <Widget>[];
    for (var i = 0; i < _numConfetti; i++) {
      final height = _random.nextInt(size.height.floor());
      final width = _random.nextInt(size.width.floor());
      confetti.add(Confetti((_height + height) % size.height,
          (_width + width) % size.width, _showOpacity));
    }
    if (_showBlur) {
      final blurScreen = BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
          ),
        ),
      );
      confetti.add(blurScreen);
    }

    final buttons = Positioned(
      bottom: 16.0,
      right: 16.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          RaisedButton(
            onPressed: () => setState(() {
                  _numConfetti += 10;
                }),
            child: Text('More Confetti'),
            color: Colors.white,
          ),
          SizedBox(height: 8.0),
          RaisedButton(
            onPressed: () => setState(() {
                  _showOpacity = !_showOpacity;
                }),
            child: Text('Toggle Opacity'),
            color: Colors.white,
          ),
          SizedBox(height: 8.0),
          RaisedButton(
            onPressed: () => setState(() {
                  _showBlur = !_showBlur;
                }),
            child: Text('Toggle Blur'),
            color: Colors.white,
          ),
        ],
      ),
    );

    return Container(
      color: Colors.black,
      child: Stack(
        children: confetti..add(buttons),
      ),
    );
  }
}

class Confetti extends StatelessWidget {
  final double top;
  final double left;
  final bool showOpacity;

  Confetti(this.top, this.left, this.showOpacity);

  @override
  Widget build(BuildContext context) {
    final random = math.Random();
    final confetti = Opacity(
      opacity: showOpacity ? 0.5 : 1.0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.pink[random.nextInt(9) * 100],
          shape: BoxShape.circle,
        ),
        width: _confettiSize + random.nextInt(20) - 10,
        height: _confettiSize + random.nextInt(20) - 10,
      ),
    );
    return Positioned(
      top: top,
      left: left,
      child: confetti,
    );
  }
}
