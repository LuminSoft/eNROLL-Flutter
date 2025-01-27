/// The [ErrorEventModel] class represents an error event with an associated message and code.
///
/// This class is used to capture error details in the event of a failure.
class ErrorEventModel {
  /// A message describing the error.
  String? message;

  /// A code identifying the error.
  String? code;

  /// Creates an [ErrorEventModel] object from a JSON map.
  ///
  /// This constructor deserializes the JSON data into an [ErrorEventModel] object.
  ErrorEventModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
  }
}

/// The [RequestIdEventModel] class represents an event that captures a request ID.
///
/// This is used to handle events where a request ID is generated or received.
class RequestIdEventModel {
  /// The request ID generated for the event.
  String? requestId;

  /// Creates a [RequestIdEventModel] object from a JSON map.
  ///
  /// This constructor deserializes the JSON data into a [RequestIdEventModel] object.
  RequestIdEventModel.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
  }
}

/// The [SuccessEventModel] class represents an event that captures a applicant ID.
///
/// This is used to handle events where a applicant ID is generated or received.
class SuccessEventModel {
  /// The applicant ID generated for the event.
  String? applicantId;

  /// Creates a [SuccessEventModel] object from a JSON map.
  ///
  /// This constructor deserializes the JSON data into a [SuccessEventModel] object.
  SuccessEventModel.fromJson(Map<String, dynamic> json) {
    applicantId = json['applicantId'];
  }
}
