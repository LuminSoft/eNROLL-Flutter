
abstract class EnrollState {}

class EnrollStart implements EnrollState{}

class EnrollError implements EnrollState{
  final String errorString;

  EnrollError({required this.errorString});
}

class EnrollSuccess implements EnrollState{}
