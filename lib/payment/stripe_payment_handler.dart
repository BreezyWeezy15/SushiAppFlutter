import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:path/path.dart';
import 'package:sushi_restaurant/db/sushi_database.dart';
import 'package:sushi_restaurant/pages/order_page.dart';

import '../utils.dart';


class StripePaymentHandler {

  static late final List<SushiData> data;
  static late final BuildContext context;
  static late final double total;
  static late final String fullName;
  static late final String email;
  static late final String phone;
  static late final String city;
  static late final String address;
  static late final String zipCode;


  static Map<String, dynamic>? _paymentIntent;
  static Future<void> stripeMakePayment() async {
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
      await Stripe.instance.presentPaymentSheet();
      if(context.mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>  OrderPage(
        total: total,fullName: fullName,email: email,phone: phone,city: city,address: address,
        zipCode: zipCode,data: data,
      )));
      }
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