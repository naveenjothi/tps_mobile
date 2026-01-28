/// TPS User model and request objects.
library;

class TPSUser {
  final String id;
  final String firebaseId;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? mobile;
  final String? userName;
  final String? photoUrl;

  TPSUser({
    required this.id,
    required this.firebaseId,
    this.email,
    this.firstName,
    this.lastName,
    this.mobile,
    this.userName,
    this.photoUrl,
  });

  factory TPSUser.fromJson(Map<String, dynamic> json) {
    return TPSUser(
      id: json['id'] ?? '',
      firebaseId: json['firebase_id'] ?? '',
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      mobile: json['mobile'],
      userName: json['user_name'],
      photoUrl: json['photo_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firebase_id': firebaseId,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'mobile': mobile,
      'user_name': userName,
      'photo_url': photoUrl,
    };
  }
}

/// Request object for creating a new user in the backend.
class CreateUserRequest {
  final String firebaseId;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? mobile;
  final String? userName;
  final String? photoUrl;

  CreateUserRequest({
    required this.firebaseId,
    this.email,
    this.firstName,
    this.lastName,
    this.mobile,
    this.userName,
    this.photoUrl,
  });
}
