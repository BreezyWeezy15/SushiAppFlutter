

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sushi_restaurant/components/colors.dart';
import 'package:sushi_restaurant/components/fonts.dart';
import 'package:sushi_restaurant/db/product_list_converter.dart';
import 'package:sushi_restaurant/db/sushi_database.dart';
import 'package:sushi_restaurant/models/product.dart';
import 'package:sushi_restaurant/pages/ui/cart_page.dart';
import '../../main.dart';



class DetailsPage extends StatefulWidget {
  final List addons;
  final String documentID;
  const DetailsPage({super.key,required this.addons, required this.documentID});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late Future<DocumentSnapshot<Object?>> _future;
  List<Product> currentlySelectedAddons = [];
  Map<Map<String,dynamic>,bool?> selectedAddons = {};
  int quantity = 0;
  double total = 0.0;

  @override
  void initState() {
    super.initState();
    for(var data in widget.addons){
      selectedAddons[data as Map<String,dynamic>] = false;
    }

    _future = databaseService.getFoodDetails(widget.documentID);

  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<DocumentSnapshot>(
          future: _future,
          builder: (context, snapshot) {

            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: SpinKitCircle(color: Colors.black,size: 50,),);
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            // LOAD DATA
            Map<String, dynamic>? docs = snapshot.data?.data() as Map<String, dynamic>?;


            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInImage(
                        placeholder: const AssetImage('assets/images/sushi.png'),
                        image: NetworkImage(docs?['image']),
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        fit: BoxFit.cover,
                        fadeInDuration: const Duration(seconds: 5),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Row(
                          children: [
                            const Icon(Icons.star, size: 30, color: Colors.yellowAccent),
                            const SizedBox(width: 5),
                            Text(docs!['vote'].toString(), style: getSerifFont().copyWith(fontSize: 20)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 20, top: 20),
                        child: Text(docs['title'].toString(), style: getFont().copyWith(fontSize: 30)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 20, top: 20),
                        child: Text('Add-Ons', style: getSerifFont().copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 20, top: 20),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.addons.length,
                          itemBuilder: (context,index){
                            Map<String,dynamic> data = widget.addons[index];
                            return CheckboxListTile(
                                title: Text(data['name'],style: getFont().copyWith(fontSize: 20),),
                                subtitle: Text('\$${data['price']}',style: getSerifFont().copyWith(fontSize: 17),),
                                value: selectedAddons[data],
                                onChanged: (bool? value){
                                  setState(() {
                                    selectedAddons[data] = value!;
                                  });
                                  print('now ${selectedAddons[data]}');
                                });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 20, top: 20),
                        child: Text('Description', style: getSerifFont().copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 20, top: 20),
                        child: Text(docs['description'], style: getSerifFont().copyWith(fontSize: 17)),
                      ),
                      const SizedBox(height: 180,)
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(

                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16)),
                      color: Color(backgroundColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 20),
                              Text(
                                '\$${docs['price']}',
                                style: getSerifFont().copyWith(fontSize: 25, color: Colors.white),
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (quantity > 0) {
                                        setState(() {
                                          quantity--;
                                          total = double.parse(docs['price'].toString()) * quantity;
                                        });
                                      }
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(buttonColor),
                                      ),
                                      child: const Center(child: Icon(Icons.remove, size: 20, color: Colors.white)),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(quantity.toString(), style: getFont().copyWith(fontSize: 25, color: Colors.white)),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        quantity++;
                                        total = double.parse(docs['price'].toString()) * quantity;
                                      });
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(buttonColor),
                                      ),
                                      child: const Center(child: Icon(Icons.add, size: 20, color: Colors.white)),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () async {
                              if(quantity == 0){
                                 Fluttertoast.showToast(msg: 'Quantity should be greater than 0');
                                 return;
                              }

                              currentlySelectedAddons.clear();
                              selectedAddons.forEach((key, value) {
                                if (value == true) {
                                  print('Values ' + key.toString());
                                  currentlySelectedAddons.add(Product(price: double.parse(key['price'].toString()), name: key['name']));
                                }
                              });


                              SushiCompanion sushi = SushiCompanion(
                                  title: Value(docs['title']),
                                  description: Value(docs['description']),
                                  image: Value(docs['image']),
                                  quantity: Value(quantity),
                                  total: Value(total),
                                  price: Value(double.parse(docs['price'].toString())),
                                  additionalInfo: Value(ProductListConverter().toSql(currentlySelectedAddons))
                              );

                              int result = await sushiDatabase.insertSushi(sushi);
                              if(result >= 1){
                                Fluttertoast.showToast(msg: 'Item Successfully Added');
                                if(context.mounted){
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => const CartPage()));
                                }
                              } else {
                                Fluttertoast.showToast(msg: 'Failed to save data');
                              }

                            },
                            child:  Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(26),
                                color: const Color(buttonColor),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Add to cart', style: getSerifFont().copyWith(fontSize: 20,color: Colors.white)),
                                  const SizedBox(width: 5),
                                  const Icon(Icons.arrow_forward, color: Colors.white, size: 25),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
