import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyAnimationApp(),
    );
  }
}

class MyAnimationApp extends StatefulWidget {
  @override
  _MyAnimationAppState createState() => _MyAnimationAppState();
}

// Existing code...

class _MyAnimationAppState extends State<MyAnimationApp>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _slideAnimation =
        Tween<double>(begin: -50.0, end: 0.0).animate(_controller);
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(_controller);
    _colorAnimation =
        ColorTween(begin: Colors.blue, end: Colors.purple).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animation App"),
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _colorAnimation.value ?? Colors.blue,
                  Colors.white,
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      "THANYA R G",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(0, -1),
                      end: Offset(0, 0),
                    ).animate(_controller),
                    child: Text(
                      "Roll No: 21ITR113",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: Text(
                      "B.Tech Information Technology",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(0, 1),
                      end: Offset(0, 0),
                    ).animate(_controller),
                    child: Text(
                      "Kongu Engineering College, Perundurai, Erode",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                _colorAnimation.value ?? Colors.blue,
                Colors.white,
              ],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.play_arrow),
                onPressed: () {
                  _controller.forward();
                },
              ),
              IconButton(
                icon: Icon(Icons.pause),
                onPressed: () {
                  _controller.stop();
                },
              ),
              IconButton(
                icon: Icon(Icons.stop),
                onPressed: () {
                  _controller.reset();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
