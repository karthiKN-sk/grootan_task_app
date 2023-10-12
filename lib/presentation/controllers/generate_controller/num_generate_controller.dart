// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/utils/reusable.dart';
import '../../../data/models/number_gen_model.dart';

class NumGenerateController extends GetxController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  ///Post Details
  void sendDetails({
    required BuildContext context,
    required String userID,
    required String idGenerator,
    required String ipAddress,
    required String location,
  }) async {
    try {
      final postdetail = _firebaseFirestore.collection(userID).doc();
      final generateValue = NumGenerateModel(
        id: postdetail.id,
        date: DateTime.now().toString(),
        generatedNum: idGenerator,
        ipAddress: ipAddress,
        location: location,
      );
      await postdetail.set(generateValue.toJson());
      isSuccessSnackBar(context, message: "Data Posted Successfully");
    } on FirebaseException catch (e) {
      isErrorSnackBar(context, message: e.toString());
    }
  }
}
