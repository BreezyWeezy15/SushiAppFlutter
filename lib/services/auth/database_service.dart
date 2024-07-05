


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class DatabaseService {

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _collectionReference = FirebaseFirestore.instance;
  final List<DocumentSnapshot> _docs = [];

  Future<List<DocumentSnapshot>> getFood(String query) async {

    QuerySnapshot result = await _collectionReference.collection('Food').get();
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
    Future<DocumentSnapshot<Object?>> result = _collectionReference.collection('Food').doc(documentID).get();
    return result;
  }

  saveOrder(String receipt) async {
    Map<String,dynamic> order = {};
    order['orderID'] = '#${DateTime.now().microsecondsSinceEpoch}';
    order['date'] = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    order['receipt'] = receipt;
    _collectionReference.collection('Orders')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('Receipts')
        .doc(DateTime.now().microsecondsSinceEpoch.toString())
        .set(order);
  }

  Future<List<Map<String, dynamic>>> getOrders() async {


    List<Map<String, dynamic>> listOfMaps = [];

    QuerySnapshot<Map<String, dynamic>> snapshot = await _collectionReference.collection('Orders')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('Receipts')
        .get();

    for (var doc in snapshot.docs) {
      // Add the document data to the list
      listOfMaps.add(doc.data());
    }

    return listOfMaps;


  }


  DatabaseService._privateConstructor();
  static DatabaseService instance = DatabaseService._privateConstructor();




}