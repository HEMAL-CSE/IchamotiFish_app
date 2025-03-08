import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';


class DairyTreatmentList extends StatefulWidget {
  const DairyTreatmentList({super.key});

  @override
  State<DairyTreatmentList> createState() => _DairyTreatmentListState();
}

class _DairyTreatmentListState extends State<DairyTreatmentList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Dairy Treatment',),
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
                  Navigator.pushNamed(context, '/dairy_doctors');
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
                          Text('Doctors List', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
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
                  Navigator.pushNamed(context, '/dairy_treatment');
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
                          Text('Treatment', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),),
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
            ],
          )
        ],
      )
    );
  }
}
