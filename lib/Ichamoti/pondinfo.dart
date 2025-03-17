import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:tania_farm/components/CustomTextField.dart';

class IchamotiPond extends StatefulWidget {
  const IchamotiPond({super.key});

  @override
  State<IchamotiPond> createState() => _IchamotiPondState();
}

class _IchamotiPondState extends State<IchamotiPond> {


  String? shed_id;
  TextEditingController length = TextEditingController();
  TextEditingController width = TextEditingController();
  TextEditingController depth = TextEditingController();
  TextEditingController ph = TextEditingController();
  TextEditingController soiltest = TextEditingController();
  TextEditingController temp = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'ইছামতী পুকুরের তথ্য',),

      body: ListView(children: [

        Container(
            margin: EdgeInsets.fromLTRB(2, 12, 2, 0),
            child: CustomTextField(controller: length, hintText: "পুকুরের দৈর্ঘ্য (মিটার বা ফুট)", obscureText: false, textinputtypephone: true)),

        Container(
            margin: EdgeInsets.fromLTRB(2, 12, 2, 0),
            child: CustomTextField(controller: width, hintText: "পুকুরের প্রস্থ (মিটার বা ফুট)", obscureText: false, textinputtypephone: true)),

        Container(
            margin: EdgeInsets.fromLTRB(2, 12, 2, 0),
            child: CustomTextField(controller: depth, hintText: "পুকুরের গভীরতা (মিটার বা ফুট)", obscureText: false, textinputtypephone: true)),

        Container(
            margin: EdgeInsets.fromLTRB(2, 12, 2, 0),
            child: CustomTextField(controller: soiltest, hintText: "পুকুরের মাটির (pH) মান:", obscureText: false, textinputtypephone: true)),

        Container(
            margin: EdgeInsets.fromLTRB(2, 12, 2, 0),

            child: CustomTextField(controller: ph, hintText: "পানির পিএইচ (pH) মান:", obscureText: false, textinputtypephone: true)),

        Container(
            margin: EdgeInsets.fromLTRB(2, 12, 2, 0),
            child: CustomTextField(controller: temp, hintText: "পুকুরের পানির তাপমাত্রা (°C):", obscureText: false, textinputtypephone: true)),


        Container( padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(04),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff076614),
                foregroundColor: Colors.white,
              ),
              onPressed: (){
              }, child: const Text("জমা দিন", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)),
        ),

      ],

      ),

    );
  }
}
