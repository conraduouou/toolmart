class Transaction {
  String? id;
  String? userId;
  String? date;
  String? _paymentMethod;
  int? totalQuantity;
  double? price;

  Transaction({
    this.id,
    this.userId,
    this.date,
    String? paymentMethod,
    this.totalQuantity,
    this.price,
  }) : _paymentMethod = paymentMethod;

  String get paymentMethod {
    switch (_paymentMethod) {
      case 'cod':
        return 'Cash on Delivery';
      case 'bank':
        return 'Bank';
      case 'gcash':
        return 'GCash';
    }

    return '';
  }

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    userId = json['userId'];
    date = json['Date'];
    _paymentMethod = json['PaymentMethod'];
    totalQuantity = json['TotalQuantity'];
    price = json['Price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['Id'] = id;
    data['userId'] = userId;
    data['Date'] = DateTime.now().toIso8601String();
    data['PaymentMethod'] = _paymentMethod;
    data['TotalQuantity'] = totalQuantity;
    data['Price'] = price;
    return data;
  }
}
