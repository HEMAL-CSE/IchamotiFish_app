import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:http/http.dart';

class BeefIncomeReport extends StatefulWidget {
  const BeefIncomeReport({super.key});

  @override
  State<BeefIncomeReport> createState() => _BeefIncomeReportState();
}

class _BeefIncomeReportState extends State<BeefIncomeReport> {

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  var totalSellAmount = '';
  var totalSellCost = '';

  List<dynamic> daywise = [];

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

  void getData() async {
    final url = Uri.parse('http://68.178.163.174:5010/vermi_compost/report/sells?start_date=${startDate.toIso8601String()}&end_date=${endDate.toIso8601String()}');

    Response res = await get(url);

    var data = jsonDecode(res.body);

    setState(() {
      totalSellAmount = data['total'].length > 0 ? data['total'][0]['amount'].toString() : '0';
      totalSellCost = data['total'].length > 0 ? data['total'][0]['cost'].toString() : '0';
      daywise = data['day_wise'];
    });
  }

  @override void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Income Report',),
      body: ListView(children: [

        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Start Date: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                Text("${startDate!.toLocal()}".split(' ')[0], style: TextStyle(fontSize: 20),),
                GestureDetector(
                  onTap: () {
                    _selectDate(context, setState, startDate, (value) {startDate = value;});
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
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('End Date: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                Text("${endDate!.toLocal()}".split(' ')[0], style: TextStyle(fontSize: 20),),
                GestureDetector(
                  onTap: () {
                    _selectDate(context, setState, endDate, (value) {endDate = value;});
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

        Container( padding: EdgeInsets.symmetric(horizontal: 80, vertical: 08),
          margin: EdgeInsets.all(04),
          child: ElevatedButton(onPressed: (){
            getData();
            // Navigator.pop(context);
          }, child: const Text("Search")),
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
                Text('${totalSellAmount}Kg', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                SizedBox(width: 16,),
                Text('${totalSellCost}Tk', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),)
              ],),

              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 2),
                child: Text('Day Wise Production:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(columns: [
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Kg')),
                  DataColumn(label: Text('Cost'))
                ], rows: [
                  for(var i in daywise)
                    DataRow(cells: [
                      DataCell(Text("${DateTime.parse(i['date']).toLocal()}".split(' ')[0])),
                      DataCell(Text('${i['amount']}')),
                      DataCell(Text('${i['cost']}'))
                    ]),

                ]),
              )

            ],
          ),
        )


      ],),
    );
  }
}
