import 'package:cloud_firestore/cloud_firestore.dart';

class WoModel {
  String? id;
  String dept;
  String requestor;
  String date;
  String classification;
  String device;
  String trouble;
  String treatment;
  int duration;
  String pic;
  String status;
  String remarks;
  Timestamp? createdAt;

  WoModel({
    this.id,
    required this.dept,
    required this.requestor,
    required this.date,
    required this.classification,
    required this.device,
    required this.trouble,
    required this.treatment,
    required this.duration,
    required this.pic,
    required this.status,
    required this.remarks,
    this.createdAt,
  });

  //membuat wo dari DocumentSnapshot Firebase
  factory WoModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return WoModel(
      id: snapshot.id,
      dept: data['dept'] as String,
      requestor: data['requestor'] as String,
      date: data['date'] as String,
      classification: data['classification'] as String,
      device: data['device'] as String,
      trouble: data['trouble'] as String,
      treatment: data['treatment'] as String,
      duration: data['duration'] as int,
      pic: data['pic'] as String,
      status: data['status'] as String,
      remarks: data['remarks'] as String,
      createdAt: data['createdAt'] as Timestamp?,
    );
  }

  //membuat Map untuk dikirim ke firebase
  Map<String, dynamic> toMap() {
    return {
      'dept': dept,
      'requestor': requestor,
      'date': date,
      'classification': classification,
      'device': device,
      'trouble': trouble,
      'treatment': treatment,
      'duration': duration,
      'pic': pic,
      'status': status,
      'remarks': remarks,
      'createdAt': createdAt ?? Timestamp.now(),
    };
  }
}
