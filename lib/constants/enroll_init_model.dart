class EnrollInitModel {
  String? localizationCode;
  String? enrollEnvironment;
  String? tenantId;
  String? tenantSecret;
  String? googleApiKey;

  EnrollInitModel(
      {this.localizationCode,
        this.enrollEnvironment,
        this.tenantId,
        this.tenantSecret,
        this.googleApiKey});

  EnrollInitModel.fromJson(Map<String, dynamic> json) {
    localizationCode = json['localizationCode'];
    enrollEnvironment = json['enrollEnvironment'];
    tenantId = json['tenantId'];
    tenantSecret = json['tenantSecret'];
    googleApiKey = json['googleApiKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['localizationCode'] = localizationCode;
    data['enrollEnvironment'] = enrollEnvironment;
    data['tenantId'] = tenantId;
    data['tenantSecret'] = tenantSecret;
    data['googleApiKey'] = googleApiKey;
    return data;
  }
}