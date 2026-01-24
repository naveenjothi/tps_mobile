import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// TPS Authentication Service
///
/// Handles Firebase Authentication with Google Sign-In.
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Get the current authenticated user.
  User? get currentUser => _auth.currentUser;

  /// Stream of auth state changes.
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Check if user is authenticated.
  bool get isAuthenticated => currentUser != null;

  /// Sign in with Google.
  ///
  /// Returns the [UserCredential] on success, or throws an exception on failure.
  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      print('[AuthService] Starting Google Sign-In...');
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        print('[AuthService] Google Sign-In was cancelled by user');
        throw Exception('Google Sign-In was cancelled');
      }

      print('[AuthService] Google user: ${googleUser.email}');

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      print('[AuthService] Got Google auth tokens');

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      print('[AuthService] Signing in to Firebase...');
      final result = await _auth.signInWithCredential(credential);
      print('[AuthService] Firebase sign-in successful: ${result.user?.email}');
      return result;
    } catch (e, stackTrace) {
      print('[AuthService] Error during Google Sign-In: $e');
      print('[AuthService] Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Sign out from both Firebase and Google.
  Future<void> signOut() async {
    await Future.wait([_auth.signOut(), _googleSignIn.signOut()]);
  }

  /// Get the Firebase ID token for API authentication.
  ///
  /// Returns null if no user is signed in.
  Future<String?> getIdToken() async {
    final user = currentUser;
    if (user == null) return null;
    return await user.getIdToken();
  }
}
