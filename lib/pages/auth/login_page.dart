import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sushi_restaurant/components/colors.dart';
import 'package:sushi_restaurant/components/custom_button.dart';
import 'package:sushi_restaurant/components/custom_text_field.dart';
import 'package:sushi_restaurant/components/fonts.dart';
import 'package:sushi_restaurant/main.dart';
import 'package:sushi_restaurant/pages/ui/home_page.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key,required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();


  void login() async {
    String email = _emailController.text.toString();
    String password = _passController.text.toString();

    if(email.isEmpty){
      Fluttertoast.showToast(msg: 'Email cannot be empty');
      return;
    }
    if(password.isEmpty){
      Fluttertoast.showToast(msg: 'Password cannot be empty');
      return;
    }
    if(password.length < 6){
      Fluttertoast.showToast(msg: 'Password cannot be less 6');
      return;
    }

     try {
        await firebaseService.loginUser(email, password);
        if(mounted){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
        }
     } catch(e){
       Fluttertoast.showToast(msg: e.toString());
     }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(backgroundColor),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/sushi_man.png",width: 300,height: 300,),
              Text('Sign in to order your best sushi',style: getSerifFont().copyWith(fontSize: 20,
              color: Colors.white)),
              const SizedBox(height: 30,),
              // login text fields
              CustomTextField(hint: 'Email', iconData: Icons.email, controller: _emailController, obsecureText: false),
              CustomTextField(hint: 'Password', iconData: Icons.password, controller: _passController, obsecureText: true),
              const SizedBox(height: 30,),
              
              
              // register / login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No Account!',style: getSerifFont().copyWith(fontSize: 20,color: Colors.white54),),
                  const SizedBox(width: 10,),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text('Sign Up',style: getFont().copyWith(fontSize: 20,color: Colors.white),),
                  )
                ],
              ),

              const SizedBox(height: 30,),
              // sign in button
              CustomButton(text: 'Sign In', isArrow: false, onTap: login)
            ],
          ),
        ),
      ),
    );
  }
}
