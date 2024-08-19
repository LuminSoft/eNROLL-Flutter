enum NativeEventTypes {
  onSuccess,
  onError,
  onRequestId,
}

extension NativeEventTypesExt on NativeEventTypes {
  static NativeEventTypes? parse(String value) {
    switch (value) {
      case 'on_success':
        return NativeEventTypes.onSuccess;
      case 'on_error':
        return NativeEventTypes.onError;
      case 'on_request_id':
        return NativeEventTypes.onRequestId;
      default:
        return null;
    }
  }
}