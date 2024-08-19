import 'native_event_types.dart';

class NativeEventModel<T> {
  NativeEventTypes? event;
  Map<String, dynamic>? data;

  NativeEventModel({this.event, this.data});

  NativeEventModel.fromJson(
    Map<String, dynamic> json,
  ) {
    event = NativeEventTypesExt.parse(json['event']);
    data = json['data'];
  }
}
