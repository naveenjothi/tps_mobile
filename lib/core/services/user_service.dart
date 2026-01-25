import 'package:firebase_auth/firebase_auth.dart';
import 'package:tps_core/core/models/models.dart';
import 'package:tps_core/core/services/api_client.dart';

class UserService {
  final ApiClient _client;

  UserService({required ApiClient client}) : _client = client;

  Future<TPSUser> createUser(CreateUserRequest request) async {
    final body = {
      'firebase_id': request.firebaseId,
      if (request.email != null) 'email': request.email,
      if (request.firstName != null) 'first_name': request.firstName,
      if (request.lastName != null) 'last_name': request.lastName,
      if (request.mobile != null) 'mobile': request.mobile,
      if (request.userName != null) 'user_name': request.userName,
      if (request.photoUrl != null) 'photo_url': request.photoUrl,
    };

    final response = await _client.post('/api/v1/users', body: body);

    final data = response['data'] ?? response;
    return TPSUser.fromJson(data);
  }

  Future<TPSUser?> getUserByFirebaseId(String firebaseId) async {
    try {
      final response = await _client.get('/api/v1/users/firebase/$firebaseId');
      final data = response['data'] ?? response;
      return TPSUser.fromJson(data);
    } catch (e) {
      return null;
    }
  }

  Future<bool> createDbUserIfNotExists(User user) async {
    try {
      final dbUser = await getUserByFirebaseId(user.uid);
      if (dbUser == null) {
        final displayName = user.displayName ?? "User";
        final nameParts = displayName.split(" ");
        final firstName = nameParts.first;
        final lastName = nameParts.length > 1
            ? nameParts.sublist(1).join(" ")
            : "";

        await createUser(
          CreateUserRequest(
            email: user.email,
            firebaseId: user.uid,
            firstName: firstName,
            lastName: lastName,
            mobile: user.phoneNumber,
            photoUrl: user.photoURL,
          ),
        );
      }
      return true;
    } catch (error) {
      return false;
    }
  }
}
