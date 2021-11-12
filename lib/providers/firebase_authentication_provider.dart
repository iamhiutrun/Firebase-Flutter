import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthentication extends ChangeNotifier {
  final gooSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;

  Stream<User?> get currentUser => _auth.authStateChanges();

  Future<void> googleSignIn() async {
    final googleUser = await gooSignIn.signIn();
    if (googleUser == null) return;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _auth.signInWithCredential(credential);

    notifyListeners();
  }

  Future<void> logOut() async => await _auth.signOut();
}
