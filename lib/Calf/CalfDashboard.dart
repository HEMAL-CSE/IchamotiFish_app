import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:tania_farm/components/CustomAppBar.dart';

class CalfDashboard extends StatefulWidget {
  const CalfDashboard({super.key});

  @override
  State<CalfDashboard> createState() => _CalfDashboardState();
}

class _CalfDashboardState extends State<CalfDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'বাছুর সম্পর্কিত ড্যাশবোর্ড',),

        body: CustomScrollView(
          primary: false,
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 06,),),
            SliverGrid.count(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/calf_birth');
                  },
                  child: Card(
                    color: Colors.greenAccent[400],
                    elevation: 5,
                    margin: EdgeInsets.fromLTRB(12, 12, 0, 0),
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
                            Text('জন্ম তথ্য',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),
                            SizedBox(height: 10,),
                            Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Icon(MaterialCommunityIcons.cow)
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                //Earthwarm section start
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/calf_expenses');
                  },
                  child: Card(
                    color: Colors.greenAccent[400],
                    elevation: 5,
                    margin: EdgeInsets.fromLTRB(08, 12, 10, 0),
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
                                child: Icon(MaterialCommunityIcons.sale)
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/calf_treatment');
                  },
                  child: Card(
                    color: Colors.greenAccent[400],
                    elevation: 5,
                    margin: EdgeInsets.fromLTRB(12, 12, 0, 0),
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
                    Navigator.pushNamed(context, '/calf_selling');
                  },
                  child: Card(
                    color: Colors.greenAccent[400],
                    elevation: 5,
                    margin: EdgeInsets.fromLTRB(10, 12, 10, 0),
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
                            Text('বিক্রয়',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            SizedBox(height: 10,),
                            Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Icon(SimpleLineIcons.people)
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),


                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/calf_customer');
                  },
                  child: Card(
                    color: Colors.greenAccent[400],
                    elevation: 5,
                    margin: EdgeInsets.fromLTRB(12, 12, 0, 0),
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
                            Text('ক্রেতা',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            SizedBox(height: 10,),
                            Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Icon(FontAwesome.money)
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),


                GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, '/vermicompostreport');
                  },
                  child: Card(
                    color: Colors.greenAccent[400],
                    elevation: 5,
                    margin: EdgeInsets.fromLTRB(10, 12, 10, 0),
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
