import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:information_technology/models/wo_model.dart';

class WoFirebase {
  final CollectionReference woCollection = FirebaseFirestore.instance
      .collection('work_order');

  // membuat WO baru dan mengambil data dari model
  Future<void> addWO(WoModel woModel) async {
    await woCollection.add(woModel.toMap());
  }

  //membaca item berdasarkan ID
  Future<WoModel?> getWO(String id) async {
    final docSnapshot = await woCollection.doc(id).get();
    if (docSnapshot.exists) {
      return WoModel.fromSnapshot(docSnapshot);
    }
    return null;
  }

  //membaca semua wWO realtime
  Stream<List<WoModel>> getAllWO() {
    return woCollection.orderBy('createdAt', descending: true).snapshots().map((
      snapshot,
    ) {
      return snapshot.docs.map((doc) => WoModel.fromSnapshot(doc)).toList();
    });
  }

  //update WO
  Future<void> updateWO(WoModel woModel) async {
    await woCollection.doc(woModel.id).update(woModel.toMap());
  }

  //delete WO
  Future<void> deleteWO(String id) async {
    await woCollection.doc(id).delete();
  }
}
