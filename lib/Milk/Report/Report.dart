import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class DairyReport extends StatelessWidget {
  const DairyReport({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Report',),
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
                  Navigator.pushNamed(context, '/dairy_expenses_report');
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
                          Text('Expenses ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
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
                  Navigator.pushNamed(context, '/dairy_purchase_report');
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
                          Text('Purchase', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          SizedBox(height: 10,),
                          Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              child: Icon(Icons.production_quantity_limits_sharp)
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // GestureDetector(
              //   onTap: () {
              //     Navigator.pushNamed(context, '/vermiCompostIncomeReport');
              //   },
              //   child: Card(
              //     color: Colors.greenAccent[400],
              //     elevation: 5,
              //     margin: EdgeInsets.all(8),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(8.0),
              //     ),
              //     child: Container(
              //       height: 150,
              //       width: 150,
              //       child: Center(
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Text('Income', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              //             SizedBox(height: 10,),
              //             Container(
              //                 padding: EdgeInsets.all(10),
              //                 decoration: BoxDecoration(
              //                     color: Colors.white.withOpacity(0.5),
              //                     borderRadius: BorderRadius.circular(8)
              //                 ),
              //                 child: Icon(MaterialIcons.money)
              //             )
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/dairy_profit_report');
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
                          Text('Profit / Loss', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          SizedBox(height: 10,),
                          Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              child: Icon(EvilIcons.chart)
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
      ),
    );
  }
}
