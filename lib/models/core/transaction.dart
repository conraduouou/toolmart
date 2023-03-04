class Transaction {
  String? id;
  String? date;
  String? paymentMethod;
  int? totalQuantity;
  double? price;

  Transaction(
      {this.id, this.date, this.paymentMethod, this.totalQuantity, this.price});

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    date = json['Date'];
    paymentMethod = json['PaymentMethod'];
    totalQuantity = json['TotalQuantity'];
    price = json['Price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['Id'] = id;
    data['Date'] = DateTime.now().toIso8601String();
    data['PaymentMethod'] = paymentMethod;
    data['TotalQuantity'] = totalQuantity;
    data['Price'] = price;
    return data;
  }
}
