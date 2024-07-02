import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sushi_restaurant/pages/auth/login_or_register.dart';
import 'package:sushi_restaurant/pages/ui/home_page.dart';


class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapShot){
          if(snapShot.hasData){
            return const HomePage();
          } else {
            return const LoginOrRegister();
          }
        });
  }
}
