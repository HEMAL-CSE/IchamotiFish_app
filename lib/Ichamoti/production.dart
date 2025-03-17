import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';

class FishProduction extends StatefulWidget {
  const FishProduction({super.key});

  @override
  State<FishProduction> createState() => _FishProductionState();
}

class _FishProductionState extends State<FishProduction> {

  DateTime production_date = DateTime.now();


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
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 03),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('  পোনা সংগ্রহের তারিখ: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
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

      ],),

    );
  }
}
