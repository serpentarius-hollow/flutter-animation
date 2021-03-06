import 'dart:math' as math;

import 'package:flutter/material.dart';

class AnimationPage extends StatefulWidget {
  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    final curvedAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.bounceIn, // change the curve here
      reverseCurve: Curves.easeOut,
    );

    animation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(curvedAnimation)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          animationController.forward();
        }
      });

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Widget'),
      ),
      body: CustomImage(
        animation: animation,
      ),
    );
  }
}

class CustomImage extends AnimatedWidget {
  final Animation<double> animation;

  CustomImage({@required this.animation}) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = super.listenable as Animation<double>;

    return Transform.rotate(
      angle: animation.value,
      child: Container(
        alignment: Alignment.center,
        child: Image.asset('assets/images/wheel-6-300.png'),
      ),
    );
  }
}
