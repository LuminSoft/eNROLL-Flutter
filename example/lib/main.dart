import 'package:enroll_plugin/constants/enroll_localizations.dart';
import 'package:flutter/material.dart';

import 'enroll_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
  }

  void _handleCheckboxChange(bool? value) {
    setState(() {
      _isChecked = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Enroll'),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Skip Tutorial'),
                            Checkbox(
                              value: _isChecked,
                              onChanged: _handleCheckboxChange,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        width: 300,
                        child: ElevatedButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EnrollScreen(
                                          localization: EnrollLocalizations.ar,
                                          skipTutorial: _isChecked,
                                        ))),
                            child: const Text("أبدأ")),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        width: 300,
                        child: ElevatedButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EnrollScreen(
                                          skipTutorial: _isChecked,
                                          localization: EnrollLocalizations.en,
                                        ))),
                            child: const Text("Start")),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
