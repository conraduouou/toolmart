class Item {
  String? id;
  String? name;
  String? details;
  List<String>? materials;
  List<String>? colors;
  int? left;
  double? price;

  Item(
      {this.id,
      this.name,
      this.details,
      this.materials,
      this.colors,
      this.left,
      this.price});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    details = json['Details'];
    materials = json['Materials'].cast<String>();
    colors = json['Colors'].cast<String>();
    left = json['Left'];
    price = json['Price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['Id'] = id;
    data['Name'] = name;
    data['Details'] = details;
    data['Materials'] = materials;
    data['Colors'] = colors;
    data['Left'] = left;
    data['Price'] = price;
    return data;
  }
}
