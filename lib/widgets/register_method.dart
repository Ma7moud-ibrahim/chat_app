import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> registerMethod(
  BuildContext context,
  String? email,
  password,
) async {
  UserCredential userCredential = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email!, password: password!);
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text('Account created successfully')));
}
