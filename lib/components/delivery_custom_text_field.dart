import 'package:flutter/material.dart';
import 'package:sushi_restaurant/components/fonts.dart';


class DeliveryCustomTextField extends StatelessWidget {
  final String hint;
  final IconData iconData;
  final TextEditingController controller;
  const DeliveryCustomTextField({super.key,required this.hint,
  required this.iconData,required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        style: getFont().copyWith(color: Colors.black),
        decoration: InputDecoration(
            prefixIcon: Icon(iconData,color: Colors.black,),
            hintText: hint,
            hintStyle: getSerifFont().copyWith(fontSize: 15,color: Colors.black),
            helperStyle: getSerifFont().copyWith(fontSize: 15,color: Colors.black),
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


