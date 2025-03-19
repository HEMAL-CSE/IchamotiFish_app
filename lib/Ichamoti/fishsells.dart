import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:tania_farm/components/CustomTextField.dart';

class Fishsells extends StatefulWidget {
  const Fishsells({super.key});

  @override
  State<Fishsells> createState() => _FishsellsState();
}

class _FishsellsState extends State<Fishsells> {

  DateTime sells_date = DateTime.now();
  TextEditingController totalfishsell = TextEditingController();
  TextEditingController totalsellingprice = TextEditingController();

  String? fish_spacies;

  List fishSpecies = [
    { 'name': 'স্থানীয় বাজার' },
    {'name': 'পাইকারি বাজার'},
    {'name': 'অনলাইন প্ল্যাটফর্ম'},
  ];

  List rayat =[
    {'spacies': null, 'kg': TextEditingController()}
  ];

  List fishspacies = [
    { 'name': 'রুই' },
    {'name': 'কাতলা'},
    {'name': 'মৃগেল'},
    {'name': 'তেলাপিয়া'},
    {'name': 'পাঙ্গাস'},
    {'name': 'শিং'},
    {'name': 'অন্যান্য'},
  ];

  List rayat1 =[
    {'spacies': null, 'kg': TextEditingController()}
  ];

  List fishspacies1 = [
    { 'name': 'রুই' },
    {'name': 'কাতলা'},
    {'name': 'মৃগেল'},
    {'name': 'তেলাপিয়া'},
    {'name': 'পাঙ্গাস'},
    {'name': 'শিং'},
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
      appBar: CustomAppBar(title: 'বিক্রয়',),
      body: ListView(children: [

        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 08),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('  মাছ বিক্রয়ের তারিখ:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                SizedBox(width: 02,),
                Text("${sells_date!.toLocal()}".split(' ')[0], style: TextStyle(fontSize: 18),),
                SizedBox(width: 02,),
                GestureDetector(
                  onTap: () {
                    _selectDate(context, setState, sells_date, (value) {sells_date = value; });
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
                    hint: Text('বিক্রয়ের স্থান:', style: TextStyle(color: Colors.black87),),
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

        Container(
            margin: EdgeInsets.fromLTRB(2, 07.5, 2, 0),
            child: CustomTextField(controller: totalfishsell, hintText: "বিক্রিত মাছের মোট পরিমাণ: (কেজি বা টন)", obscureText: false, textinputtypephone: true)),


        for(var i in rayat)
          Row(
            children: [
              Container(
                width: 170,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                          value: i['spacies'],
                          isExpanded: true,
                          menuMaxHeight: 350,
                          hint: Text('মাছের প্রজাতি নির্বাচন:', style: TextStyle(color: Colors.black87),),
                          items: [
                            ...fishspacies.map<DropdownMenuItem<String>>((data) {
                              return DropdownMenuItem(
                                  child: Text(data['name']), value: data['name'].toString());
                            }).toList(),
                          ],
                          onChanged: (value) {
                            var copy=rayat;
                            copy[copy.indexOf(i)]['spacies']=value;
                            print("selected Value $value");

                            setState(() {
                              rayat=copy;
                            });
                          }),
                    )
                  // CustomTextField()
                ),
              ),

              Container(
                  width: 235,
                  margin: EdgeInsets.fromLTRB(0, 03, 2, 0),
                  child: CustomTextField(controller: i['kg'], hintText: "প্রতিকেজি বা প্রতিটন দাম ", obscureText: false, textinputtypephone: true)),
            ],
          ),

        Container(
          padding: EdgeInsets.fromLTRB(11, 0, 222, 02),
          margin: EdgeInsets.all(04),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                backgroundColor: Color(0xff076614),
                foregroundColor: Colors.white,
              ),
              onPressed: (){
                setState(() {
                  rayat.add( {'spacies': null, 'kg': TextEditingController()}
                  );
                });
              }, child: const Text("আরও যোগ করুন", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)),
        ),

        // For sell with price
        for(var i in rayat1)
          Row(
            children: [
              Container(
                width: 175,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15.5),
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
                          value: i['spacies'],
                          isExpanded: true,
                          menuMaxHeight: 350,
                          hint: Text('মাছের প্রজাতি নির্বাচন:', style: TextStyle(color: Colors.black87),),
                          items: [
                            ...fishspacies1.map<DropdownMenuItem<String>>((data) {
                              return DropdownMenuItem(
                                  child: Text(data['name']), value: data['name'].toString());
                            }).toList(),
                          ],
                          onChanged: (value) {
                            var copy=rayat1;
                            copy[copy.indexOf(i)]['spacies']=value;
                            print("selected Value $value");

                            setState(() {
                              rayat1=copy;
                            });
                          }),
                    )
                  // CustomTextField()
                ),
              ),

              Container(
                  width: 232,
                  margin: EdgeInsets.fromLTRB(0, 03, 2, 0),
                  child: CustomTextField(controller: i['kg'], hintText: "প্রজাতি অনুযায়ী বিক্রিত মূল্য", obscureText: false, textinputtypephone: true)),
            ],
          ),

        Container(
          padding: EdgeInsets.fromLTRB(11, 0, 222, 02),
          margin: EdgeInsets.all(04),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                backgroundColor: Color(0xff076614),
                foregroundColor: Colors.white,
              ),
              onPressed: (){
                setState(() {
                  rayat.add( {'spacies': null, 'kg': TextEditingController()}
                  );
                });
              }, child: const Text("আরও যোগ করুন", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)),
        ),

        Container(
            margin: EdgeInsets.fromLTRB(2, 12, 2, 0),
            child: CustomTextField(controller: totalfishsell, hintText: "বিক্রিত মাছের মোট মূল্য: (টাকা)", obscureText: false, textinputtypephone: true)),

        Container( padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(04),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
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
