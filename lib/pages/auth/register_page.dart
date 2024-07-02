import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sushi_restaurant/main.dart';

import '../../components/colors.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text_field.dart';
import '../../components/fonts.dart';
import '../ui/home_page.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key,required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  void registerUser() async {
    String email = _emailController.text.toString();
    String pass = _passController.text.toString();
    String confirmPass = _confirmPassController.text.toString();

    if(email.isEmpty){
      Fluttertoast.showToast(msg: 'Email cannot be empty');
      return;
    }
    if(pass.isEmpty){
      Fluttertoast.showToast(msg: 'Password cannot be empty');
      return;
    }
    if(confirmPass.isEmpty){
      Fluttertoast.showToast(msg: 'Confirm Password cannot be empty');
      return;
    }
    if(pass != confirmPass){
      Fluttertoast.showToast(msg: 'Passwords do not match');
      return;
    }


    try {
      await firebaseService.registerUser(email, pass);
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
        backgroundColor:  const Color(backgroundColor),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/sushi_man.png",width: 300,height: 300,),
                Text('Create an account to enjoy ordering sushi',style: getSerifFont().copyWith(fontSize: 20,
                    color: Colors.white)),
                const SizedBox(height: 30,),
                // login text fields
                CustomTextField(hint: 'Email', iconData: Icons.email, controller: _emailController, obsecureText: false),
                CustomTextField(hint: 'Password', iconData: Icons.password, controller: _passController, obsecureText: true),
                CustomTextField(hint: 'Confirm Password', iconData: Icons.password, controller: _confirmPassController, obsecureText: true),
                const SizedBox(height: 30,),


                // register / login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Have Account!',style: getSerifFont().copyWith(fontSize: 20,color: Colors.white54),),
                    const SizedBox(width: 10,),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text('Sign In',style: getFont().copyWith(fontSize: 20,color: Colors.white),),
                    )
                  ],
                ),

                const SizedBox(height: 30,),
                // sign in button
                CustomButton(text: 'Sign Up', isArrow: false, onTap: registerUser)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
