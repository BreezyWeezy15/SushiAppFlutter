import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sushi_restaurant/components/fonts.dart';
import 'package:sushi_restaurant/main.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Orders',style: getSerifFont().copyWith(fontSize: 25),),
              FutureBuilder(
                  future: databaseService.getOrders(),
                  builder: (context,snapshot){

                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(child: SpinKitCircle(color: Colors.black,size: 50,));
                    }

                    if(snapshot.hasError){
                      return  Center(child: Text('No Orders Yet',style: getSerifFont().copyWith(fontSize: 25),),);
                    }

                    if(snapshot.data != null){
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context,index){
                          return Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset("assets/images/order.png",width: 100,height: 100,fit: BoxFit.cover,),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Ordered At ' ,style: getSerifFont().copyWith(fontSize: 20),),
                                      Text(snapshot.data![index]['date'],style: getSerifFont().copyWith(fontSize: 16),),
                                      const SizedBox(height: 5,),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(16),
                                          color: Colors.black38
                                        ),
                                        child: Center(
                                          child: Text(snapshot.data![index]['orderID'],style: getSerifFont().copyWith(fontSize: 16,
                                          color: Colors.white),),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return  Center(child: Text('No Orders Yet',style: getSerifFont().copyWith(fontSize: 25),),);
                    }


                  }),
            ],
          ),
        ),
      ),
    );
  }
}
