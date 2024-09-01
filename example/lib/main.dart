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
  Widget build(BuildContext context) {
    return MaterialApp(home: Builder(builder: (context) {
      return Scaffold(
        body: EnrollPlugin(
          mainScreenContext: context,
          localizationCode: EnrollLocalizations.ar,
          enrollMode: EnrollMode.auth,
          enrollEnvironment: EnrollEnvironment.production,
          tenantId: 'TENANT_ID',
          applicationId: 'APPLICATION_ID',
          skipTutorial: false,
          levelOfTrust: 'LEVEL_OF_TRUST_TOKEN',
          onSuccess: () {
            debugPrint("Success");
          },
          onError: (error) {
            debugPrint("Error: ${error.toString()}");
          },
          onGettingRequestId: (requestId) {
            debugPrint("requestId:: $requestId");
          },
          tenantSecret: 'TENANT_SECRET',
          googleApiKey: 'GOOGLE_API_KEY',
        ),
      );
    }));
  }
}
