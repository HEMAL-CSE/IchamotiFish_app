import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:tania_farm/components/CustomTextField.dart';

class Foodexpenses extends StatefulWidget {
  const Foodexpenses({super.key});

  @override
  State<Foodexpenses> createState() => _FoodexpensesState();
}

class _FoodexpensesState extends State<Foodexpenses> {
  DateTime production_date = DateTime.now();

  String? fish_spacies;
  TextEditingController fishnumber = TextEditingController();

  List fishSpecies = [
    { 'name': 'প্রাকৃতিক খাদ্য' },
    {'name': 'ফিড জাতীয় খাদ্য'},
    {'name': 'তরল খাদ্য'},
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
      appBar: CustomAppBar(title: 'খাদ্য ব্যবস্থাপনা খরচ',),

      body: ListView(
        children: [

          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 08),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('  খাদ্য কেনার তারিখ:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
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

          Container( padding: EdgeInsets.symmetric(horizontal: 10, vertical: 08),
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
                      hint: Text('খাদ্যের ধরন নির্বাচন:', style: TextStyle(color: Colors.black87),),
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
              margin: EdgeInsets.fromLTRB(2, 08, 2, 0),
              child: CustomTextField(controller: fishnumber, hintText: "মাছের খাদ্যের কেনার পরিমাণ: (কেজি বা টন)", obscureText: false, textinputtypephone: true)),

        ],
      ),

    );
  }
}
