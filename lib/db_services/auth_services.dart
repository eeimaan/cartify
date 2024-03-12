import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_application_1/constants/constants.dart';

class AuthServices {
  static Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          SnackBarHelper.showSnackBar(
            context,
            'Sign-in with Google canceled.',
          );
        });

        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      //   Navigator.pushNamedAndRemoveUntil(
      //       context, AppRoutes.bottomNavigationScreen, (route) => false);
      // });

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      return null;
    }
  }

  static User? get getCurrentUser {
    return FirebaseAuth.instance.currentUser;
  }

  static Future<void> signUp(
      {required String email, required String password}) async {
    try {
     
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // String? fcmToken = await FirebaseMessaging.instance.getToken();
      // await saveFCMTokenToFirebase(userCredential.user!.uid, fcmToken!);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  static Future<void> saveFCMTokenToFirebase(
      String userId, String fcmToken) async {
    await FirebaseFirestore.instance
        .collection('user_profiles')
        .doc(userId)
        .set({'fcm_token': fcmToken}, SetOptions(merge: true));
  }

  static Future<void> logIn(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

     // String? fcmToken = await FirebaseMessaging.instance.getToken();
     // log(' fcm token ..................$fcmToken');
     // await saveFCMTokenToFirebase(AuthServices.getCurrentUser!.uid, fcmToken!);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  static Future<bool> fetchUserUidDetails({required String uid}) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      DocumentSnapshot<Map<String, dynamic>> userDetailsDoc =
          await firestore.collection('user_profiles').doc(uid).get();

      return userDetailsDoc.exists;
    } on FirebaseException catch (error) {
      log('FirebaseException occurred: $error');
      rethrow;
    }
  }
  // static Future<UserCredential> signInWithGoogle() async {
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  static Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut().then((value) async {
      return await GoogleSignIn().signOut();
    }).then((value) {
      log('current user logout: ${FirebaseAuth.instance.currentUser?.uid}');
      return Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.startPage,
        (route) => false,
      );
    });
  }

  static Future<void> signOutfirebase(BuildContext context) async {
    await FirebaseAuth.instance.signOut().then((value) async {}).then((value) {
      log('current user logout: ${FirebaseAuth.instance.currentUser?.uid}');
      return Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.startPage,
        (route) => false,
      );
    });
  }

  static Future<String> storeProfileImage(File image) async {
    try {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('profile_images/${DateTime.now().millisecondsSinceEpoch}');
      UploadTask uploadTask = storageReference.putFile(image);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      FirebaseFirestore firestore = FirebaseFirestore.instance;

      DocumentReference documentref = firestore
          .collection('user_profiles')
          .doc(AuthServices.getCurrentUser!.uid);

      await documentref.update({'photo_url': imageUrl});

      return imageUrl;
    } catch (e) {
      log('Error storing profile image: $e');
      rethrow;
    }
  }

  static Future<void> updateProfileImage(File image) async {
    try {
      String imageUrl = await storeProfileImage(image);

      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.updatePhotoURL(imageUrl);
        await user.reload();
       
        user = FirebaseAuth.instance.currentUser;
        log('User profile image updated');
      }
    } catch (e) {
      log('Error updating profile image: $e');
    }
  }

  static Future<void> fetchCurrentUserDetails() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String? imageUrl = user.photoURL;
        String? email = user.email;
        String? username = user.displayName;

        if (username != null) {
          log('User Name $username');
        } else {
          log('User name.');
        }
        if (imageUrl != null) {
          log('User profile image URL: $imageUrl');
        } else {
          log('User does not have a profile image.');
        }
        if (email != null) {
          log('User email: $email');
        } else {
          log('User email not available.');
        }
      } else {
        log('No user is currently logged in.');
      }
    } catch (e) {
      log('Error fetching current user details: $e');
    }
  }
}
