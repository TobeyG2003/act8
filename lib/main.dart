import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

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
  Color selectedTextColor = Colors.blue;

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.themeMode == ThemeMode.dark;

    bool isSwitched = false;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget> [
            ElevatedButton(
            onPressed: () {
              if (isDark) {
                widget.changeTheme(ThemeMode.light);
              } else {
                widget.changeTheme(ThemeMode.dark);
              }
            },
            child: Icon(widget.themeMode == ThemeMode.dark ? Icons.nightlight_round : Icons.wb_sunny)
          ),
          ElevatedButton(
                  onPressed: () async {
                    final newColor = await showColorPickerDialog(
                      context,
                      selectedTextColor,
                      title: Text('Pick a Color', style: Theme.of(context).textTheme.headlineSmall),
                      pickersEnabled: const <ColorPickerType, bool>{
                        ColorPickerType.both: false,
                        ColorPickerType.primary: true,
                        ColorPickerType.accent: true,
                        ColorPickerType.bw: false,
                        ColorPickerType.custom: true,
                        ColorPickerType.wheel: true,
                      },
                    );
                    setState(() {
                      selectedTextColor = newColor;
                    });
                  },
                  child: Icon(Icons.color_lens, color: selectedTextColor),
                ),
          ],
          title: const Text('Fading Text Animation'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Hello, Flutter!'),
              Tab(text: 'Bounce In'),
              Tab(text: 'Image'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: AnimatedOpacity(
                opacity: _isVisible ? 1.0 : 0.0,
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
                child: Text(
                  'Hello, Flutter!',
                  style: TextStyle(fontSize: 24, color: selectedTextColor),
                ),
              ),
            ),
            Center(
              child: AnimatedOpacity(
                opacity: _isVisible ? 1.0 : 0.0,
                duration: const Duration(seconds: 5),
                curve: Curves.bounceIn,
                child: Text(
                  'This Text bounces in',
                  style: TextStyle(fontSize: 24, color: selectedTextColor),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://images.steamusercontent.com/ugc/2056503000594664135/4A6CC88DE96CE4779E62810DCE348F5241999F59/?imw=512&&ima=fit&impolicy=Letterbox&imcolor=%23000000&letterbox=false',
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                Switch(
                  value: isSwitched,
                  onChanged: (newValue) {
                  setState(() {
                  isSwitched = newValue; // Update the state when the switch is toggled
                });
              },
            ),
              ],
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
