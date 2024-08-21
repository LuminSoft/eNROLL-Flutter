
import 'package:enroll_plugin/constants/enroll_colors.dart';
import 'package:enroll_plugin/constants/enroll_environment.dart';
import 'package:enroll_plugin/constants/enroll_localizations.dart';
import 'package:enroll_plugin/constants/enroll_mode.dart';
import 'package:enroll_plugin/enroll_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EnrollScreen extends StatefulWidget {
  final EnrollLocalizations localization;
  final bool skipTutorial;

  const EnrollScreen({super.key, required this.localization,required this.skipTutorial});

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
        enrollMode: EnrollMode.ONBOARDING,
        enrollEnvironment: EnrollEnvironment.production,
        tenantId:     '3489aa92-46f7-4e6e-a0f8-369083a6fb03',
        // tenantId:     const String.fromEnvironment('TENANT_ID'),
        applicationId: '1721303900563',
        // applicationId: const String.fromEnvironment('APPLICATION_ID'),
        skipTutorial: widget.skipTutorial,
        levelOfTrust: '036a26e5-3f06-4d37-8275-a94f1e781b75',
        // levelOfTrust: const String.fromEnvironment('LEVEL_OF_TRUST_TOKEN'),
        onSuccess: () {
          debugPrint("Success");
        },
        onError: (error) {
          debugPrint("Error: ${error.toString()}");
        },
        onGettingRequestId: (requestId) {
          debugPrint("requestId:: $requestId");
        },
        tenantSecret: '83d7afe4-42f5-4438-a6ba-5e38d43af4fc',
        // tenantSecret: const String.fromEnvironment('TENANT_SECRET'),
        // enrollColors: EnrollColors(textColor: Colors.red,primary: Colors.amber),
        googleApiKey: 'AIzaSyCqLOHRPi_s1LO6hj8YeqY7HByu7G5kqcY',
        // googleApiKey: const String.fromEnvironment('GOOGLE_API_KEY'),
      ),
    );
  }
}