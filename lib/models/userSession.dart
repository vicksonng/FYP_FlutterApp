class UserSession {
  int userID;
  String role;
  int storedValue;

  UserSession({this.userID, this.role, this.storedValue});

  factory UserSession.fromJson(Map<String, dynamic> json) {
    return new UserSession(
      userID: json['userID'],
      role: json['role'],
      storedValue: json['storedValue'],
    );
  }

}