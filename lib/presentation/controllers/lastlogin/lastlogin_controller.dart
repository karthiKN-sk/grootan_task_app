import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

import '../../../data/models/number_gen_model.dart';

class LastLoginController extends GetxController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

// fetchAllData({
//     required String userID,
//   }){

// List<NumGenerateModel> data =readAllData(userID: userID);

// }

  Stream<List<NumGenerateModel>> readAllData({
    required String userID,
  }) {
    final getData = _firebaseFirestore.collection(userID).snapshots();

    return getData.map(
      (event) => event.docs
          .map(
            (e) => NumGenerateModel.fromJson(
              e.data(),
            ),
          )
          .toList(),
    );
  }
}
