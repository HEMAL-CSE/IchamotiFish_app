import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:tania_farm/components/CustomTextField.dart';

class Ichamotifishinfo extends StatefulWidget {
  const Ichamotifishinfo({super.key});

  @override
  State<Ichamotifishinfo> createState() => _IchamotifishinfoState();
}

class _IchamotifishinfoState extends State<Ichamotifishinfo> {

  DateTime ponacollect_date = DateTime.now();

  TextEditingController fishnumber = TextEditingController();
  TextEditingController fishweight = TextEditingController();
  TextEditingController fishage = TextEditingController();

  String? fish_spacies;
  String? fish_source;

  List<dynamic> cows = [];

  List fishSpecies = [
    { 'name': 'রুই' },
    {'name': 'কাতলা'},
    {'name': 'মৃগেল'},
    {'name': 'তেলাপিয়া'},
    {'name': 'পাঙ্গাস'},
    {'name': 'শিং'},
    {'name': 'অন্যান্য'},
  ];

  List fishsource = [
    { 'name': 'সরকারী হ্যাচারি' },
    {'name': 'বেসরকারি হ্যাচারি'},
    {'name': 'নিজস্ব পুকুর'},
    {'name': 'অন্যান্য'},
  ];


  Future<void> _selectDate(BuildContext context,setState, selectedDate, void setSelectedDate(value)) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        setSelectedDate(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'মাছের পোনার তথ্য',),
      body: ListView(children: [

        Container( padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: InputDecorator(
              decoration: InputDecoration(
                border:
                OutlineInputBorder(
                    borderRadius: BorderRadius.circular(09.0)),
                contentPadding: const EdgeInsets.all(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                    isDense: true,
                    value: fish_spacies,
                    isExpanded: true,
                    menuMaxHeight: 350,
                    hint: Text('মাছের প্রজাতি নির্বাচন:', style: TextStyle(color: Colors.black87),),
                    items: [
                      ...fishSpecies.map<DropdownMenuItem<String>>((data) {
                        return DropdownMenuItem(
                            child: Text(data['name']), value: data['name'].toString());
                      }).toList(),
                    ],
                    onChanged: (value) {
                      print("selected Value $value");

                      setState(() {
                        fish_spacies = value!;
                      });
                    }),
              )
            // CustomTextField()
          ),
        ),

        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 03),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('  পোনা সংগ্রহের তারিখ: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                SizedBox(width: 02,),
                Text("${ponacollect_date!.toLocal()}".split(' ')[0], style: TextStyle(fontSize: 18),),
                SizedBox(width: 02,),
                GestureDetector(
                  onTap: () {
                    _selectDate(context, setState, ponacollect_date, (value) {ponacollect_date = value; });
                  },
                  child: Container(
                    padding: EdgeInsets.all(04),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Icon(Icons.calendar_month, color: Colors.white,),
                  ),

                )
              ],
            )
        ),

        Container(
          margin: EdgeInsets.fromLTRB(8.2, 10, 08.2, 0),
          child: TextField(
            controller: fishnumber,
            keyboardType: TextInputType.phone,
            obscureText: false,
            decoration: InputDecoration(
              hintText: "মাছের পোনার সংখ্যা:",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Rounded corners for the border
                borderSide: BorderSide(
                  color: Colors.black54, // Color of the border line
                  width: 12.0, // Thickness of the border line
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0), // Rounded corners for focused border
                borderSide: BorderSide(
                  color: Colors.blue, // Color when the TextField is focused
                  width: 2.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0), // Rounded corners for enabled border
                borderSide: BorderSide(
                  color: Colors.black54, // Color when the TextField is enabled (not focused)
                  width: 2.0,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 11.8, horizontal: 10), // Padding inside the TextField
            ),
          ),
        ),

        Container(
          margin: EdgeInsets.fromLTRB(8.2, 12, 08.2, 0),
          child: TextField(
            controller: fishweight,
            keyboardType: TextInputType.phone,
            obscureText: false,
            decoration: InputDecoration(
              hintText: "মাছের পোনার গড় ওজন: (গ্রাম)",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Rounded corners for the border
                borderSide: BorderSide(
                  color: Colors.black54, // Color of the border line
                  width: 12.0, // Thickness of the border line
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0), // Rounded corners for focused border
                borderSide: BorderSide(
                  color: Colors.blue, // Color when the TextField is focused
                  width: 2.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0), // Rounded corners for enabled border
                borderSide: BorderSide(
                  color: Colors.black54, // Color when the TextField is enabled (not focused)
                  width: 2.0,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 11.8, horizontal: 10), // Padding inside the TextField
            ),
          ),
        ),

        Container(
          margin: EdgeInsets.fromLTRB(8.2, 12, 08.2, 0),
          child: TextField(
            controller: fishage,
            keyboardType: TextInputType.phone,
            obscureText: false,
            decoration: InputDecoration(
              hintText: "মাছের পোনার বয়স: (দিন)",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Rounded corners for the border
                borderSide: BorderSide(
                  color: Colors.black54, // Color of the border line
                  width: 12.0, // Thickness of the border line
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0), // Rounded corners for focused border
                borderSide: BorderSide(
                  color: Colors.blue, // Color when the TextField is focused
                  width: 2.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0), // Rounded corners for enabled border
                borderSide: BorderSide(
                  color: Colors.black54, // Color when the TextField is enabled (not focused)
                  width: 2.0,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 11.8, horizontal: 10), // Padding inside the TextField
            ),
          ),
        ),

        SizedBox(height: 03,),

        Container( padding: EdgeInsets.symmetric(horizontal: 9, vertical: 09),
          child: InputDecorator(
              decoration: InputDecoration(
                border:
                OutlineInputBorder(
                    borderRadius: BorderRadius.circular(09.0)),
                contentPadding: const EdgeInsets.all(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                    isDense: true,
                    value: fish_source,
                    isExpanded: true,
                    menuMaxHeight: 350,
                    hint: Text('মাছের প্রজাতি নির্বাচন:', style: TextStyle(color: Colors.black87),),
                    items: [
                      ...fishsource.map<DropdownMenuItem<String>>((data) {
                        return DropdownMenuItem(
                            child: Text(data['name']), value: data['name'].toString());
                      }).toList(),
                    ],
                    onChanged: (value) {
                      print("selected Value $value");

                      setState(() {
                        fish_source= value!;
                      });
                    }),
              )
            // CustomTextField()
          ),
        ),

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


      ],),


    );
  }
}
