import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class BeefFatteningExpenses extends StatefulWidget {
  const BeefFatteningExpenses({super.key});

  @override
  State<BeefFatteningExpenses> createState() => _BeefFatteningExpensesState();
}

class _BeefFatteningExpensesState extends State<BeefFatteningExpenses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Expenses',),

        body: CustomScrollView(
          primary: false,
          slivers: [
            SliverGrid.count(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/beefFatteningFeed');
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
                            Text('Feed', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
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
                    Navigator.pushNamed(context, '/beefFatteningLabour');
                  },
                  child: Card(
                    color: Colors.greenAccent[400],
                    elevation: 5,
                    margin: EdgeInsets.all(7.5),
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
                            Text('Labour List', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),),
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
                    Navigator.pushNamed(context, '/beefFatteningPayment');
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
                            Text('Labour Payment', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            SizedBox(height: 10,),
                            Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Icon(FontAwesome.dollar)
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/beefFatteningOthers');
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
                            Text('Others Expenses', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
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
                    Navigator.pushNamed(context, '/beefFatteningOthersPayment');
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
                            Text('Others Payment', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            SizedBox(height: 10,),
                            Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Icon(FontAwesome.dollar)
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
