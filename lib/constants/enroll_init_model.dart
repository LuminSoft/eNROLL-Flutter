import 'package:enroll_plugin/constants/enroll_colors.dart';

class EnrollInitModel {
  String? localizationCode;
  String? enrollEnvironment;
  String? tenantId;
  String? tenantSecret;
  String? googleApiKey;
  EnrollColors? colors;

  EnrollInitModel({
    this.localizationCode,
    this.enrollEnvironment,
    this.tenantId,
    this.tenantSecret,
    this.googleApiKey,
    this.colors,
  });

  EnrollInitModel.fromJson(Map<String, dynamic> json) {
    localizationCode = json['localizationCode'];
    enrollEnvironment = json['enrollEnvironment'];
    tenantId = json['tenantId'];
    tenantSecret = json['tenantSecret'];
    googleApiKey = json['googleApiKey'];
    colors = null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['localizationCode'] = localizationCode;
    data['enrollEnvironment'] = enrollEnvironment;
    data['tenantId'] = tenantId;
    data['tenantSecret'] = tenantSecret;
    data['googleApiKey'] = googleApiKey;
    if (colors != null) {
      data['colors'] = colors!.toJson();
    }
    return data;
  }
}
