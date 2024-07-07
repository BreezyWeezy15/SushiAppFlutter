import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sushi_restaurant/components/fonts.dart';
import 'package:sushi_restaurant/main.dart';
import 'package:sushi_restaurant/pdf_api.dart';


class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late Stream<List<Map<String, dynamic>>> _future;

  @override
  void initState() {
    super.initState();
    _future = databaseService.getOrders();
  }

  @override
  void dispose() {
    super.dispose();
  }


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
              Expanded(child: StreamBuilder(
                  stream: _future,
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

                          bool isConfirmed = snapshot.data![index]['isConfirmed'];

                          return Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset("assets/images/order.png",width: 100,height: 100,fit: BoxFit.scaleDown,),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Ordered At ' ,style: getSerifFont().copyWith(fontSize: 17),),
                                      Text(snapshot.data![index]['date'],style: getSerifFont().copyWith(fontSize: 13),),
                                      const SizedBox(height: 5,),
                                      GestureDetector(
                                        onTap : () async {

                                          final file = await PdfApi.createPdf(snapshot.data![index]['receipt']);
                                          await OpenFile.open(file.path);

                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(16),
                                              color: Colors.black38
                                          ),
                                          child: Center(
                                            child: Text(snapshot.data![index]['orderID'],style: getSerifFont().copyWith(fontSize: 14,
                                                color: Colors.white),),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10,),
                                      IgnorePointer(
                                        ignoring: isConfirmed == true ? true : false,
                                        child: GestureDetector(
                                          onTap : () async {
                                            showDialog(
                                                context: context,
                                                builder: (context){
                                                  return AlertDialog(
                                                    title: Text('Order Confirmation',style: getSerifFont().copyWith(fontSize: 18),),
                                                    content: Text('Do you want to confirm order?',style: getSerifFont().copyWith(fontSize: 16),),
                                                    actions: [
                                                      ElevatedButton(onPressed: () async {
                                                        await databaseService.updateStatus(
                                                            snapshot.data![index]['docID'], true);

                                                        Fluttertoast.showToast(msg: 'Order Confirmed');


                                                        if(context.mounted) Navigator.pop(context);

                                                      }, child: const Text('Yes')),
                                                      ElevatedButton(onPressed: (){
                                                        Navigator.pop(context);
                                                      }, child: const Text('No'))
                                                    ],
                                                  );
                                                });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(16),
                                                color: isConfirmed == false ? Colors.red : Colors.green
                                            ),
                                            child: Center(
                                              child: Text(isConfirmed == false ? 'Confirm' : 'Confirmed',style: getSerifFont().copyWith(fontSize: 14,
                                                  color: Colors.white),),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                isConfirmed == true ?
                                Center(child: IconButton(onPressed: (){

                                  // delete confirmed order
                                  showDialog(
                                      context: context,
                                      builder: (context){
                                        return AlertDialog(
                                          title: Text('Order Deletion',style: getSerifFont().copyWith(fontSize: 18),),
                                          content: Text('Do you want to remove this order?',style: getSerifFont().copyWith(fontSize: 16)),
                                          actions: [
                                            ElevatedButton(onPressed: () async {
                                              await databaseService.deleteOrder(snapshot.data![index]['docID']);
                                              if(context.mounted) Navigator.pop(context);
                                            }, child: Text('Yes',style: getSerifFont().copyWith(fontSize: 18),)),
                                            ElevatedButton(onPressed: (){
                                              Navigator.pop(context);
                                            }, child: Text('No',style: getSerifFont().copyWith(fontSize: 18),))
                                          ],
                                        );
                                      });

                                }, icon: const Icon(Icons.delete,size: 40,)),)
                                    : Container()
                              ],
                            ),
                          );
                        },
                      );
                    }
                    else {
                      return  Center(child: Text('No Orders Yet',style: getSerifFont().copyWith(fontSize: 25),),);
                    }

                  })),
            ],
          ),
        ),
      ),
    );
  }
}
