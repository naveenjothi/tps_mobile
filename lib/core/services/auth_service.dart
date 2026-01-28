import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/logger.dart';

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
      TPSLogger.debug('Starting Google Sign-In...', tag: 'AuthService');
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        TPSLogger.debug(
          'Google Sign-In was cancelled by user',
          tag: 'AuthService',
        );
        throw Exception('Google Sign-In was cancelled');
      }

      TPSLogger.debug('Google user: ${googleUser.email}', tag: 'AuthService');

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      TPSLogger.debug('Got Google auth tokens', tag: 'AuthService');

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      TPSLogger.debug('Signing in to Firebase...', tag: 'AuthService');
      final result = await _auth.signInWithCredential(credential);
      TPSLogger.debug(
        'Firebase sign-in successful: ${result.user?.email}',
        tag: 'AuthService',
      );
      return result;
    } catch (e, stackTrace) {
      TPSLogger.error(
        'Error during Google Sign-In',
        error: e,
        stackTrace: stackTrace,
        tag: 'AuthService',
      );
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
