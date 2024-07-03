import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sushi_restaurant/components/colors.dart';
import 'package:sushi_restaurant/components/fonts.dart';
import 'package:sushi_restaurant/main.dart';
import 'package:sushi_restaurant/pages/ui/details_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10,),
            Center(child: Text('Sushi Mushi',style: getFont().copyWith(fontSize: 25),)),
            Container(
              margin: const EdgeInsets.all(20),
              height:  190,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(backgroundColor)
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Get 32% Promo',style: getSerifFont().copyWith(fontSize: 25,color: Colors.white),),
                          const SizedBox(height: 20,),
                          Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color(buttonColor)
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Redeem',style: getSerifFont().copyWith(fontSize: 20,color: Colors.white),),
                                IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward,color: Colors.white,size: 30,))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Image.asset("assets/images/sushi.png",width: 120,height: 120,),
                  const SizedBox(width: 20,)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.black45)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.blue)
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text('Food Menu',style: getSerifFont().copyWith(fontSize: 20)),
            ),
            Expanded(
              child: FutureBuilder<QuerySnapshot>(
                future: databaseService.getFood(),
                  builder: (context, snapshot){

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    // LOAD DATA
                    final docs = snapshot.data?.docs ?? [];

                    return Padding(
                      padding: const EdgeInsets.all(15),
                      child: GridView.builder(
                          itemCount: docs.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.85,
                              crossAxisSpacing: 5.0,
                              mainAxisSpacing: 5.0
                          ),
                          itemBuilder: (context,index){
                            final data = docs[index].data() as Map<String, dynamic>;
                            return GestureDetector(
                              onTap: (){
                                showDetailsScreen(data['foodID']);
                              },
                              child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16)),
                                      child:  FadeInImage(
                                        placeholder: const AssetImage('assets/images/sushi.png'),
                                        image: NetworkImage(data['image']),
                                        fadeInDuration: const Duration(seconds: 10),
                                        height: 150,),
                                    ),
                                    Flexible(child:  Padding(
                                      padding: const EdgeInsets.only(left: 10,right: 15,top: 10),
                                      child: Text(data['title'],style: getFont().copyWith(fontSize: 18,
                                          overflow: TextOverflow.ellipsis),),
                                    )),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5,right: 5,bottom: 5),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(child: Text( '\$${data['price']}.00',style: getSerifFont().copyWith(fontSize: 18,
                                                overflow: TextOverflow.ellipsis),)),
                                            Row(
                                              children: [
                                                const Icon(Icons.star,size: 25,color: Colors.yellowAccent,),
                                                Text(data['vote'].toString(),style: getSerifFont().copyWith(fontSize: 18),)
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
                  }
              ),
            )
          ],
        ),
      ),
    );
  }

  void showDetailsScreen(String documentID){
    Navigator.push(context, MaterialPageRoute(builder: (_) => DetailsPage(documentID: documentID)));
  }
}
