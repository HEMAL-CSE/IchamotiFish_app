import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';

class VermiCompostprofitReport extends StatefulWidget {
  const VermiCompostprofitReport({super.key});

  @override
  State<VermiCompostprofitReport> createState() => _VermiCompostprofitReportState();
}

class _VermiCompostprofitReportState extends State<VermiCompostprofitReport> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title:  'Report',),
      body: ListView(children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Select Date: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                Text("${selectedDate!.toLocal()}".split(' ')[0], style: TextStyle(fontSize: 20),),
                GestureDetector(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(6),
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
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey)
          ),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10), margin: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Row(children: [
                Text('Total Selling:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), SizedBox(width: 18,),
                Text('120Kg', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
              ],),

            ],
          ),
        )

      ],),
    );
  }
}
