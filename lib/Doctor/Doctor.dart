import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class Doctor extends StatefulWidget {
  const Doctor({super.key});

  @override
  State<Doctor> createState() => _DoctorState();
}

class _DoctorState extends State<Doctor> {

  List<dynamic> types = [
    // {
    //   'name': 'Vermi Compost',
    //   'route': '/vermicompostlist',
    //   'details': 'Vermi Compost Management',
    //   'color': Colors.teal[300],
    //   'icon': Icons.compost,
    //   'check': true
    // },
    {
      'name': 'Breeding',
      'route': '/doctorbreeding',
      'details': 'Breeding Management',
      'color': Colors.green[300],
      'icon': MaterialCommunityIcons.cow,
      'check': true
    },

    {
      'name': 'Beef Fattening',
      'route': '/doctorbeef',
      'details': 'Beef Management',
      'color': Colors.orangeAccent,
      'icon': MaterialCommunityIcons.food_steak,
      'check': true
    },
    {
      'name': 'Dairy',
      'route': '/doctordairy',
      'details': 'Dairy Management',
      'color': Colors.purple[300],
      'icon': MaterialCommunityIcons.cow,
      'check': true
    },

    {
      'name': 'Calf',
      'route': '/doctorcalf',
      'details': 'Calf Management',
      'color': Colors.pink[300],
      'icon': MaterialCommunityIcons.cow,
      'check': true
    },

    // {
    //   'name': 'Duck',
    //   'route': '/doctorduck',
    //   'details': 'Duck Management',
    //   'color': Colors.blueAccent,
    //   'icon': MaterialCommunityIcons.duck,
    //   'check': true
    // },
    // {
    //   'name': 'Fish',
    //   'route': '/doctorfish',
    //   'details': 'Fish Management',
    //   'color': Colors.brown,
    //   'icon': FontAwesome5Solid.fish,
    //   'check': true
    // },
    //
    // {
    //   'name': 'Chicken',
    //   'route': '/doctorchicken',
    //   'details': 'Chicken Management',
    //   'color': Colors. blueGrey[800],
    //   'icon': FontAwesome5Solid.kiwi_bird,
    //   'check': true
    // },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Doctor',),
      body: CustomScrollView(
        primary: false,
        slivers: [
          SliverGrid.count(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: [
              for(var i in types)
                i['check'] ? GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '${i['route']}');
                  },
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.all(8),
                    color: i['color'],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      width: 150,
                      height: 150,
                      // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Stack(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${i['name']}', style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),),
                                SizedBox(height: 5,),
                                Text('${i['details']}', style: TextStyle(color: Colors.white),)
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(

                                  topRight: Radius.circular(50),
                                ),
                                color: Colors.white24,
                              ),
                              child: Icon(
                                i['icon'],
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ) : Text(''),


            ],
          )
        ],

      )
    );
  }
}
