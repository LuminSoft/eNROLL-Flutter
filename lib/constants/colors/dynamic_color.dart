/// The [DynamicColor] class represents a color in RGB format with an optional opacity value.
///
/// This class can be used to define colors dynamically and supports JSON serialization and deserialization.
class DynamicColor {
  /// The red component of the color (0-255).
  int? r;

  /// The green component of the color (0-255).
  int? g;

  /// The blue component of the color (0-255).
  int? b;

  /// The opacity of the color (0.0 to 1.0).
  double? opacity;

  /// Creates a [DynamicColor] with the specified red [r], green [g], blue [b], and optional [opacity] values.
  DynamicColor({this.r, this.g, this.b, this.opacity});

  /// Creates a [DynamicColor] object from a JSON map.
  ///
  /// This constructor deserializes the JSON data into a [DynamicColor] object.
  DynamicColor.fromJson(Map<String, dynamic> json) {
    r = json['r'];
    g = json['g'];
    b = json['b'];
    opacity = json['opacity'];
  }

  /// Converts the [DynamicColor] object into a JSON map.
  ///
  /// This method serializes the [DynamicColor] object into a format that can be sent or stored as JSON.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['r'] = r;
    data['g'] = g;
    data['b'] = b;
    data['opacity'] = opacity;
    return data;
  }
}
