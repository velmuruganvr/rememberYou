// import 'dart:convert';
//
// class UserRegistration {
//   String name;
//   DateTime dateOfBirth;
//   String address;
//   Long phoneNumber;
//   String gender;
//   String email;
//   String password;
//   String country;
//   String city;
//   int postalCode;
//   String occupation;
//
//   UserRegistration({
//     required this.name,
//     required this.dateOfBirth,
//     required this.address,
//     required this.phoneNumber,
//     required this.gender,
//     required this.email,
//     required this.password,
//     required this.country,
//     required this.city,
//     required this.postalCode,
//     required this.occupation,
//   });
//
//   // Factory constructor to create a User instance from JSON
//   factory UserRegistration.fromJson(Map<String, dynamic> json) {
//     return UserRegistration(
//       name: json['name'],
//       dateOfBirth: DateTime.parse(json['dateOfBirth']),
//       address: json['address'],
//       phoneNumber: json['phoneNumber'],
//       gender: json['gender'],
//       email: json['email'],
//       password: json['password'],
//       country: json['country'],
//       city: json['city'],
//       postalCode: json['postalCode'],
//       occupation: json['occupation'],
//     );
//   }
//
//   // Method to convert a User instance to JSON
//   // Map<String, dynamic> toJson() {
//   //   return {
//   //     'name': name,
//   //     'dateOfBirth': dateOfBirth.toIso8601String(),
//   //     'address': address,
//   //     'phoneNumber': phoneNumber,
//   //     'gender': gender,
//   //     'email': email,
//   //     'password': password,
//   //     'country': country,
//   //     'city': city,
//   //     'postalCode': postalCode,
//   //     'occupation': occupation,
//   //   };
//   // }
// }
//
//
//
