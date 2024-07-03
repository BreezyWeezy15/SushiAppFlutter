import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sushi_restaurant/components/colors.dart';
import 'package:sushi_restaurant/components/fonts.dart';
import 'package:sushi_restaurant/main.dart';


class DetailsPage extends StatefulWidget {
  final String documentID;
  const DetailsPage({super.key,required this.documentID});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  int quantity = 0;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<DocumentSnapshot>(
                future: databaseService.getFoodDetails(widget.documentID),
                builder: (context,snapshot){

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }


                  // LOAD DATA
                  final docs = snapshot.data?.data() ?? [];
                  final data = docs as Map<String, dynamic>;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadeInImage(
                              placeholder: const AssetImage('assets/images/sushi.png'),
                              image: NetworkImage(data['image']),
                              width: MediaQuery.of(context).size.width,
                              height: 250,
                              fit: BoxFit.cover,
                              fadeInDuration: const Duration(seconds: 5),),
                            Padding(
                              padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                              child: Row(
                                children: [
                                  const Icon(Icons.star,size: 30,color: Colors.yellowAccent,),
                                  const SizedBox(width: 5,),
                                  Text(data['vote'].toString(),style: getSerifFont().copyWith(fontSize: 20)),

                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30,right: 20,top: 20),
                              child: Text(data['title'].toString(),style: getFont().copyWith(fontSize: 30)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30,right: 20,top: 20),
                              child: Text('Add Ons',style: getSerifFont().copyWith(fontSize: 20,fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30,right: 20,top: 20),
                              child: Text('Description',style: getSerifFont().copyWith(fontSize: 20,fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30,right: 20,top: 20),
                              child: Text(data['description'],style: getSerifFont().copyWith(fontSize: 17)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Container(
                          height: 80,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(16),topLeft: Radius.circular(16)),
                              color: Color(backgroundColor)
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 20,),
                              Text('\$${data['price']}.00',style: getSerifFont().copyWith(fontSize: 25,color: Colors.white),),
                              const Spacer(),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      if(quantity > 0){
                                        setState(() {
                                          quantity--;
                                        });
                                      }
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(buttonColor)
                                      ),
                                      child: const Center(child: Icon(Icons.remove,size: 20,color: Colors.white,)),
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                  Text(quantity.toString(),style: getFont().copyWith(fontSize: 25,color: Colors.white),),
                                  const SizedBox(width: 10,),
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        quantity++;
                                      });
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(buttonColor)
                                      ),
                                      child: const Center(child: Icon(Icons.add,size: 20,color: Colors.white,)),
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
