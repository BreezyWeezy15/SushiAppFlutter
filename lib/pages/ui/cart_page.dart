

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sushi_restaurant/components/colors.dart';
import 'package:sushi_restaurant/components/fonts.dart';
import 'package:sushi_restaurant/db/product_list_converter.dart';
import 'package:sushi_restaurant/main.dart';
import 'package:sushi_restaurant/pages/ui/payment_page.dart';

import '../../db/sushi_database.dart';
import '../../models/product.dart';


class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Stream<List<SushiData>> _stream;

  @override
  void initState() {
    super.initState();
    _stream = sushiDatabase.getAllSushi();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cart',style: getSerifFont().copyWith(fontSize: 20),),
          centerTitle: true,
          actions: [
            IconButton(onPressed: (){
              showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    title: Text('Erase Cart',style: getSerifFont().copyWith(fontSize: 20),),
                    content: Text('Do you want to erase cart',style: getSerifFont().copyWith(fontSize: 18),),
                    actions: [
                      ElevatedButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: Text('No',style: getSerifFont().copyWith(fontSize: 15),)),
                      ElevatedButton(onPressed: () async {
                         var result = await sushiDatabase.deleteAllSushi();
                         if(result >= 1){
                           Fluttertoast.showToast(msg: 'Card Successfully Erased');
                         } else {
                           Fluttertoast.showToast(msg: 'Failed to clear cart');
                         }
                         if(context.mounted)  Navigator.pop(context);
                      }, child: Text('Yes',style: getSerifFont().copyWith(fontSize: 15)))
                    ],
                  );
                }
              );

            }, icon: const Icon(Icons.delete,size: 30,))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder<List<SushiData>>(
                  stream: _stream,
                  builder: (context,snapshot){

                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(child: SpinKitCircle(color: Colors.black,size: 50,),);
                    }

                    if(snapshot.hasError){
                      return  Center(child: Text("No Cart Items${snapshot.error}"),);
                    }

                    List<SushiData>? data = snapshot.data;

                    if(data!.isNotEmpty){
                      return  ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {

                          List<Product> addons = const ProductListConverter().fromSql(data[index].additionalInfo!);

                          return Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.startToEnd,
                            onDismissed: (direction) async{
                              var result =  await sushiDatabase.deleteSushi(data[index].id);
                              if(result == 1){
                                Fluttertoast.showToast(msg: 'Item Successfully Deleted');
                              } else {
                                Fluttertoast.showToast(msg: 'Failed to delete item');
                              }
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          data[index].image,
                                          width: 120,
                                          height: 120,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                            data[index].title,
                                            style: getFont().copyWith(fontSize: 20),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                              Text('Unit: \$${data[index].price}',
                                                style: getSerifFont().copyWith(fontSize: 17),
                                              ),
                                              const SizedBox(height: 10,),
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () async {
                                                      var totalPrice = data[index].total;
                                                      var quantity = data[index].quantity;

                                                      if(quantity >= 2){
                                                        setState(() {
                                                          quantity = data[index].quantity - 1;
                                                          totalPrice = totalPrice - data[index].price;
                                                        });
                                                      }

                                                      await sushiDatabase.updateSushi(quantity, totalPrice, data[index].id);
                                                    },
                                                    child: Container(
                                                      width: 40,
                                                      height: 40,
                                                      decoration: const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Color(buttonColor),
                                                      ),
                                                      child: const Center(
                                                        child: Icon(Icons.remove, size: 20, color: Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    data[index].quantity.toString(),
                                                    style: getFont().copyWith(fontSize: 25),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      var quantity = data[index].quantity;
                                                      var totalPrice = data[index].total;

                                                      setState(() {
                                                        quantity = data[index].quantity + 1;
                                                        totalPrice = totalPrice + data[index].price;
                                                      });

                                                      print('total $totalPrice');
                                                      await sushiDatabase.updateSushi(quantity, totalPrice, data[index].id);
                                                    },
                                                    child: Container(
                                                      width: 40,
                                                      height: 40,
                                                      decoration: const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Color(buttonColor),
                                                      ),
                                                      child: const Center(
                                                        child: Icon(Icons.add, size: 20, color: Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    height: addons.isEmpty ? 0 : 60,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: addons.map((addon){
                                        return FilterChip(
                                          label: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(addon.name),
                                              Text(' \$${addon.price}')
                                            ],
                                          ),
                                          shape: const StadiumBorder(),
                                          onSelected: (value){},
                                          labelStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12
                                          ),);
                                      }).toList(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return  Center(child: Text("No Cart Items",style: getSerifFont().copyWith(fontSize: 20),),);
                    }
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: StreamBuilder<double>(
                  stream: sushiDatabase.sumTotal(),
                  builder: (context,snapshot){

                    double? due = 0.0;
                    if(snapshot.data == null){
                      due = 0.0;
                    } else {
                      due = snapshot.data;
                    }

                    return Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color(backgroundColor)
                      ),
                      child: Row(
                        children: [
                          Text('Due :' ,style: getSerifFont().copyWith(fontSize: 20,color: Colors.white),),
                          Text('\$$due',style: getSerifFont().copyWith(fontSize: 20,color: Colors.white),),
                          const Spacer(),
                          GestureDetector(
                            onTap: (){
                              if(due == 0.0){
                                Fluttertoast.showToast(msg: 'No items to pay for');
                                return;
                              }

                              Navigator.push(context, MaterialPageRoute(builder: (_) =>  PaymentPage(
                                  totalPrice: snapshot.data!)));
                            },
                            child: Container(
                              width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: const Color(buttonColor)
                              ),
                              child: Center(
                                child: Text('PAY',style: getSerifFont().copyWith(fontSize: 18,color: Colors.white),),
                              ),
                            ),
                          )
                        ],
                      ),
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


