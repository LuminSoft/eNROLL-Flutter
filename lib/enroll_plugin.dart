import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants/enroll_environment.dart';
import 'constants/enroll_init_model.dart';
import 'constants/enroll_localizations.dart';
import 'constants/enroll_state.dart';

class EnrollPlugin extends StatefulWidget {
  final EnrollLocalizations localizationCode;
  final EnrollEnvironment enrollEnvironment;
  final String tenantId;
  final String tenantSecret;
  final Function onSuccess;
  final Function(String error) onError;
  final BuildContext mainScreenContext;
  final String? googleApiKey;

  const EnrollPlugin({
    super.key,
    this.localizationCode = EnrollLocalizations.en,
    this.enrollEnvironment = EnrollEnvironment.staging,
    required this.tenantId,
    required this.tenantSecret,
    required this.onSuccess,
    required this.onError,
    required this.mainScreenContext,
    this.googleApiKey,
  });

  @override
  State<EnrollPlugin> createState() => _EnrollPluginState();
}

class _EnrollPluginState extends State<EnrollPlugin> {
  final StreamController<EnrollState> enrollStream = StreamController();
  late EnrollInitModel model;

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

    model = EnrollInitModel(
      tenantId: widget.tenantId,
      tenantSecret: widget.tenantSecret,
      googleApiKey: widget.googleApiKey,
      enrollEnvironment: widget.enrollEnvironment.name,
      localizationCode: widget.localizationCode.name,
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
            if (snapshot.data != null) {
              if (snapshot.data is EnrollSuccess) {
                widget.onSuccess();
                Navigator.of(widget.mainScreenContext).pop();
                return const SizedBox();
              } else if (snapshot.data is EnrollError) {
                EnrollError error = snapshot.data as EnrollError;
                widget.onError(error.errorString);
                Navigator.of(widget.mainScreenContext).pop();
                return const SizedBox();
              } else if (snapshot.data is EnrollStart) {
                _startEnroll();
                return const SizedBox();
              }
              return const SizedBox();
            }
            return const SizedBox();
          }),
    );
  }

  void _startEnroll() {
    var json = jsonEncode(model.toJson());

    const MethodChannel('enroll_plugin')
        .invokeMethod('startEnroll', json)
        .then((value) {
      if (value is String) {
        if (value.contains('success')) {
          enrollStream.add(EnrollSuccess());
        } else {
          enrollStream.add(EnrollError(errorString: "unhandledError"));
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
