import 'package:enroll_plugin/constants/enroll_environment.dart';
import 'package:enroll_plugin/constants/enroll_localizations.dart';
import 'package:enroll_plugin/constants/enroll_mode.dart';
import 'package:enroll_plugin/enroll_plugin.dart';
import 'package:flutter/material.dart';

class EnrollScreen extends StatefulWidget {
  final EnrollLocalizations localization;
  final bool skipTutorial;

  const EnrollScreen(
      {super.key, required this.localization, required this.skipTutorial});

  @override
  State<EnrollScreen> createState() => _EnrollScreenState();
}

class _EnrollScreenState extends State<EnrollScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EnrollPlugin(
        mainScreenContext: context,
        localizationCode: widget.localization,
        enrollMode: EnrollMode.auth,
        enrollEnvironment: EnrollEnvironment.production,
        tenantId: 'TENANT_ID',
        applicationId: 'APPLICATION_ID',
        skipTutorial: widget.skipTutorial,
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
  }
}
