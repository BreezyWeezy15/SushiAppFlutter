import 'package:flutter/material.dart';
import 'package:sushi_restaurant/components/fonts.dart';
import 'package:sushi_restaurant/main.dart';

class CouponPage extends StatefulWidget {
  const CouponPage({super.key});

  @override
  State<CouponPage> createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment:  CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('My Coupons',style: getSerifFont().copyWith(fontSize: 20),),
            ),
            Expanded(
              child: FutureBuilder(
                future: databaseService.getCoupons(),
                builder: (context,snapshot){
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context,index){
                      return  Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RotatedBox(
                              quarterTurns: 1,
                              child: Text(snapshot.data![index]['percent'] + '%',style: getSerifFont().copyWith(fontSize: 50,
                              fontWeight: FontWeight.bold),),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 90,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/images/coupon_logo.png'),
                                      filterQuality: FilterQuality.high,
                                      fit: BoxFit.cover
                                  ),
                              ),
                              child:  Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(snapshot.data![index]['coupon'],style: getSerifFont().copyWith(fontSize: 50),),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
