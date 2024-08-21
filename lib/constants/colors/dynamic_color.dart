class DynamicColor {
  int? r;
  int? g;
  int? b;
  double? opacity;

  DynamicColor({this.r, this.g, this.b, this.opacity});

  DynamicColor.fromJson(Map<String, dynamic> json) {
    r = json['r'];
    g = json['g'];
    b = json['b'];
    opacity = json['opacity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['r'] = r;
    data['g'] = g;
    data['b'] = b;
    data['opacity'] = opacity;
    return data;
  }
}
