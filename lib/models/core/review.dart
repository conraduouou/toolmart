class Review {
  String? id;
  String? userId;
  String? itemId;
  String? userComment;
  int? userRating;

  Review(
      {this.id, this.userId, this.itemId, this.userComment, this.userRating});

  Review.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    userId = json['UserId'];
    itemId = json['ItemId'];
    userComment = json['UserComment'];
    userRating = json['UserRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['UserId'] = userId;
    data['ItemId'] = itemId;
    data['UserComment'] = userComment;
    data['UserRating'] = userRating;
    return data;
  }
}
