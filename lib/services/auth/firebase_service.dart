import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  User? isLogged(){
    return _firebaseAuth.currentUser;
  }
  Future<UserCredential> loginUser(String email,String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    }
    on FirebaseAuthException catch(e){
      throw Exception(e);
    }
  }
  Future<UserCredential> registerUser(String email,String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    }
    on FirebaseAuthException catch(e){
      throw Exception(e);
    }
  }
  FirebaseService._privateConstructor();
  static FirebaseService instance = FirebaseService._privateConstructor();


}