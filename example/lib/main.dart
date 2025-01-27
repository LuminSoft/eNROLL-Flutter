import 'package:enroll_plugin/enroll_plugin.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// My App
class MyApp extends StatefulWidget {
  /// My App constructor
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
          tenantId: '378a21e5-228d-4579-9c3e-4552196e57aa',
          tenantSecret: 'a50b16fe-1899-40c3-b9de-bf086c720cc1',
          enrollMode: EnrollMode.onboarding,
          enrollEnvironment: EnrollEnvironment.staging,
          onSuccess: (applicantId) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              debugPrint("Success:: $applicantId");
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
