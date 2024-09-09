/// The [EnrollState] is an abstract class that represents different states
/// in the eNROLL plugin enrollment process.
///
/// Various states can represent the different phases of the process, such as
/// starting, receiving a request ID, encountering an error, or completing the process.
abstract class EnrollState {}

/// The [EnrollStart] state indicates that the enrollment process has started.
class EnrollStart implements EnrollState {}

/// The [EnrollError] state is used when the enrollment process encounters an error.
///
/// This class contains a required [errorString] to provide details about the error.
class EnrollError implements EnrollState {
  /// A string representing the error message encountered during enrollment.
  final String errorString;

  /// Constructor for [EnrollError] that requires an [errorString].
  EnrollError({required this.errorString});
}

/// The [RequestIdReceived] state is used when a request ID has been received
/// during the enrollment process.
///
/// This class contains a required [requestId] that represents the unique request ID.
class RequestIdReceived implements EnrollState {
  /// A string representing the request ID received from the enrollment process.
  final String requestId;

  /// Constructor for [RequestIdReceived] that requires a [requestId].
  RequestIdReceived({required this.requestId});
}

/// The [EnrollSuccess] state indicates that the enrollment process has been completed successfully.
class EnrollSuccess implements EnrollState {}
