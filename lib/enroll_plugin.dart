import 'dart:async';
import 'dart:convert';

import 'package:enroll_plugin/constants/enroll_colors.dart';
import 'package:enroll_plugin/constants/native_event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants/enroll_environment.dart';
import 'constants/enroll_init_model.dart';
import 'constants/enroll_localizations.dart';
import 'constants/enroll_mode.dart';
import 'constants/enroll_state.dart';
import 'constants/event_models.dart';
import 'constants/native_event_types.dart';

export 'package:enroll_plugin/constants/enroll_environment.dart';
export 'package:enroll_plugin/constants/enroll_localizations.dart';
export 'package:enroll_plugin/constants/enroll_mode.dart';

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
    this.enrollMode = EnrollMode.onboarding,
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
  late final StreamController<EnrollState> enrollStream;
  late EnrollInitModel model;
  static const MethodChannel _platform = MethodChannel('enroll_plugin');
  static const EventChannel _eventChannel =
      EventChannel('enroll_plugin_channel');

  Stream<String>? _stream;

  @override
  void initState() {
    super.initState();

    enrollStream = StreamController();

    _stream = _eventChannel.receiveBroadcastStream().map<String>((event) {
      return event;
    });
    _stream?.listen((event) {
      NativeEventModel model = NativeEventModel.fromJson(json.decode(event));
      switch (model.event) {
        case NativeEventTypes.onSuccess:
          enrollStream.add(EnrollSuccess());
        case NativeEventTypes.onError:
          var errorModel = ErrorEventModel.fromJson(model.data!);
          enrollStream.add(EnrollError(errorString: errorModel.message ?? ''));
        case NativeEventTypes.onRequestId:
          var requestIdModel = RequestIdEventModel.fromJson(model.data!);
          widget.onGettingRequestId(requestIdModel.requestId ?? "");
        // enrollStream.add(
        //     EnrollError(errorString: 'requestIdModel.requestId' ?? ''));
        default:
          break;
      }
    });

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
    if (widget.enrollMode == EnrollMode.auth) {
      if (widget.applicationId == null) {
        widget.onError('Application Id cannot be empty');
        Navigator.of(context).pop();
      }
      if (widget.levelOfTrust == null) {
        widget.onError('Level of trust cannot be empty');
        Navigator.of(context).pop();
      }
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
                } else if (snapshot.data is RequestIdReceived) {
                  RequestIdReceived requestId =
                      snapshot.data as RequestIdReceived;
                  widget.onGettingRequestId(requestId.requestId);
                }
              }
            });
            return const SizedBox();
          }),
    );
  }

  void _startEnroll() {
    var json = jsonEncode(model.toJson());

    _platform.invokeMethod('startEnroll', json).catchError((error) {
      if (error is PlatformException) {
        enrollStream.add(EnrollError(errorString: error.message ?? ""));
      } else {
        enrollStream.add(EnrollError(errorString: "unhandledError"));
      }
    });
  }
}
