import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void changeTheme(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: FadingTextAnimation(
        changeTheme: changeTheme,
        themeMode: _themeMode,
      ),
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  final void Function(ThemeMode) changeTheme;
  final ThemeMode themeMode;

  const FadingTextAnimation({Key? key, required this.changeTheme, required this.themeMode}) : super(key: key);

  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}
class _FadingTextAnimationState extends State<FadingTextAnimation> {
  bool _isVisible = true;

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.themeMode == ThemeMode.dark;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: ElevatedButton(
            onPressed: () {
              if (isDark) {
                widget.changeTheme(ThemeMode.light);
              } else {
                widget.changeTheme(ThemeMode.dark);
              }
            },
            child: Icon(widget.themeMode == ThemeMode.dark ? Icons.nightlight_round : Icons.wb_sunny)
          ),
          title: const Text('Fading Text Animation'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Hello, Flutter!'),
              Tab(text: 'Sample'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: AnimatedOpacity(
                opacity: _isVisible ? 1.0 : 0.0,
                duration: const Duration(seconds: 1),
                child: const Text(
                  'Hello, Flutter!',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            Center(
              child: AnimatedOpacity(
                opacity: _isVisible ? 1.0 : 0.0,
                duration: const Duration(seconds: 5),
                child: const Text(
                  'Hello, Flutter!',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: toggleVisibility,
          child: const Icon(Icons.play_arrow),
        ),
      ),
    );
  }
}
