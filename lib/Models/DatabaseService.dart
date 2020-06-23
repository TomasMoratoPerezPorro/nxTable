import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference usuarisCollection =
      Firestore.instance.collection('Usuaris');
  final DocumentReference refComunitat =
      Firestore.instance.document('Comunitat/ePxrAIn3mpLvfJBvBKtZ');
  Future<void> updateUserData(String name) async {
    return await usuarisCollection.document(uid).setData({
      'Name': name,
    });
  }
}
