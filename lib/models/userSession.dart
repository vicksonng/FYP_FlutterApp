class UserSession {
  int userID;
  String role;

  UserSession({this.userID, this.role});

  factory UserSession.fromJson(Map<String, dynamic> json) {
    return new UserSession(
      userID: json['userID'],
      role: json['role']
    );
  }
}