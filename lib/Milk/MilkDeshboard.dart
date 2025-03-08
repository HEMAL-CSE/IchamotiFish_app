import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:tania_farm/components/CustomAppBar.dart';

class MilkDashboard extends StatefulWidget {
  const MilkDashboard({super.key});

  @override
  State<MilkDashboard> createState() => _MilkDashboardState();
}

class _MilkDashboardState extends State<MilkDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'দুধ সংশ্লিষ্ট ড্যাশবোর্ড',),

        body: CustomScrollView(
          primary: false,
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 06,),),
            // SliverGrid.count(
            //   crossAxisSpacing: 10,
            //   mainAxisSpacing: 10,
            //   crossAxisCount: 2,
            //   children: [
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.pushNamed(context, '/total_milk_prod');
            //       },
            //       child: Card(
            //         color: Colors.greenAccent[400],
            //         elevation: 5,
            //         margin: EdgeInsets.fromLTRB(12, 12, 0, 0),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(8.0),
            //         ),
            //         child: Container(
            //           height: 150,
            //           width: 150,
            //           child: Center(
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.center,
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Text('মোট উৎপাদিত দুধ',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),
            //                 SizedBox(height: 10,),
            //                 Container(
            //                     padding: EdgeInsets.all(10),
            //                     decoration: BoxDecoration(
            //                         color: Colors.white.withOpacity(0.5),
            //                         borderRadius: BorderRadius.circular(8)
            //                     ),
            //                     child: Icon(Entypo.bucket)
            //                 )
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //
            //     //Earthwarm section start
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.pushNamed(context, '/milk_selling');
            //       },
            //       child: Card(
            //         color: Colors.greenAccent[400],
            //         elevation: 5,
            //         margin: EdgeInsets.fromLTRB(08, 12, 10, 0),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(8.0),
            //         ),
            //         child: Container(
            //           height: 150,
            //           width: 150,
            //           child: Center(
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.center,
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Text('দুধ বিক্রয়',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            //                 SizedBox(height: 10,),
            //                 Container(
            //                     padding: EdgeInsets.all(10),
            //                     decoration: BoxDecoration(
            //                         color: Colors.white.withOpacity(0.5),
            //                         borderRadius: BorderRadius.circular(8)
            //                     ),
            //                     child: Icon(MaterialCommunityIcons.sale)
            //                 )
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.pushNamed(context, '/milk_customer');
            //       },
            //       child: Card(
            //         color: Colors.greenAccent[400],
            //         elevation: 5,
            //         margin: EdgeInsets.fromLTRB(12, 12, 0, 0),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(8.0),
            //         ),
            //         child: Container(
            //           height: 150,
            //           width: 150,
            //           child: Center(
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.center,
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Text('ক্রেতাদের তালিকা',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            //                 SizedBox(height: 10,),
            //                 Container(
            //                     padding: EdgeInsets.all(10),
            //                     decoration: BoxDecoration(
            //                         color: Colors.white.withOpacity(0.5),
            //                         borderRadius: BorderRadius.circular(8)
            //                     ),
            //                     child: Icon(Icons.people_alt_outlined)
            //                 )
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.pushNamed(context, '/milk_labour');
            //       },
            //       child: Card(
            //         color: Colors.greenAccent[400],
            //         elevation: 5,
            //         margin: EdgeInsets.fromLTRB(10, 12, 10, 0),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(8.0),
            //         ),
            //         child: Container(
            //           height: 150,
            //           width: 150,
            //           child: Center(
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.center,
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Text('শ্রমিকদের তালিকা',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            //                 SizedBox(height: 10,),
            //                 Container(
            //                     padding: EdgeInsets.all(10),
            //                     decoration: BoxDecoration(
            //                         color: Colors.white.withOpacity(0.5),
            //                         borderRadius: BorderRadius.circular(8)
            //                     ),
            //                     child: Icon(SimpleLineIcons.people)
            //                 )
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //
            //
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.pushNamed(context, '/milk_labour_payment');
            //       },
            //       child: Card(
            //         color: Colors.greenAccent[400],
            //         elevation: 5,
            //         margin: EdgeInsets.fromLTRB(12, 12, 0, 0),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(8.0),
            //         ),
            //         child: Container(
            //           height: 150,
            //           width: 150,
            //           child: Center(
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.center,
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Text('শ্রমিকদের বেতন',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            //                 SizedBox(height: 10,),
            //                 Container(
            //                     padding: EdgeInsets.all(10),
            //                     decoration: BoxDecoration(
            //                         color: Colors.white.withOpacity(0.5),
            //                         borderRadius: BorderRadius.circular(8)
            //                     ),
            //                     child: Icon(FontAwesome.money)
            //                 )
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //
            //
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.pushNamed(context, '/vermicompostreport');
            //       },
            //       child: Card(
            //         color: Colors.greenAccent[400],
            //         elevation: 5,
            //         margin: EdgeInsets.fromLTRB(10, 12, 10, 0),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(8.0),
            //         ),
            //         child: Container(
            //           height: 150,
            //           width: 150,
            //           child: Center(
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.center,
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Text('রিপোর্ট',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            //                 SizedBox(height: 10,),
            //                 Container(
            //                     padding: EdgeInsets.all(10),
            //                     decoration: BoxDecoration(
            //                         color: Colors.white.withOpacity(0.5),
            //                         borderRadius: BorderRadius.circular(8)
            //                     ),
            //                     child: Icon(Icons.report)
            //                 )
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //
            //   ],
            // )

            SliverGrid.count(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: [
                GestureDetector(
                  onTap: () {

                    Navigator.pushNamed(context, '/dairy_purchase');

                  },
                  child: Card(
                    color: Colors.greenAccent[400],
                    elevation: 5,
                    margin: EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      height: 150,
                      width: 150,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('ক্রয়',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            SizedBox(height: 10,),
                            Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Icon(AntDesign.plus)
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/dairy_production');
                  },
                  child: Card(
                    color: Colors.greenAccent[400],
                    elevation: 5,
                    margin: EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      height: 150,
                      width: 150,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('উৎপাদন',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            SizedBox(height: 10,),
                            Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Icon(Entypo.bucket)
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {

                    Navigator.pushNamed(context, '/dairy_expenses');
                  },
                  child: Card(
                    color: Colors.greenAccent[400],
                    elevation: 5,
                    margin: EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      height: 150,
                      width: 150,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('খরচসমূহ',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            SizedBox(height: 10,),
                            Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Icon(Icons.device_hub)
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/dairytreatmentlist');

                  },
                  child: Card(
                    color: Colors.greenAccent[400],
                    elevation: 5,
                    margin: EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      height: 150,
                      width: 150,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('চিকিৎসা',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            SizedBox(height: 10,),
                            Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Icon(Fontisto.doctor)
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/dairy_customers');
                  },
                  child: Card(
                    color: Colors.greenAccent[400],
                    elevation: 5,
                    margin: EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      height: 150,
                      width: 150,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('ক্রেতাদের তালিকা',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            SizedBox(height: 10,),
                            Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Icon(Icons.people)
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {

                    Navigator.pushNamed(context, '/dairy_healthcare');

                  },
                  child: Card(
                    color: Colors.greenAccent[400],
                    elevation: 5,
                    margin: EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      height: 150,
                      width: 150,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('স্বাস্থ্যসেবা', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            SizedBox(height: 10,),
                            Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Icon(AntDesign.medicinebox)
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/dairy_feeding');

                  },
                  child: Card(
                    color: Colors.greenAccent[400],
                    elevation: 5,
                    margin: EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      height: 150,
                      width: 150,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('খাদ্য', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            SizedBox(height: 10,),
                            Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Icon(Icons.grass)
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/dairy_reports');
                  },
                  child: Card(
                    color: Colors.greenAccent[400],
                    elevation: 5,
                    margin: EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      height: 150,
                      width: 150,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('রিপোর্ট',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            SizedBox(height: 10,),
                            Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Icon(Icons.report)
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        )

    );
  }
}
