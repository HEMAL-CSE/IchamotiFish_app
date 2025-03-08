import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  int currentIndex = 0;
  final PageController controller = PageController();

  List<String> images = [
    "assets/ban1.jpg",
    "assets/banner3.jpg",
    "assets/banner5.jpg",
    "assets/banner1.jpg",
    "assets/banner2.jpg",
  ];


  List<dynamic> types = [
    {
      'name': 'Vermi Compost',
      'route': '/vermicompostlist',
      'details': 'Vermi Compost Management',
      'color': Colors.teal[300],
      'icon': Icons.compost,
      'check': true
    },
    {
      'name': 'Breeding',
      'route': '/breeding',
      'details': 'Breeding Management',
      'color': Colors.green[300],
      'icon': MaterialCommunityIcons.cow,
      'check': true
    },
    {
      'name': 'Beef Fattening',
      'route': '/beeffattening',
      'details': 'Beef Management',
      'color': Colors.orangeAccent,
      'icon': MaterialCommunityIcons.food_steak,
      'check': true
    },
    {
      'name': 'Dairy',
      'route': '/dairy',
      'details': 'Dairy Management',
      'color': Colors.purple[300],
      'icon': MaterialCommunityIcons.cow,
      'check': true
    },
  ];

  void getContent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? owner_id = prefs.getString('user_id');

    final url = Uri.parse('http://68.178.163.174:5010/farm/types?owner_id=${owner_id}');

    Response res = await get(url);

    var data = jsonDecode(res.body);

    var resbody = [];

    for(var i in data){
      // if(types.map((e) => e['name']).contains(i['type_name'])){
      resbody.add(types.where((e) => e['name'] == i['type_name']).toList()[0]);
      // }
    }

    print(resbody);
    setState(() {
      types = resbody;
    });


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // navigateToDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                child: UserAccountsDrawerHeader(
                  accountName:  Text('Help Desk', style: TextStyle(color: Colors.white, fontSize: 18.6, fontWeight: FontWeight.w500),),
                  accountEmail: Text('contact: ichamotifish@gmail.com', style: TextStyle(color: Colors.white, fontSize: 16),),
                  decoration: BoxDecoration(color: Color(0xff076614),
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ),

              ListTile(
                leading: Icon(Icons.email),
                title: Text('Contact Us'),
                onTap: () async{

                },
              ),

              ListTile(
                leading: Icon(Icons.share),
                title: Text('Share App'),
                onTap: () async{
                },
              ),

              ListTile(
                leading: Icon(Icons.sd_card_alert),
                title: Text('Privacy Policy'),
                onTap: () async{
                },
              ),

              ListTile(
                leading: Icon(Icons.pages),
                title: Text('Terms and Condition'),
                onTap: () async{
                },
              ),

              ListTile(
                leading: Icon(Icons.file_copy),
                title: Text('About App'),
                onTap: () async{
                },
              ),

              ListTile(
                leading: Icon(Icons.help),
                title: Text('Help/Feedback'),
                onTap: () => print('Contact'),
              ),

              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();

                  await prefs.remove('token');
                  await prefs.remove('user_id');
                  await prefs.remove('user_type_id');
                  Navigator.pushNamed(context, '/');
                },
              )
            ],
          )),
      appBar: AppBar(
        title: const Text('Ichamoti Fisheries', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: const Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              onPressed: () {}),
        ],
        backgroundColor: Color(0xff076614),
        leading: Builder(
          builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              )),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 13,
            ),
            SizedBox(
              height: 196,
              width: double.infinity,
              child: PageView.builder(
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index % images.length;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          images[index % images.length],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox( height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < images.length; i++)
                  buildIndicator(currentIndex == i)
              ],
            ),
            Container(
              margin: EdgeInsets.all(0),
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.jumpToPage(currentIndex - 1);
                    },
                    child: Icon(Icons.arrow_back, color: Colors.black,),

                  ),
                  GestureDetector(
                    onTap: () {
                      controller.jumpToPage(currentIndex + 1);
                    },
                    child: Icon(Icons.arrow_forward, color: Colors.black,),
                  ),
                ],
              ),
            ),

            // Image Carousel Section End.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/cowdashboard');
                  },
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.fromLTRB(08, 0, 08, 0),
                    color: Color(0xff076614),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      width: 152,
                      height: 152,
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
                                Text('${'পদ্মা'}', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
                                SizedBox(height: 5,),
                                Text('পুকুর ব্যবস্থাপনা', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),)
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
                              child: Icon(FontAwesome5Solid.water,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),


                SizedBox(width: 04,),

                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/calfDashboard');
                  },
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.all(8),
                    color: Color(0xff076614),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      width: 153,
                      height: 153,
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
                                Text('${'মেঘনা'}', style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),),
                                SizedBox(height: 5,),
                                Text('পুকুর ব্যবস্থাপনা', style: TextStyle(color: Colors.white, fontSize: 14.5, fontWeight: FontWeight.w500),)
                              ],
                            ),
                          ),
                          SizedBox(height: 11,),
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
                              child: Icon(FontAwesome5Solid.water,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
             SizedBox(height: 03,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/milkdashboard');
                  },
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.all(8),
                    color: Color(0xff076614),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      width: 152,
                      height: 152,
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
                                Text('${'মধুমতি'}', style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),),
                                SizedBox(height: 5,),
                                Text('পুকুর ব্যবস্থাপনা', style: TextStyle(color: Colors.white, fontSize: 14.5, fontWeight: FontWeight.w500),)
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
                              child: Icon(FontAwesome5Solid.water,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 04,),

                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/beeffattening');
                  },
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.fromLTRB(08, 0, 08, 0),
                    color: Color(0xff076614),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      width: 152,
                      height: 152,
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
                                Text('${'প্রফেসর'}', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
                                SizedBox(height: 5,),
                                Text('পুকুর ব্যবস্থাপনা', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),)
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
                              child:Icon(FontAwesome5Solid.water,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(width: 04,),

                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/biogasdashboard');
                  },
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.all(8),
                    color: Color(0xff076614),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      width: 152,
                      height: 152,
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
                                Text('${'ইছামতী'}', style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),),
                                SizedBox(height: 5,),
                                Text('পুকুর ব্যবস্থাপনা', style: TextStyle(color: Colors.white, fontSize: 14.5, fontWeight: FontWeight.w500,),)
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
                              child: Icon(Icons.waves, color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 03,),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/vermicompostlist');
                  },
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.all(8),
                    color: Color(0xff076614),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      width: 152,
                      height: 152,
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
                                Text('${'নবগঙ্গা'}', style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),),
                                SizedBox(height: 5,),
                                Text('পুকুর ব্যবস্থাপনা', style: TextStyle(color: Colors.white, fontSize: 14.5, fontWeight: FontWeight.w500),)
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
                              child: Icon(FontAwesome5Solid.water,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, '/vermicompostlist');
                  },
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.all(8),
                    color: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      width: 156,
                      height: 156,
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
                                Text('${'রিপোর্ট'}', style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),),
                                SizedBox(height: 5,),
                                Text('যাবতীয় রিপোর্ট', style: TextStyle(color: Colors.white, fontSize: 14.5),)
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
                              child: Icon(Octicons.report, color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),

          ],
        ),

      ),

    );
  }

  Widget buildIndicator(bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Container(
        height: isSelected ? 12 : 10,
        width: isSelected ? 12 : 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}