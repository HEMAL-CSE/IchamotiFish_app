import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class BeefFatteningReport extends StatefulWidget {
  const BeefFatteningReport({super.key});

  @override
  State<BeefFatteningReport> createState() => _BeefFatteningReportState();
}

class _BeefFatteningReportState extends State<BeefFatteningReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Beef Fattening Report',),

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
                    Navigator.pushNamed(context, '/beefExpensesReport');
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
                    Navigator.pushNamed(context, '/beefProductionReport');
                  },
                  child: Card(
                    color: Colors.greenAccent[400],
                    elevation: 5,
                    margin: EdgeInsets.fromLTRB(07, 12, 10, 0),
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
                            Text('Production', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
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

                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/beefIncomeReport');
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
                            Text('Income', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            SizedBox(height: 10,),
                            Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Icon(MaterialIcons.money)
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/beefProfitReport');
                  },
                  child: Card(
                    color: Colors.greenAccent[400],
                    elevation: 5,
                    margin: EdgeInsets.fromLTRB(07, 12, 10, 0),
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
                                child: Icon(Feather.info)
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
