import 'dart:async';
import 'dart:convert';

import 'package:enroll_plugin/constants/enroll_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants/enroll_environment.dart';
import 'constants/enroll_init_model.dart';
import 'constants/enroll_localizations.dart';
import 'constants/enroll_mode.dart';
import 'constants/enroll_state.dart';

class EnrollPlugin extends StatefulWidget {
  final EnrollLocalizations localizationCode;
  final EnrollEnvironment enrollEnvironment;
  final EnrollMode enrollMode;
  final String tenantId;
  final String tenantSecret;
  final Function onSuccess;
  final Function(String error) onError;
  final Function(String requestId) onGettingRequestId;
  final BuildContext mainScreenContext;
  final String? googleApiKey;
  final String? levelOfTrust;
  final String? applicationId;
  final bool? skipTutorial;
  final EnrollColors? enrollColors;

  const EnrollPlugin({
    super.key,
    this.localizationCode = EnrollLocalizations.en,
    this.enrollEnvironment = EnrollEnvironment.staging,
    this.enrollMode = EnrollMode.ONBOARDING,
    required this.tenantId,
    required this.tenantSecret,
    required this.onSuccess,
    required this.onError,
    required this.onGettingRequestId,
    required this.mainScreenContext,
    this.googleApiKey,
    this.enrollColors,
    this.levelOfTrust,
    this.applicationId,
    this.skipTutorial,
  });

  @override
  State<EnrollPlugin> createState() => _EnrollPluginState();
}

class _EnrollPluginState extends State<EnrollPlugin> {
  final StreamController<EnrollState> enrollStream = StreamController();
  late EnrollInitModel model;
  static const MethodChannel _platform = MethodChannel('enroll_plugin');

  @override
  void initState() {
    super.initState();

    enrollStream.add(EnrollStart());

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    if (widget.tenantId == '') {
      widget.onError('Tenant id cannot be empty');
      Navigator.of(context).pop();
    }
    if (widget.tenantSecret.isEmpty) {
      widget.onError('Tenant secret cannot be empty');
      Navigator.of(context).pop();
    }
    model = EnrollInitModel(
      applicationId: widget.applicationId,
      levelOfTrust: widget.levelOfTrust,
      skipTutorial: widget.skipTutorial,
      tenantId: widget.tenantId,
      tenantSecret: widget.tenantSecret,
      googleApiKey: widget.googleApiKey,
      enrollEnvironment: widget.enrollEnvironment.name,
      localizationCode: widget.localizationCode.name,
      enrollMode: widget.enrollMode.name,
      onGettingRequestId: widget.onGettingRequestId,
      colors: EnrollColors(
          // primary: widget.enrollColors?.primary. ?? Colors.blue,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: widget.localizationCode == EnrollLocalizations.ar
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: StreamBuilder(
          stream: enrollStream.stream,
          builder: (context, snapshot) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (snapshot.data != null) {
                if (snapshot.data is EnrollSuccess) {
                  widget.onSuccess();
                  Navigator.of(widget.mainScreenContext).pop();
                } else if (snapshot.data is EnrollError) {
                  EnrollError error = snapshot.data as EnrollError;
                  widget.onError(error.errorString);
                  Navigator.of(widget.mainScreenContext).pop();
                } else if (snapshot.data is EnrollStart) {
                  _startEnroll();
                }
              }
            });
            return const SizedBox();
          }),
    );
  }

  void _startEnroll() {
    var json = jsonEncode(model.toJson());

    _platform.invokeMethod('startEnroll', json).then((value) {
      if (value is String) {
        if (value.contains('success')) {
          enrollStream.add(EnrollSuccess());
        } else if (value.contains('ENROLL_ERROR')) {
          enrollStream.add(EnrollError(errorString: value));
        } else {
          enrollStream.add(RequestIdReceived(requestId: value));
        }
      } else {
        enrollStream.add(EnrollError(errorString: value ?? ""));
      }
    }).catchError((error) {
      if (error is PlatformException) {
        enrollStream.add(EnrollError(errorString: error.message ?? ""));
      } else {
        enrollStream.add(EnrollError(errorString: "unhandledError"));
      }
    });
  }
}
