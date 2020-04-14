class User{
  int id;
  String username;
  String role;
  var storedValue;

  User({this.id, this.username, this.role, this.storedValue,});

  factory User.fromJson(Map<String, dynamic> json) {
    return new User(
      id: json['id'],
      username: json['username'],
      role: json['role'],
      storedValue: json['storedValue'],
    );
  }
}