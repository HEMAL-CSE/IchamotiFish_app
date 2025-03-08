import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:http/http.dart';

class VermiCompostExpensesReport extends StatefulWidget {
  const VermiCompostExpensesReport({super.key});

  @override
  State<VermiCompostExpensesReport> createState() => _VermiCompostExpensesReportState();
}

class _VermiCompostExpensesReportState extends State<VermiCompostExpensesReport> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  List<dynamic> data  = [];

  var cowdungExpenses = '';

  var labourExpenses = '';

  List<dynamic> labourExpensesDetails = [];

  var totalExpenses = '';

  var othersExpenses = '';
  
  bool showLabourDetails = false;

  bool showOthersDetails = false;

  List<dynamic> othersExpensesDetails = [];

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
    final url = Uri.parse('http://68.178.163.174:5010/vermi_compost/report/expenses/cowdung?start_date=${startDate.toIso8601String()}&end_date=${endDate.toIso8601String()}');
    Response res = await get(url);

    var data = jsonDecode(res.body);

    print(data);
    final url2 = Uri.parse('http://68.178.163.174:5010/vermi_compost/report/expenses/labour?start_date=${startDate.toIso8601String()}&end_date=${endDate.toIso8601String()}');
    Response res2 = await get(url2);

    var data2 = jsonDecode(res2.body);

    print(data2);

    final url3 = Uri.parse('http://68.178.163.174:5010/vermi_compost/report/expenses/others?start_date=${startDate.toIso8601String()}&end_date=${endDate.toIso8601String()}');
    Response res3 = await get(url3);

    var data3 = jsonDecode(res3.body);

    print(data3);
    var x = data3.length > 0 ? data3[0]['amount'] : 0;
    var y = data2.length > 0 ? data2[0]['amount'] : 0;

    setState(() {
      cowdungExpenses = data.length > 0 ? data[0]['amount'].toString() : '0';
      labourExpenses = data2.length > 0 ? data2[0]['amount'].toString() : '0';
      othersExpenses = data3.length > 0 ? data3[0]['amount'].toString() : '0';
      totalExpenses = (x + y).toString();
    });

  }

  void getLabourDetails() async {
    final url = Uri.parse('http://68.178.163.174:5010/vermi_compost/report/expenses/labour/filter?start_date=${startDate.toIso8601String()}&end_date=${endDate.toIso8601String()}');
    Response res = await get(url);

    var data = jsonDecode(res.body);
    // print(data);

    setState(() {
      labourExpensesDetails = data;
      showLabourDetails = true;
    });
  }

  void getOthersDetails() async {
    final url = Uri.parse('http://68.178.163.174:5010/vermi_compost/report/expenses/others/filter?start_date=${startDate.toIso8601String()}&end_date=${endDate.toIso8601String()}');
    Response res = await get(url);

    var data = jsonDecode(res.body);
    // print(data);

    setState(() {
      othersExpensesDetails = data;
      showOthersDetails = true;
    });
  }

  // Future<void> _selectEditDate(BuildContext context, setStateSB) async {
  //   final DateTime? picked = await showDatePicker(
  //       context: context,
  //       initialDate: selectedEditDate,
  //       firstDate: DateTime(2015, 8),
  //       lastDate: DateTime(2101));
  //   if (picked != null && picked != selectedEditDate) {
  //     setStateSB(() {
  //       selectedEditDate = picked;
  //     });
  //   }
  // }

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
                Text('Cowdung (kg):', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), SizedBox(width: 20,),
                Text('${cowdungExpenses} kg', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),)
              ],),

              SizedBox(height: 12,),

              Row(children: [
                Text('Labour Cost:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), SizedBox(width: 20,),
                Text('${labourExpenses} BDT', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),)
              ],),

              SizedBox(height: 12,),

                Row(
                  children: [
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        getLabourDetails();
                      },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(20)
                          ),
                            child: Text('Labour Cost Details', style: TextStyle(fontSize: 16,),)
                        )
                    ),
                    Spacer()
                  ],
                ),
              SizedBox(width: 20,),
              
              showLabourDetails ?
                  SingleChildScrollView(
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text('Labour Name')),
                        DataColumn(label: Text('Amount'))
                      ],
                      rows: [
                        for(var i in labourExpensesDetails)
                          DataRow(cells: [
                            DataCell(Text('${i['name']}')),
                            DataCell(Text('${i['amount']}'))
                          ])
                      ],
                    ),
                  ): Text(''),

              Row(children: [
                Text('Others Cost:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), SizedBox(width: 20,),
                Text('${othersExpenses} BDT', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),)
              ],),

              SizedBox(height: 12,),

              Row(
                children: [
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        getOthersDetails();
                      },
                      child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text('Others Cost Details', style: TextStyle(fontSize: 16,),)
                      )
                  ),
                  Spacer()
                ],
              ),
              SizedBox(width: 20,),

              showOthersDetails ?
              SingleChildScrollView(
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Amount'))
                  ],
                  rows: [
                    for(var i in othersExpensesDetails)
                      DataRow(cells: [
                        DataCell(Text('${i['name']}')),
                        DataCell(Text('${i['amount']}'))
                      ])
                  ],
                ),
              ): Text(''),



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
