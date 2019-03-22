import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(ImageRotate());
}

class ImageRotate extends StatefulWidget {
  @override
  _ImageRotateState createState() => _ImageRotateState();
}

class _ImageRotateState extends State<ImageRotate>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 60),
    );

  }

  @override
  Widget build(BuildContext context) {
    animationController.forward().orCancel;
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: Stack(
        textDirection: TextDirection.ltr,
        children: <Widget>[
          Container(
            width: 400,
            height: 400,
            decoration: new BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(1.0, 1.0),
                  blurRadius: 10.0,
                ),
              ],
              shape: BoxShape.circle,
            ),

          ),
          Container(
            width: 400,
            height: 400,
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
          StaggeredAnimation(controllerPointer: animationController.view),
          StaggeredAnimation2(controllerPointer: animationController.view),
        ],
      ),
    );
  }
}

class StaggeredAnimation extends StatelessWidget {
  final Animation<double> controllerPointer;
  final Animation<double> first;
  final Animation<double> second;
  final Animation<double> third;

  StaggeredAnimation({Key key, this.controllerPointer})
      : first = Tween<double>(
          begin: 0.0,
          end: 60.0,
        ).animate(
          CurvedAnimation(
            parent: controllerPointer,
            curve: Interval(
              0.0,
              1,
              curve: Curves.linear,
            ),
          ),
        ),
        second = Tween<double>(
          begin: 0.0,
          end: 20.0,
        ).animate(
          CurvedAnimation(
            parent: controllerPointer,
            curve: Interval(
              0.5,
              0.6,
              curve: Curves.easeInOut,
            ),
          ),
        ),
        third = Tween<double>(
          begin: 20.0,
          end: 60.0,
        ).animate(
          CurvedAnimation(
            parent: controllerPointer,
            curve: Interval(
              0.7,
              1,
              curve: Curves.easeInOut,
            ),
          ),
        ),
        super(key: key);

  Widget _buildAnimation(BuildContext context, Widget child) {
    double rotation = first.value % 60; //  + second.value % 60 + third.value % 60;
    return Container(
      width: 400,
      height: 400,
      child: Transform.rotate(
        // origin: Offset(-50.0, 0.0),
        angle: ((2 * math.pi) * rotation / 60) - (math.pi / 2),
        child: CustomPaint(painter: Line(true)),
      ),

    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controllerPointer,
    );
  }
}

class StaggeredAnimation2 extends StatelessWidget {
  final Animation<double> controllerPointer;
  final Animation<double> first;
  final Animation<double> second;
  final Animation<double> third;

  StaggeredAnimation2({Key key, this.controllerPointer})
      : first = Tween<double>(
          begin: 60.0,
          end: 20.0,
        ).animate(
          CurvedAnimation(
            parent: controllerPointer,
            curve: Interval(
              0.0,
              0.4,
              curve: Curves.easeInOut,
            ),
          ),
        ),
        second = Tween<double>(
          begin: 0.0,
          end: 30.0,
        ).animate(
          CurvedAnimation(
            parent: controllerPointer,
            curve: Interval(
              0.7,
              0.8,
              curve: Curves.easeInOut,
            ),
          ),
        ),
        third = Tween<double>(
          begin: 30.0,
          end: 60.0,
        ).animate(
          CurvedAnimation(
            parent: controllerPointer,
            curve: Interval(
              0.9,
              1,
              curve: Curves.easeInOut,
            ),
          ),
        ),
        super(key: key);

  Widget _buildAnimation(BuildContext context, Widget child) {
    double rotation = first.value % 60 + second.value % 60 + third.value % 60;
    return Container(
      width: 400,
      height: 400,
      child: Transform.rotate(
        // origin: Offset(-50.0, 0.0),
        angle: ((2 * math.pi) * rotation / 60) - (math.pi / 2),
        child: CustomPaint(painter: Line(false)),
      ),

    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controllerPointer,
    );
  }
}

class Line extends CustomPainter {
  Paint _paint;
  bool hoursHand;

  Line(this.hoursHand) {
    _paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 15.5
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double length = this.hoursHand ? 150 : 170;
    canvas.drawLine(Offset(200, 200), Offset(200 + length, 200), _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
