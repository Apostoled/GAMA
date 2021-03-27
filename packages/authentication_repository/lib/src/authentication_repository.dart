import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

import 'models/models.dart';

// Выдается, если во время процесса регистрации происходит сбой.
class SignUpFailure implements Exception {}

// Выдается во время процесса входа в систему, если происходит сбой.
class LogInWithEmailAndPasswordFailure implements Exception {}

// Выдается во время входа в систему с помощью Google Flow, если происходит сбой.
class LogInWithGoogleFailure implements Exception {}

// Выдается во время выхода из системы в случае сбоя.
class LogOutFailure implements Exception {}

// Репозиторий, который управляет аутентификацией пользователей.
class AuthenticationRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthenticationRepository({
    firebase_auth.FirebaseAuth firebaseAuth,
    GoogleSignIn googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

// Поток [User], который выдаст текущего пользователя, когда состояние аутентификации меняется.
// Выдает [User.empty], если пользователь не аутентифицирован.
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null ? User.empty : firebaseUser.toUser;
    });
  }

// Создает нового пользователя с указанными [адрес электронной почты] и [пароль].
// Выбрасывает [SignUpFailure], если возникает исключение.
  Future<void> signUp({
    @required String email,
    @required String password,
  }) async {
    assert(email != null && password != null);
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on Exception {
      throw SignUpFailure();
    }
  }

// Запускает вход с помощью Google Flow.
// Выбрасывает [LogInWithGoogleFailure], если возникает исключение.
  Future<void> logInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser.authentication;
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
    } on Exception {
      throw LogInWithGoogleFailure();
    }
  }

// Входит в систему, используя указанные [email] и [password].
// Выбрасывает [LogInWithEmailAndPasswordFailure], если возникает исключение.
  Future<void> SignUP({
    @required String email,
    @required String password,
  }) async {
    assert(email != null && password != null);
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on Exception {
      throw LogInWithEmailAndPasswordFailure();
    }
  }

// Выводит текущего пользователя, который будет выдавать [User.empty] из потока [user].
// Выбрасывает [LogOutFailure], если возникает исключение.
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } on Exception {
      throw LogOutFailure();
    }
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
