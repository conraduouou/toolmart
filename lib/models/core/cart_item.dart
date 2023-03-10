class CartItem {
  String? id;
  String? userId;
  String? itemId;
  String? itemColor;
  int? itemQuantity;

  String? name;
  double? _price;

  get _isNotNull => _price != null && itemQuantity != null;

  double? get price => _isNotNull ? _price! * itemQuantity! : 0.0;
  set price(double? p) => _price = p;

  CartItem(
      {this.id, this.userId, this.itemId, this.itemColor, this.itemQuantity});

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    userId = json['UserId'];
    itemId = json['ItemId'];
    itemColor = json['ItemColor'];
    itemQuantity = json['ItemQuantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['Id'] = id;
    data['UserId'] = userId;
    data['ItemId'] = itemId;
    data['ItemColor'] = itemColor;
    data['ItemQuantity'] = itemQuantity;
    return data;
  }
}
