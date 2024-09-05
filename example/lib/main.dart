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
          tenantId: 'TENANT_ID',
          tenantSecret: 'TENANT_SECRET',
          enrollMode: EnrollMode.onboarding,
          enrollEnvironment: EnrollEnvironment.staging,
          onSuccess: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              debugPrint("Success");
            });
          },
          onError: (error) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              debugPrint("Error: ${error.toString()}");
            });
          },
          onGettingRequestId: (requestId) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              debugPrint("requestId:: $requestId");
            });
          },
          localizationCode: EnrollLocalizations.en,
          applicationId: 'APPLICATION_ID',
          skipTutorial: false,
          levelOfTrust: 'LEVEL_OF_TRUST_TOKEN',
          googleApiKey: 'GOOGLE_API_KEY',
          correlationId: 'correlationIdTest',
        ),
      );
    }));
  }
}
