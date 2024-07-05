import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sushi_restaurant/components/fonts.dart';
import 'package:sushi_restaurant/main.dart';

import '../db/sushi_database.dart';

class OrderPage extends StatefulWidget {
  final List<SushiData> data;
  final double total;
  final String fullName;
  final String email;
  final String phone;
  final String city;
  final String address;
  final String zipCode;
  const OrderPage({super.key,required this.data ,required this.total ,required this.fullName ,required this.email ,
    required this.phone ,required this.city ,required this.address ,required this.zipCode });

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  @override
  void initState() {
    super.initState();
    sushiDatabase.deleteAllSushi();
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30,),
            Text('Delivery Information',style: getSerifFont().copyWith(fontSize: 20)),
            const SizedBox(height: 30,),
            Expanded(
              child: Center(child: Text(getReceipt(),style: getSerifFont().copyWith(fontSize: 18),),),
            )
          ],
        ),
      ),
    );
  }

  String getReceipt(){
    final receipt = StringBuffer();
    receipt.write('#Order Details');
    receipt.writeln();
    receipt.writeln();

    receipt.writeln('----------------');

    /// DATE
    var formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
    receipt.writeln('#Ordered At : ');
    receipt.write(formattedDate);
    receipt.writeln();
    receipt.writeln();

    receipt.writeln('----------------');

    receipt.writeln('#Personal Info / Address ');
    receipt.writeln();

    receipt.writeln('----------------');

    // Full Name
    receipt.write(widget.fullName);
    receipt.writeln();

    // email
    receipt.write(widget.email);
    receipt.writeln();

    // phone
    receipt.write(widget.phone);
    receipt.writeln();

    /// full address

    receipt.write('${widget.address} ${widget.city} ${widget.zipCode}');
    receipt.writeln();

    receipt.writeln('----------------');

    // Ordered Food
    for (var data in widget.data) {
        receipt.writeln('x${data.quantity} ${data.title}');
    }

    return receipt.toString();


  }
}
