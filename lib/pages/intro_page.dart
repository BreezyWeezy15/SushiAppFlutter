import 'package:flutter/material.dart';
import 'package:sushi_restaurant/components/colors.dart';
import 'package:sushi_restaurant/components/custom_button.dart';
import 'package:sushi_restaurant/components/fonts.dart';
import 'package:sushi_restaurant/pages/auth/login_or_register.dart';
import 'package:sushi_restaurant/pages/auth/login_page.dart';
import 'package:sushi_restaurant/storage/storage_helper.dart';


class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(backgroundColor),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SUSHI MAN',
                        style: getFont().copyWith(fontSize: 35, color: Colors.white),
                      ),
                      Center(
                        child: Image.asset(
                          'assets/images/sushi_man.png',
                          width: 400,
                          height: 400,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        'THE TASTE OF JAPANESE FOOD',
                        style: getFont().copyWith(fontSize: 55, color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                        style: getSerifFont().copyWith(fontSize: 17, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              SizedBox(
                height: 50,
                child: CustomButton(
                  text: 'Get Started',
                  isArrow: true,
                  onTap: () {
                    StorageHelper.setStarted();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginOrRegister()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
