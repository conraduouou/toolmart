class Transaction {
  String? id;
  String? userId;
  String? date;
  String? paymentMethod;
  int? totalQuantity;
  double? price;

  Transaction({
    this.id,
    this.userId,
    this.date,
    this.paymentMethod,
    this.totalQuantity,
    this.price,
  });

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    userId = json['userId'];
    date = json['Date'];
    paymentMethod = json['PaymentMethod'];
    totalQuantity = json['TotalQuantity'];
    price = json['Price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['Id'] = id;
    data['userId'] = userId;
    data['Date'] = DateTime.now().toIso8601String();
    data['PaymentMethod'] = paymentMethod;
    data['TotalQuantity'] = totalQuantity;
    data['Price'] = price;
    return data;
  }
}
