
import 'package:enroll_plugin/constants/enroll_environment.dart';
import 'package:enroll_plugin/constants/enroll_localizations.dart';
import 'package:enroll_plugin/enroll_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EnrollScreen extends StatefulWidget {
  final EnrollLocalizations localization;

  const EnrollScreen({super.key, required this.localization});

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
        enrollEnvironment: EnrollEnvironment.staging,
        tenantId: const String.fromEnvironment("TENANT_ID"),
        onSuccess: () {
          debugPrint("Success");
        },
        onError: (ss) {
          debugPrint(ss.toString());
        },
        tenantSecret: const String.fromEnvironment("TENANT_SECRET"),
        googleApiKey: const String.fromEnvironment("GOOGLE_API_KEY"),
      ),
    );
  }
}