import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:tania_farm/VermiCompost/Production/vermicompost_shed.dard.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:http/http.dart';

class VermiCompostProd extends StatefulWidget {
  const VermiCompostProd({super.key});

  @override
  State<VermiCompostProd> createState() => _VermiCompostProdState();
}

class _VermiCompostProdState extends State<VermiCompostProd> {
  
  List<dynamic> sheds = [];
  
  void getData() async {
    final url = Uri.parse('http://68.178.163.174:5010/vermi_compost/sheds');

    Response res = await get(url);

    setState(() {
      sheds = jsonDecode(res.body);
    });
  }

  @override void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Vermi Compost Production',),

            body: CustomScrollView(
              primary: false,
              slivers: [
                SliverGrid.count(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: [
                    for(var i in sheds)

                      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VermiCompostShed(shed_id: i['id']),
            ),
          );

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
                                Text('${i['name']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                SizedBox(height: 10,),
                                Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: Icon(Icons.night_shelter)
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

            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => VermiCompostShed(shed_id: i['id']),
            //       ),
            //     );
            //
            //   },
            //   child: Container(
            //     height: 50,
            //     width: 300,
            //     margin: EdgeInsets.fromLTRB(15, 20, 10, 0),
            //     decoration: BoxDecoration(
            //         color: Colors.greenAccent,
            //         borderRadius: BorderRadius.circular(10)
            //     ),
            //     child: Center(child: Row(
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 10.0),
            //           child: Text('${i['name']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
            //         ),
            //         Spacer(),
            //         Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 10.0),
            //           child: Icon(Icons.arrow_forward),
            //         )
            //       ],
            //     )),
            //   ),
            // ),

    );
  }
}
