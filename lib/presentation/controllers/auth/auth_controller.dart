// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison, prefer_typing_uninitialized_variables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:grootan_task_app/app/utils/reusable.dart';
import 'package:grootan_task_app/presentation/views/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  ///
  FirebaseAuth auth = FirebaseAuth.instance;

  ///
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  ///
  String? _isSignedUserID;
  String get isSignedUserID => _isSignedUserID!;

  ///
  String? _isSignedDate;
  String get isSignedDate => _isSignedDate!;

  @override
  void onInit() async {
    super.onInit();
    await checkSignIn();
  }

  ///
  checkSignIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _isSignedIn = prefs.getBool("is_SignedIn") ?? false;
    _isSignedUserID = prefs.getString("signedIn_UserID");
    _isSignedDate = prefs.getString("last_signIn");
    update();
  }

  ///
  void setSignInUser(String uid) async {
    final now = DateTime.now();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("is_SignedIn", true);
    prefs.setString("signedIn_UserID", uid);

    ///
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    String date = dateFormat.format(now);
    prefs.setString("last_signIn", date);
    _isSignedDate = date;

    update();
  }

  ///Phone Number
  void signInWithPhone(BuildContext context,
      {required String phoneNumber, required Function(String) verifyId}) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: "+91$phoneNumber",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          isErrorSnackBar(context, message: e.toString());
          throw Exception(e.message);
        },
        codeSent: (String verificationId, int? resendToken) {
          verifyId(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      isErrorSnackBar(context, message: e.toString());
    }
  }

  ///Verify Otp
  void verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOtP,
    required Function onSuccess,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtP);

      User? user = (await auth.signInWithCredential(credential)).user;
      if (user != null) {
        _isSignedUserID = user.uid;
        setSignInUser(user.uid);
        update();
        onSuccess();
      } else {}
    } on FirebaseAuthException catch (e) {
      isErrorSnackBar(context, message: e.toString());
    }
  }

  ///Logout
  void logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("is_SignedIn");
    prefs.remove("signedIn_UserID");
    await checkSignIn();
    update();
    Get.offAll(const LoginPage());
  }
}
