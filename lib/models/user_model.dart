import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoURL;
  final DateTime lastSignIn;

  UserModel({
    required this.uid,
    this.email,
    this.displayName,
    this.photoURL,
    required this.lastSignIn,
  });

  factory UserModel.fromFirebase(User user) {
    return UserModel(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoURL: user.photoURL,
      lastSignIn: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'email': email,
    'displayName': displayName,
    'photoURL': photoURL,
    'lastSignIn': lastSignIn.toIso8601String(),
  };
}