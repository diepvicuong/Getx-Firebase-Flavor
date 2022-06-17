import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:twitter_login/twitter_login.dart';

import '../utils/logger.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static get userId => _auth.currentUser?.uid;

  //SIGN UP METHOD
  Future<User?> signUp(
      {required String email, required String password}) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }

  //SIGN IN METHOD
  Future<User?> signIn(
      {required String email, required String password}) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      // Disconenct
      final isSignedIn = await GoogleSignIn().isSignedIn();
      if (isSignedIn) {
        await GoogleSignIn().disconnect();
      }
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      if (googleAuth?.accessToken == null || googleAuth?.idToken == null) {
        return null;
      }
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential.user;
    } catch (exc) {
      print(exc.toString());
      rethrow;
    }
  }

  Future<User?> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken?.token ?? '');

      // Once signed in, return the UserCredential
      final userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      return userCredential.user;
    } catch (exc) {
      MyLogger.d(exc.toString());
      rethrow;
    }
  }

  Future<User?> signInWithTwitter() async {
    try {
      const twitterApiKey =
          String.fromEnvironment('TWITTER_API_KEY', defaultValue: '');
      const twitterApiSecret =
          String.fromEnvironment('TWITTER_API_SECRET', defaultValue: '');
      const twitterHost =
          String.fromEnvironment('TWITTER_HOST', defaultValue: '');
      const twitterScheme =
          String.fromEnvironment('TWITTER_SCHEME', defaultValue: '');

      // Create a TwitterLogin instance
      final twitterLogin = TwitterLogin(
        apiKey: twitterApiKey,
        apiSecretKey: twitterApiSecret,
        redirectURI: Platform.isAndroid
            ? 'https://${twitterHost}/__/auth/handler'
            : '${twitterScheme}://',
      );

      // Trigger the sign-in flow
      final authResult = await twitterLogin.login();

      // Create a credential from the access token
      if (authResult.authToken == null || authResult.authTokenSecret == null) {
        return null;
      }
      final twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: authResult.authToken!,
        secret: authResult.authTokenSecret!,
      );

      // Once signed in, return the UserCredential
      final userCredential = await FirebaseAuth.instance
          .signInWithCredential(twitterAuthCredential);
      return userCredential.user;
    } catch (exc) {
      MyLogger.d(exc.toString());
      rethrow;
    }
  }

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<User?> signInWithApple() async {
    try {
      // To prevent replay attacks with the credential returned from Apple, we
      // include a nonce in the credential request. When signing in with
      // Firebase, the nonce in the id token returned by Apple, is expected to
      // match the sha256 hash of `rawNonce`.
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      // Sign in the user with Firebase. If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      return userCredential.user;
    } catch (exc) {
      MyLogger.d(exc.toString());
      rethrow;
    }
  }

  //SIGN OUT METHOD
  static Future signOut() async {
    await _auth.signOut();
    // MySharedPreferences.instance.deleteUser();

    MyLogger.d('signout: ${_auth.currentUser}');
  }
}
