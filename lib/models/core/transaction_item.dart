class TransactionItem {
  String? id;
  String? transactionId;
  String? itemId;
  String? itemColor;
  int? itemQuantity;

  TransactionItem(
      {this.id,
      this.transactionId,
      this.itemId,
      this.itemColor,
      this.itemQuantity});

  TransactionItem.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    transactionId = json['TransactionId'];
    itemId = json['ItemId'];
    itemColor = json['ItemColor'];
    itemQuantity = json['ItemQuantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['TransactionId'] = transactionId;
    data['ItemId'] = itemId;
    data['ItemColor'] = itemColor;
    data['ItemQuantity'] = itemQuantity;
    return data;
  }
}
