import 'package:enroll_plugin/constants/enroll_colors.dart';

class EnrollInitModel {
  String? localizationCode;
  String? enrollEnvironment;
  String? enrollMode;
  String? tenantId;
  String? applicationId;
  String? levelOfTrust;
  bool? skipTutorial;
  String? tenantSecret;
  String? googleApiKey;
  EnrollColors? colors;

  EnrollInitModel({
    this.localizationCode,
    this.enrollEnvironment,
    this.enrollMode,
    this.tenantId,
    this.tenantSecret,
    this.googleApiKey,
    this.colors,
    this.applicationId,
    this.levelOfTrust,
    this.skipTutorial,
    required Function(String requestId) ongettingRequestId
  });

  EnrollInitModel.fromJson(Map<String, dynamic> json) {
    localizationCode = json['localizationCode'];
    enrollEnvironment = json['enrollEnvironment'];
    tenantId = json['tenantId'];
    enrollMode = json['enrollMode'];
    applicationId = json['applicationId'];
    levelOfTrust = json['levelOfTrust'];
    skipTutorial = json['skipTutorial'];
    tenantSecret = json['tenantSecret'];
    googleApiKey = json['googleApiKey'];
    colors = null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['localizationCode'] = localizationCode;
    data['enrollEnvironment'] = enrollEnvironment;
    data['tenantId'] = tenantId;
    data['enrollMode'] = enrollMode;
    data['tenantSecret'] = tenantSecret;
    data['googleApiKey'] = googleApiKey;
    data['applicationId'] = applicationId;
    data['levelOfTrust'] = levelOfTrust;
    data['skipTutorial'] = skipTutorial;
    if (colors != null) {
      data['colors'] = colors!.toJson();
    }
    return data;
  }
}
