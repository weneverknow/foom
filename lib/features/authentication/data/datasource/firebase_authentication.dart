import 'package:firebase_auth/firebase_auth.dart';
import 'package:foom/core/exceptions/exceptions.dart';

abstract class FirebaseAuthentication {
  User? get currentUser;
  Future<void> signOut();
  Future<User?> signInWithEmail(
      {required String email, required String password});
  Stream<User?> authStateChange();
  Future<User?> createAccountWithEmail({
    required String email,
    required String password,
  });

  Future<void> updateDisplayName(String name);
}

class FirebaseAuthenticationImpl implements FirebaseAuthentication {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User?> signInWithEmail(
      {required String email, required String password}) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthenticationException(e.message ?? "User not found");
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Stream<User?> authStateChange() {
    return _firebaseAuth.authStateChanges();
  }

  @override
  Future<User?> createAccountWithEmail(
      {required String email, required String password}) async {
    final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    return result.user;
  }

  @override
  Future<void> updateDisplayName(String name) async {
    await _firebaseAuth.currentUser?.updateDisplayName(name);
  }
}
