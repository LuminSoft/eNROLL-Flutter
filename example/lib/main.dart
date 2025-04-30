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
          tenantId: 'b80c37ed-9d27-4fac-b62c-816b8ddecb6a',
          tenantSecret: 'e50c39df-da3c-4824-a425-f9d13cf85f5d',
          enrollMode: EnrollMode.onboarding,
          enrollEnvironment: EnrollEnvironment.staging,
          onSuccess: (applicantId) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              debugPrint("success: $applicantId");
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
          localizationCode: EnrollLocalizations.ar,
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
