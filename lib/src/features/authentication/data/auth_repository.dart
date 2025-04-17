import 'dart:async';

import 'package:e_shop/src/features/authentication/domain/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  AuthRepository(this._firebaseAuth);

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Stream<AppUser?> authStateChanges() {
    return _firebaseAuth.authStateChanges().map(_convertUser);
  }

  AppUser? get currentUser => _convertUser(_firebaseAuth.currentUser);

  AppUser? _convertUser(User? user) {
    if (user != null) {
      return AppUser(
        uid: user.uid,
        email: user.email,
        emailVerified: user.emailVerified,
      );
    }
    return null;
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepository(FirebaseAuth.instance);
}

// * Using keepAlive since other providers need it to be an
// * [AlwaysAliveProviderListenable]
@Riverpod(keepAlive: true)
Stream<AppUser?> authStateChanges(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
}
