import 'native_event_types.dart';

/// The [NativeEventModel] class is used to represent a native event
/// and its associated data that occurs within the plugin.
///
/// [T] represents the type of the event data that will be managed by this model.
class NativeEventModel<T> {
  /// The type of the event, which is represented by [NativeEventTypes].
  NativeEventTypes? event;

  /// A map of dynamic data that holds additional information related to the event.
  Map<String, dynamic>? data;

  /// Constructor to initialize a [NativeEventModel] with an optional event type and data.
  NativeEventModel({this.event, this.data});

  /// Creates a [NativeEventModel] object from a JSON map.
  ///
  /// This constructor parses the event type using [NativeEventTypesExt.parse]
  /// and assigns the provided data to the model.
  NativeEventModel.fromJson(Map<String, dynamic> json) {
    event = NativeEventTypesExt.parse(json['event']);
    data = json['data'];
  }
}
