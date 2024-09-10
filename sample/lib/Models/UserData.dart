class User {
  final int userId;
  final String userName;
  final String gender;
  final String dateOfBirth;

  User({
    required this.userId,
    required this.userName,
    required this.gender,
    required this.dateOfBirth,
  });

  // Factory constructor for creating a new User instance from a map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      userName: json['userName'],
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'],
    );
  }
}
