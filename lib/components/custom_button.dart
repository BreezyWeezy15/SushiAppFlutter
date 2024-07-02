import 'package:flutter/material.dart';

import 'colors.dart';
import 'fonts.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final bool isArrow;
  final Function() onTap;
  const CustomButton({super.key,required this.text,required this.isArrow,
  required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color:  const Color(buttonColor)
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,style: getSerifFont().copyWith(fontSize: 20,color: Colors.white)),
            const SizedBox(width: 5,),
            isArrow ?  const Icon(Icons.arrow_forward,size: 25,color: Colors.white,) : Container()
          ],
        ),
      ),
    );
  }
}
