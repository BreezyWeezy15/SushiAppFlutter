
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

    var docID = DateTime.now().microsecondsSinceEpoch.toString();

    Map<String,dynamic> order = {};

    order['docID'] = docID;
    order['isConfirmed'] = false;
    order['orderID'] = '#${DateTime.now().microsecondsSinceEpoch}';
    order['date'] = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    order['receipt'] = receipt;
    _collectionReference.collection('Orders')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('Receipts')
        .doc(docID)
        .set(order);
  }

  Future<List<Map<String, dynamic>>> getCoupons() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _collectionReference.collection('coupons').get();
    List<Map<String, dynamic>> coupons = snapshot.docs.map((doc) => doc.data()).toList();
    return coupons;
  }

  Future addUserCoupon(String coupon,String percent) async {

    var map = <String,dynamic>{};
    map['coupon'] = coupon;
    map['percent'] = percent;

    return _collectionReference.collection('UserCoupons').doc(firebaseAuth.currentUser!.uid)
        .set(map);
  }

  Future getUserCoupons(String coupon) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =  await _collectionReference.collection('UserCoupons').get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Stream<List<Map<String, dynamic>>> getOrders() {
    return _collectionReference
        .collection('Orders')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('Receipts')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Future deleteOrder(String docID) async {
    return await _collectionReference
        .collection('Orders')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('Receipts')
        .doc(docID)
        .delete();
  }

  Future updateStatus(String docID, bool isConfirmed) async {

    
    await _collectionReference.collection('Orders')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('Receipts')
        .doc(docID)
        .update({'isConfirmed' : isConfirmed});


  }

  DatabaseService._privateConstructor();
  static DatabaseService instance = DatabaseService._privateConstructor();


}