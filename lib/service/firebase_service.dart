import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_exam_2/modal/modal.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDataService {
  FirebaseDataService._();

  static final FirebaseDataService firebaseDataService =
      FirebaseDataService._();
  User? user = FirebaseAuth.instance.currentUser;

  Future addDataToFireStore(ExpanseModal expanse) async {
    try {
      await FirebaseFirestore.instance
          .collection("expanse")
          .doc(user!.email)
          .collection("expanseData")
          .add(expanse.toMap());
      print('Document Added');
    } catch (e) {
      print("Error occur During the Data Addition in Firebase : $e");
    }
  }

  Stream<QuerySnapshot> readDataFromFireStore() async* {
    try {
      var userdata = await FirebaseFirestore.instance
          .collection("expanse")
          .doc(user!.email)
          .collection("expanseData")
          // .orderBy('name')
          .snapshots();
      yield* userdata;
    } catch (e) {
      print(e.toString());
    }
  }
}
