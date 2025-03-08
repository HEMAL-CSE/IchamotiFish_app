import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class BeefCustomer extends StatefulWidget {
  const BeefCustomer({super.key});

@override
  State<BeefCustomer> createState() => _BeefCustomerState();
}

class _BeefCustomerState extends State<BeefCustomer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Beef Customer',),

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
                    Navigator.pushNamed(context, '/beefCustomerInfo');
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
                            Text('Add Customer', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
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

              ],
            )
          ],
        )


      // body: ListView(children: [
      //   GestureDetector(
      //     onTap: () {
      //       Navigator.pushNamed(context, '/beefCustomerInfo');
      //     },
      //     child: Container(
      //       height: 50,
      //       width: 300,
      //       margin: EdgeInsets.fromLTRB(15, 18, 10, 20),
      //       decoration: BoxDecoration(
      //           color: Colors.greenAccent[400],
      //           borderRadius: BorderRadius.circular(10)
      //       ),
      //       child: Center(child: Row(
      //         children: [
      //
      //           Padding(
      //             padding: const EdgeInsets.symmetric(horizontal: 10.0),
      //             child: Text('Add Customer', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
      //           ),
      //           Spacer(),
      //           Padding(
      //             padding: const EdgeInsets.symmetric(horizontal: 10.0),
      //             child: Icon(Icons.arrow_forward),
      //           )
      //         ],
      //       )),
      //     ),
      //   ),
      // ],),
    );
  }
}
