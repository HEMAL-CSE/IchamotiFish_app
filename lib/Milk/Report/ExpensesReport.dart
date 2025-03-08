import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:http/http.dart';

class DairyExpensesReport extends StatefulWidget {
  const DairyExpensesReport({super.key});

  @override
  State<DairyExpensesReport> createState() => _DairyExpensesReportState();
}

class _DairyExpensesReportState extends State<DairyExpensesReport> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  List<dynamic> data  = [];

  var feedExpenses = '';

  var labourExpenses = '';

  var totalExpenses = '';

  var othersExpenses = '';


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
    final url = Uri.parse('http://68.178.163.174:5010/dairy/report/expenses/feed?start_date=${startDate.toIso8601String()}&end_date=${endDate.toIso8601String()}');
    Response res = await get(url);

    var data = jsonDecode(res.body);

    print(data);
    final url2 = Uri.parse('http://68.178.163.174:5010/dairy/report/expenses/labour?start_date=${startDate.toIso8601String()}&end_date=${endDate.toIso8601String()}');
    Response res2 = await get(url2);

    var data2 = jsonDecode(res2.body);

    print(data2);

    final url3 = Uri.parse('http://68.178.163.174:5010/dairy/report/expenses/others?start_date=${startDate.toIso8601String()}&end_date=${endDate.toIso8601String()}');
    Response res3 = await get(url3);

    var data3 = jsonDecode(res3.body);

    print(data3);
    var x = data3.length > 0 ? data3[0]['payment'] : 0;
    var y = data2.length > 0 ? data2[0]['payment'] : 0;
    var z = data.length > 0 ? data[0]['price'] : 0;

    setState(() {
      feedExpenses = data.length > 0 ? data[0]['price'].toString() : '0';
      labourExpenses = data2.length > 0 ? data2[0]['payment'].toString() : '0';
      othersExpenses = data3.length > 0 ? data3[0]['payment'].toString() : '0';
      totalExpenses = (x + y + z).toString();
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
      appBar: CustomAppBar(title: 'Expenses Report',),
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
                Text('Feed (TK):', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), SizedBox(width: 20,),
                Text('${feedExpenses} TK', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),)
              ],),

              SizedBox(height: 12,),

              Row(children: [
                Text('Labour Cost:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), SizedBox(width: 20,),
                Text('${labourExpenses} BDT', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),)
              ],),

              SizedBox(width: 20,),


              Row(children: [
                Text('Others Cost:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), SizedBox(width: 20,),
                Text('${othersExpenses} BDT', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),)
              ],),

              SizedBox(height: 12,),


            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(children: [
            Text('Total Expenses:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), SizedBox(width: 20,),
            Text('${totalExpenses} BDT', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),)
          ],),
        ),

      ],),
    );
  }
}
