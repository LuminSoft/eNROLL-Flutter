import 'package:enroll_plugin/enroll_plugin.dart';
import 'package:flutter/material.dart';

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
          body: EnrollPlugin(
            mainScreenContext: context,
            tenantId: '3bab5a01-b3e2-4900-890c-d5fc6990e610',
            tenantSecret: 'e84e5d36-ede2-42a6-abba-ae01a9b773fc',
            enrollMode: EnrollMode.onboarding,
            enrollEnvironment: EnrollEnvironment.staging,
            localizationCode: EnrollLocalizations.en,
            onSuccess: () {
              // Delay the state change until after the build completes
              WidgetsBinding.instance.addPostFrameCallback((_) {
                debugPrint("Success");
              });
            },
            onError: (error) {
              // Delay the state change until after the build completes
              WidgetsBinding.instance.addPostFrameCallback((_) {
                debugPrint("Error: ${error.toString()}");
              });
            },
            onGettingRequestId: (requestId) {
              // Delay the state change until after the build completes
              WidgetsBinding.instance.addPostFrameCallback((_) {
                debugPrint("requestId:: $requestId");
              });
            },
            applicationId: 'APPLICATION_ID',
            skipTutorial: false,
            levelOfTrust: 'LEVEL_OF_TRUST_TOKEN',
            googleApiKey: 'GOOGLE_API_KEY',
            correlationId: 'correlationIdTest',
          ),
        );
      }),
    );
  }
}
