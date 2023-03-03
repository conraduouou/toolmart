class User {
  String? id;
  String? email;
  String? password;

  User({this.id, this.email, this.password});

  User.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    email = json['Email'];
    password = json['Password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['Id'] = id;
    data['Email'] = email;
    data['Password'] = password;
    return data;
  }
}
