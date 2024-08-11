
abstract class EnrollState {}

class EnrollStart implements EnrollState{}

class EnrollError implements EnrollState{
  final String errorString;

  EnrollError({required this.errorString});
}


class RequestIdReceived implements EnrollState{
  final String requestId;
  RequestIdReceived({required this.requestId});
}

class EnrollSuccess implements EnrollState{}
