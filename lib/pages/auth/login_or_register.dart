import 'package:flutter/material.dart';
import 'package:sushi_restaurant/pages/auth/login_page.dart';
import 'package:sushi_restaurant/pages/auth/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {

  bool showLogin = true;



  void getLogin(){
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLogin == true){
      return  LoginPage(onTap: getLogin,);
    } else {
      return RegisterPage(onTap: getLogin,);
    }
  }
}
