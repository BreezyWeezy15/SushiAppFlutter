import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sushi_restaurant/components/colors.dart';
import 'package:sushi_restaurant/components/custom_text_field.dart';
import 'package:sushi_restaurant/components/fonts.dart';
import 'package:sushi_restaurant/main.dart';
import 'package:sushi_restaurant/payment/stripe_payment_handler.dart';

import '../../components/delivery_custom_text_field.dart';
import '../../db/sushi_database.dart';


class PaymentPage extends StatefulWidget {
  final double totalPrice;
  const PaymentPage({super.key, required this.totalPrice});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  late Future<List<SushiData>> _future;
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _zipCode = TextEditingController();


  @override
  void initState() {
    super.initState();
    _future = sushiDatabase.getOrdersData();
    _fullName.text = "Taki Eddine";
    _email.text = "eddinetaki087@gmail.com";
    _phone.text = "+213777309438";
    _city.text = "Tebessa";
    _address.text = "Rue de larocade";
    _zipCode.text = "75000";
  }

  bool areFieldsEmpty() {
    final controllers = [
      _fullName,
      _email,
      _phone,
      _city,
      _address,
      _zipCode
    ];

    for (final controller in controllers) {
      if (controller.text.isEmpty) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: FutureBuilder<List<SushiData>>(
            future: _future,
            builder: (context,snapshot){
              return Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 10,),
                      Text('Delivery Information',style: getSerifFont().copyWith(fontSize: 20),),
                      const SizedBox(height: 30,),
                      DeliveryCustomTextField(hint: 'Full Name', iconData: Icons.person, controller: _fullName),
                      DeliveryCustomTextField(hint: 'Email', iconData: Icons.email, controller: _email),
                      DeliveryCustomTextField(hint: 'Phone', iconData: Icons.phone, controller: _phone),
                      DeliveryCustomTextField(hint: 'City', iconData: Icons.location_history_outlined, controller: _city),
                      DeliveryCustomTextField(hint: 'Address', iconData: Icons.location_on_sharp, controller: _address),
                      DeliveryCustomTextField(hint: 'Zip Code', iconData: Icons.location_history_outlined, controller: _zipCode),

                    ],
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: (){
                        if(areFieldsEmpty()){
                          Fluttertoast.showToast(msg: 'Fill out the fields');
                          return;
                        }

                        print('Values ${snapshot.data}');

                        // pay with stripe
                        StripePaymentHandler.data = snapshot.data!;
                        StripePaymentHandler.context = context;
                        StripePaymentHandler.total = widget.totalPrice;
                        StripePaymentHandler.fullName = _fullName.text;
                        StripePaymentHandler.email = _email.text;
                        StripePaymentHandler.phone = _phone.text;
                        StripePaymentHandler.city = _city.text;
                        StripePaymentHandler.address = _address.text;
                        StripePaymentHandler.zipCode = _zipCode.text;
                        StripePaymentHandler.stripeMakePayment();

                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: const Color(backgroundColor)
                        ),
                        child: Center(child: Text('Finalize',style: getSerifFont().copyWith(fontSize: 20,color: Colors.white),),),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
