


import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final CollectionReference _collectionReference = FirebaseFirestore.instance.collection('Food');


  Future<QuerySnapshot<Object?>> getFood() async {
    Future<QuerySnapshot<Object?>> result = _collectionReference.get();
    return result;
  }

  DatabaseService._privateConstructor();
  static DatabaseService instance = DatabaseService._privateConstructor();

}