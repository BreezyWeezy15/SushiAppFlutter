import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sushi_restaurant/db/sushi_database.dart';
import 'package:sushi_restaurant/pages/auth/auth_gate.dart';
import 'package:sushi_restaurant/pages/auth/login_or_register.dart';
import 'package:sushi_restaurant/pages/intro_page.dart';
import 'package:sushi_restaurant/services/auth/database_service.dart';
import 'package:sushi_restaurant/services/auth/firebase_service.dart';
import 'package:sushi_restaurant/storage/storage_helper.dart';

SushiDatabase sushiDatabase = SushiDatabase.instance;
FirebaseService firebaseService = FirebaseService.instance;
DatabaseService databaseService = DatabaseService.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyB9cJkWusDjUTyeE4r1fCEq5J1fqkTo3Fs',
        appId: '1:686368284993:android:92111687722fd98c5c81c0',
        messagingSenderId: '686368284993',
        projectId: 'sushi-6533d')
  );
  await GetStorage.init();
  runApp(const MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if(StorageHelper.isStarted()){
      return const AuthGate();
    } else {
      return const IntroPage();
    }
  }
}


