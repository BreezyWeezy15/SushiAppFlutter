import 'package:flutter/material.dart';
import 'package:sushi_restaurant/components/fonts.dart';


class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData iconData;
  final TextEditingController controller;
  final bool obsecureText;
  const CustomTextField({super.key,required this.hint,
  required this.iconData,required this.controller,required this.obsecureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        obscureText: obsecureText,
        style: getFont().copyWith(color: Colors.white),
        decoration: InputDecoration(
            prefixIcon: Icon(iconData,color: Colors.white,),
            hintText: hint,
            hintStyle: getSerifFont().copyWith(fontSize: 15,color: Colors.white),
            helperStyle: getSerifFont().copyWith(fontSize: 15,color: Colors.white),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.black45)
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white54)
            )
        ),
      ),
    );
  }

}


