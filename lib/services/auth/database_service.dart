


import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final CollectionReference _collectionReference = FirebaseFirestore.instance.collection('Food');
  final List<DocumentSnapshot> _docs = [];

  Future<List<DocumentSnapshot>> getFood(String query) async {

    QuerySnapshot result = await _collectionReference.get();
    _docs.clear();

    if(query.isNotEmpty){
      var data = result.docs.where((doc){
        String title = doc['title'].toString().toLowerCase();
        return title.contains(query.toString().toLowerCase());
      }).toList();
      _docs.addAll(data);
    } else {
      _docs.addAll(result.docs);
    }

    return _docs;

  }

  Future<DocumentSnapshot<Object?>> getFoodDetails(String documentID) async {
    Future<DocumentSnapshot<Object?>> result = _collectionReference.doc(documentID).get();
    return result;
  }



  DatabaseService._privateConstructor();
  static DatabaseService instance = DatabaseService._privateConstructor();




}