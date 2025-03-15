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
  TextEditingController price = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'ইছামতী পুকুরের তথ্য',),

      body: ListView(children: [

        Container(
            margin: EdgeInsets.fromLTRB(2, 12, 2, 0),
            child: CustomTextField(controller: length, hintText: "পুকুরের আয়তন (মিটার)", obscureText: false, textinputtypephone: true)),

        Container(
            margin: EdgeInsets.fromLTRB(2, 12, 2, 0),
            child: CustomTextField(controller: length, hintText: "পুকুরের আয়তন (মিটার)", obscureText: false, textinputtypephone: true)),

        Container(
            margin: EdgeInsets.fromLTRB(2, 12, 2, 0),
            child: CustomTextField(controller: length, hintText: "পুকুরের আয়তন (মিটার)", obscureText: false, textinputtypephone: true)),

        Container(
            margin: EdgeInsets.fromLTRB(2, 12, 2, 0),
            child: CustomTextField(controller: length, hintText: "পুকুরের আয়তন (মিটার)", obscureText: false, textinputtypephone: true)),


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
