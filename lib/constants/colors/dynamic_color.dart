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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['r'] = this.r;
    data['g'] = this.g;
    data['b'] = this.b;
    data['opacity'] = this.opacity;
    return data;
  }
}