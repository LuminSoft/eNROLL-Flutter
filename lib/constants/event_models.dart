
class ErrorEventModel {
  String? message;
  String? code;

  ErrorEventModel.fromJson(
      Map<String, dynamic> json,
      ) {
    message = json['message'];
    code = json['code'];
  }
}

class RequestIdEventModel {
  String? requestId;

  RequestIdEventModel.fromJson(
      Map<String, dynamic> json,
      ) {
    requestId = json['requestId'];
  }
}