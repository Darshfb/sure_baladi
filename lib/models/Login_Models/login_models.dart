class LoginModels {
  String? id;
  String? username;
  String? email;
  String? token;
  String? type;
  List<dynamic> roles = [];

  LoginModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    token = json['token'];
    type = json['type'];
    roles = json['roles'];
  }
}

