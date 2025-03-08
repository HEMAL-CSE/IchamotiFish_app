import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:tania_farm/components/CustomDatePicker.dart';
import 'package:http/http.dart';

class DairyPurchaseReport extends StatefulWidget {
  const DairyPurchaseReport({super.key});

  @override
  State<DairyPurchaseReport> createState() => _DairyPurchaseReportState();
}

class _DairyPurchaseReportState extends State<DairyPurchaseReport> {
  var startDate = DateTime.now();

  var endDate = DateTime.now();

  String totalPurchase = '0';

  String totalPurchasePrice = '0';

  Future<void> selectDate(BuildContext context,setState, selectedDate, void setSelectedDate(value)) async {
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
    final url = Uri.parse('http://68.178.163.174:5010/dairy/report/purchase?start_date=${startDate.toIso8601String()}&end_date=${endDate.toIso8601String()}');

    Response res = await get(url);

    var data = jsonDecode(res.body);

    setState(() {
      totalPurchase = data.length > 0 ? data[0]['total'].toString() : '0';
      totalPurchasePrice = data.length > 0 ? data[0]['purchase_price'].toString() : '0';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Purchase Report',),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),

            CustomDatePicker(date: startDate, selectDate: () {
              selectDate(context, setState, startDate, (value) {
                setState(() {
                  startDate = value;
                });
              });
            }, title: 'Select Date: '),

            CustomDatePicker(date: endDate,
                selectDate: () {
                  selectDate(context, setState, endDate, (value) {
                    setState(() {
                      endDate = value;
                    });
                  });
                },
                title: 'End Date: '),

            ElevatedButton(onPressed: () {
              getData();
            }, child: Text('Search')),

            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey)
              ),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10), margin: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Row(children: [
                    Text('Total Purchase:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), SizedBox(width: 20,),
                    Text('${totalPurchase}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),)
                  ],),

                  SizedBox(height: 12,),

                  Row(children: [
                    Text('Total Purchase Price:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), SizedBox(width: 20,),
                    Text('${totalPurchasePrice} BDT', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),)
                  ],),

                  SizedBox(width: 20,),



                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
