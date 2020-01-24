import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class Auth {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> handleGoogleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    print("google signed in " + user.displayName);
    return user;
  }

  Future<FirebaseUser> handleEmailSignIn(String email, String password) async {
    // print(email + password);
    try {
      final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      print("email signed in " + user.displayName);
      return user;
    } catch (error) {
      List<String> errors = error.toString().split(',');
      print("Error: " + errors[1]);
      throw errors[1];
    }
  }

  Future<void> forgotPassword(String email) async {
    // print(email + password);
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (error) {
      // List<String> errors = error.toString().split(',');
      print("Error forgotPassword: " + error);
      // throw errors[1];
    }
  }

  Future<FirebaseUser> handleEmailSignUp(String email, String password) async {
    // print(email + password);
    try {
      final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      print("email signed up " + user.displayName);
      return user;
    } on PlatformException catch (e) {
      // if (e.message == 'ERROR_EMAIL_ALREADY_IN_USE'){
      //   print(e.message);
      // }
      throw e.message;
    } catch (error) {
      // List<String> errors = error.toString().split(',');
      // print("Error: " + error);
      throw error.message;
    }
  }

  Future<Null> handlePhone(String phone, lcontext) async {
    // print(email + password);
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phone,
          timeout: Duration(seconds: 120),
          forceResendingToken: 3,
          verificationCompleted: (AuthCredential authCredential) {
            print('authCredential');
            print(authCredential);
            // Navigator.pushReplacementNamed(lcontext, '/home');
          },
          verificationFailed: (AuthException e) {
            print('Error : '+e.message);
            // Navigator.pushReplacementNamed(lcontext, '/home');
          },
          codeSent: (String verificationId, [int forceResendingToken]) {
            print('verificationId - ' +
                verificationId +
                ', forceResendingToken - ');
            print(forceResendingToken);
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            print('codeAutoRetrievalTimeout');
          });
      print("verification code sent to - " + phone);
      // return user;
    } on PlatformException catch (e) {
      // if (e.message == 'ERROR_EMAIL_ALREADY_IN_USE'){
      //   print(e.message);
      // }
      throw e.message;
    } catch (error) {
      // List<String> errors = error.toString().split(',');
      // print("Error: " + error);
      throw error.message;
    }
  }
  // Widget _redirectIfLoggedIn(BuildContext context) {
  //   final Future<FirebaseUser> userr = _auth.currentUser();
  //   if (userr != null) {
  //     Navigator.pop(context);
  //   }
  // }

}
