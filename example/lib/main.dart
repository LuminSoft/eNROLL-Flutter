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
  @override
  void initState() {
    super.initState();
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
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        width: 300,
                        child: ElevatedButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const EnrollScreen(
                                          localization: EnrollLocalizations.ar,
                                        ))),
                            child: Text("ابدأ")),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        width: 300,
                        child: ElevatedButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const EnrollScreen(
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
