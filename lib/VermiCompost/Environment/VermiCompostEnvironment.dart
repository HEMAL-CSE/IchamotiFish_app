import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class VermiCompostEnvironment extends StatefulWidget {
  const VermiCompostEnvironment({super.key});

  @override
  State<VermiCompostEnvironment> createState() => _VermiCompostEnvironmentState();
}

class _VermiCompostEnvironmentState extends State<VermiCompostEnvironment> {

  DateTime startDate = DateTime.now();

  DateTime endDate = DateTime.now();

  List<dynamic> data = [];

  var latest_data = {};

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

  void getLatestData() async {
    final url = Uri.parse('https://thingspeak.com/channels/2326600/feeds/last.json');

    Response res = await get(url);

    setState(() {
      latest_data = jsonDecode(res.body);
    });
  }

  void getData() async {

    final url = Uri.parse('https://thingspeak.com/channels/2326600/feeds.json?start=${startDate.toIso8601String()}&end=${endDate.toIso8601String()}');

    Response res = await get(url);

    print(jsonDecode(res.body));

    setState(() {
      data = jsonDecode(res.body)['feeds'];
    });
  }

  @override void initState() {
    // TODO: implement initState
    super.initState();

    getLatestData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Enivironment',),
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Latest Data', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),
          ),
        if(latest_data['created_at'] != null)
          Center(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text('Updated at: ${DateTime.parse(latest_data['created_at'])!.year}-${DateTime.parse(latest_data['created_at']).month}-${DateTime.parse(latest_data['created_at']).day}, time: ${DateFormat('h:mma').format(DateTime.parse(latest_data['created_at']).add(Duration(hours: 6)))}'),
            ),
          ),
          
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.green[200],
              borderRadius: BorderRadius.circular(20)
            ),
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Soil Humidity(%): ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    Text('${latest_data['field1']}'),
                  ],
                ),

                SizedBox(height: 10,),

                Row(
                  children: [
                    Text('Soil Temperature(C): ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    Text('${latest_data['field2']}'),
                  ],
                ),

                SizedBox(height: 10,),
                Row(
                  children: [
                    Text('Conductivity: ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    Text('${latest_data['field3']}'),
                  ],
                ),

                SizedBox(height: 10,),
                Row(
                  children: [
                    Text('pH: ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    Text('${latest_data['field4']}'),
                  ],
                ),

                SizedBox(height: 10,),
                Row(
                  children: [
                    Text('Nitrogen: ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    Text('${latest_data['field5']}'),
                  ],
                ),

                SizedBox(height: 10,),
                Row(
                  children: [
                    Text('Phosphorus: ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    Text('${latest_data['field6']}'),
                  ],
                ),

                SizedBox(height: 10,),
                Row(
                  children: [
                    Text('Potassium: ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    Text('${latest_data['field7']}'),
                  ],
                ),
              ],
            ),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Historical Data', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),
          ),

          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Start Date: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                  Text("${startDate!.toLocal()}".split(' ')[0], style: TextStyle(fontSize: 20),),
                  GestureDetector(
                    onTap: () {
                      _selectDate(context,setState, startDate, (value) {startDate = value;});
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
                  Text('End Date: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                  Text("${endDate!.toLocal()}".split(' ')[0], style: TextStyle(fontSize: 20),),
                  GestureDetector(
                    onTap: () {
                      _selectDate(context,setState, endDate, (value) {endDate = value;});
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

          Container( padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(04),
            child: ElevatedButton(onPressed: (){
              getData();
            }, child: const Text("Submit")),
          ),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(columns: [
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('Entry ID')),
              DataColumn(label: Text('Soil Humidity')),
              DataColumn(label: Text('Soil Temperature')),
              DataColumn(label: Text('Conductivity')),
              DataColumn(label: Text('pH')),
              DataColumn(label: Text('Nitrogen')),
              DataColumn(label: Text('Phosphorus')),
              DataColumn(label: Text('Potassium')),
            ], rows: [
              for(var i in data)
              DataRow(cells: [
                DataCell(Text('${DateTime.parse(i['created_at']).year}-${DateTime.parse(i['created_at']).month}-${DateTime.parse(i['created_at']).day}')),
                DataCell(Text('${i['entry_id']}')),
                DataCell(Text('${i['field1']}')),
                DataCell(Text('${i['field2']}')),
                DataCell(Text('${i['field3']}')),
                DataCell(Text('${i['field4']}')),
                DataCell(Text('${i['field5']}')),
                DataCell(Text('${i['field6']}')),
                DataCell(Text('${i['field7']}'))

              ])
            ]),


          ),
        ],
      ),
    );
  }
}
