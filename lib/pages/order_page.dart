import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:sushi_restaurant/components/fonts.dart';
import 'package:sushi_restaurant/db/product_list_converter.dart';
import 'package:sushi_restaurant/main.dart';
import 'package:sushi_restaurant/models/product.dart';
import 'package:sushi_restaurant/pages/ui/home_page.dart';

import '../db/sushi_database.dart';
import '../pdf_api.dart';

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
    databaseService.saveOrder(getReceipt());

  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30,),
              Text('Delivery Information',style: getSerifFont().copyWith(fontSize: 20)),
              const SizedBox(height: 30,),
              SingleChildScrollView(
                child: Expanded(child: Center(child: Text(getReceipt(),style: getSerifFont().copyWith(fontSize: 18),),)),
              ),
              GestureDetector(
                onTap: () async {
                  final file = await PdfApi.createPdf(getReceipt());
                  await OpenFile.open(file.path);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 40,
                  margin: const EdgeInsets.only(left: 20,right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black45
                  ),
                  child: Center(child: Text('Show Receipt',style: getSerifFont().copyWith(fontSize: 20,color: Colors.white),),),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 40,
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black45
                  ),
                  child: Center(child: Text('Go Back',style: getSerifFont().copyWith(fontSize: 20,color: Colors.white),),),
                ),
              )
            ],
          ),
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


    receipt.writeln();
    receipt.writeln('----------------');
    receipt.writeln('Food');


    // Ordered Food
    for (var data in widget.data) {
        receipt.writeln('x${data.quantity} ${data.title}');
    }

    receipt.writeln();
    receipt.writeln('----------------');
    receipt.writeln('Addons');
    receipt.writeln();


    for(var data in widget.data){
       List<Product> list = const ProductListConverter().fromSql(data.additionalInfo!);
       list.forEach((v){
         receipt.writeln('${v.name}  \$${v.price}');
       });
    }

    return receipt.toString();


  }
}
