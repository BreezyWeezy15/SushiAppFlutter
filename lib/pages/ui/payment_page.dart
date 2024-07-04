import 'package:flutter/material.dart';
import 'package:sushi_restaurant/components/custom_text_field.dart';
import 'package:sushi_restaurant/components/fonts.dart';


class PaymentPage extends StatefulWidget {
  final double totalPrice;
  const PaymentPage({super.key, required this.totalPrice});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _zipCode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text('Delivery Information',style: getSerifFont().copyWith(fontSize: 20),),
            CustomTextField(hint: 'Full Name', iconData: Icons.person,
                controller: _fullName, obsecureText: false),
            CustomTextField(hint: 'Email', iconData: Icons.email,
                controller: _email, obsecureText: false),
            CustomTextField(hint: 'Phone', iconData: Icons.phone,
                controller: _phone, obsecureText: false),
            CustomTextField(hint: 'City', iconData: Icons.location_history_outlined,
                controller: _city, obsecureText: false),
            CustomTextField(hint: 'Address', iconData: Icons.location_on_sharp,
                controller: _address, obsecureText: false),
            CustomTextField(hint: 'Zip Code', iconData: Icons.location_history_outlined,
                controller: _zipCode, obsecureText: false)
          ],
        ),
      ),
    );
  }
}
