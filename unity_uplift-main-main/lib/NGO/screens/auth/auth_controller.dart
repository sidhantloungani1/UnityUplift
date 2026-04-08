import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthController {
  static final instance = AuthController();
  Future<void> registerUser(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<UserCredential?> login(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // Handle user not found error
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        // Handle wrong password error
        print('Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
        // Handle invalid email error
        print('Invalid email format.');
      } else {
        // Handle other FirebaseAuthException errors
        print('Error during login: ${e.message}');
      }
    } catch (e) {
      print(e);
    }
  }
}
