import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:path/path.dart';
import 'package:sushi_restaurant/pages/order_page.dart';

import '../utils.dart';


class StripePaymentHandler {
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _zipCode = TextEditingController();


  static Map<String, dynamic>? _paymentIntent;
  static Future<void> stripeMakePayment(BuildContext context, double total,String fullName,String email,
      String phone,String city,String address,String zipCode) async {
    try {
      _paymentIntent = await _createPaymentIntent(total, 'EUR');
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              billingDetails: BillingDetails(
                  name: fullName,
                  email: email,
                  phone: phone,
                  address:  Address(
                      city: city,
                      country: 'France',
                      line1: address,
                      line2: '',
                      postalCode: zipCode,
                      state: city)),
              paymentIntentClientSecret: _paymentIntent!['client_secret'], //Gotten from payment intent
              style: ThemeMode.dark,
              merchantDisplayName: 'Taki Eddine Gastalli'))
          .then((value) {  _displayPaymentSheet(context); });

    } catch (e) {
      print("Stripe $e");
    }
  }
  static _displayPaymentSheet(BuildContext context) async {
    try {
      var result = await Stripe.instance.presentPaymentSheet();
      if(context.mounted)  Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderPage()));
    } on Exception catch (e) {
      if (e is StripeException) {
        print("Stripe $e");
      } else {
        print("Stripe $e");
      }
    }
  }
  static _createPaymentIntent(double amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': _calculateAmount(amount),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(Uri.parse('https://api.stripe.com/v1/payment_intents'), headers: {
        'Authorization': 'Bearer ${Utils.secretKey}',
        'Content-Type': 'application/x-www-form-urlencoded'
      }, body: body,);
      return json.decode(response.body);
    } catch (err) {
      print("Stripe $err");
      throw Exception(err.toString());
    }
  }
  static String _calculateAmount(double amount) {
    final calculatedAmount = (amount * 100).toInt();
    return calculatedAmount.toString();
  }
}