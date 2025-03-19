import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:tania_farm/components/CustomTextField.dart';

class FishProduction extends StatefulWidget {
  const FishProduction({super.key});

  @override
  State<FishProduction> createState() => _FishProductionState();
}

class _FishProductionState extends State<FishProduction> {

  DateTime production_date = DateTime.now();
  TextEditingController fishnumber = TextEditingController();
  TextEditingController fishnumber1 = TextEditingController();
  TextEditingController fishduation = TextEditingController();
  String? fish_spacies;

  List fishspacies = [
    { 'name': 'সরকারী হ্যাচারি' },
    {'name': 'বেসরকারি হ্যাচারি'},
    {'name': 'নিজস্ব পুকুর'},
    {'name': 'অন্যান্য'},
  ];

  List rayat =[
    {'spacies': null, 'kg': TextEditingController()}
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
      appBar: CustomAppBar(title: 'উৎপাদন',),
      body: ListView(children: [

        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 08),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(' মাছ আহরণের তারিখ:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                SizedBox(width: 02,),
                Text("${production_date!.toLocal()}".split(' ')[0], style: TextStyle(fontSize: 18),),
                SizedBox(width: 02,),
                GestureDetector(
                  onTap: () {
                    _selectDate(context, setState, production_date, (value) {production_date = value; });
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
            margin: EdgeInsets.fromLTRB(2, 08, 2, 0),
            child: CustomTextField(controller: fishnumber, hintText: "আহরণকৃত মাছের মোট পরিমাণ: (কেজি বা টন)", obscureText: false, textinputtypephone: true)),

        for(var i in rayat)
        Row(
          children: [
            Container(
              width: 180,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
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
              width: 220,
              margin: EdgeInsets.fromLTRB(2, 03, 2, 0),
              child: CustomTextField(controller: i['kg'], hintText: "পরিমাণ (কেজি বা টন)", obscureText: false, textinputtypephone: true)),
          ],
        ),

        Container(
          padding: EdgeInsets.fromLTRB(11, 02, 220, 02),
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
            margin: EdgeInsets.fromLTRB(2, 08, 2, 03),
            child: CustomTextField(controller: fishduation, hintText: "মাছের উৎপাদন সময়কাল: (দিন বা মাস)", obscureText: false, textinputtypephone: true)),

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
