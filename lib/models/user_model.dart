class User {
  String username;
  String password;

  User({
    required this.username,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json['username'],
        password: json['password'],
      );

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };
}

// Copy kode di atas ke file: models/user_model.dart