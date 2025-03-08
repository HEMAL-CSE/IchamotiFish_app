import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:http/http.dart';

class ApprovedDoctor extends StatefulWidget {
  const ApprovedDoctor({super.key});

  @override
  State<ApprovedDoctor> createState() => _ApprovedDoctorState();
}

class _ApprovedDoctorState extends State<ApprovedDoctor> {
  List<dynamic> data = [];

  void getData() async {
    final url = Uri.parse('http://68.178.163.174:5010/doctors/approved');
    Response res = await get(url);

    // print(jsonDecode(res.body));

    setState(() {
      data = jsonDecode(res.body);
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
      appBar: CustomAppBar(title: 'Approved Doctor',),
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Approved Doctors', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text('User Code')),
                DataColumn(label: Text('Doctor Email')),
                DataColumn(label: Text('Doctor ID')),
                DataColumn(label: Text('Doctor Name'))
              ],
              rows: [
                for(var i in data)
                  DataRow(cells: [
                    DataCell(Text('${i['user_code']}')),
                    DataCell(Text('${i['email']}')),
                    DataCell(Text('${i['id']}')),
                    DataCell(Text('${i['name']}')),
                  ])
              ],
            ),
          )
        ],
      ),
    );
  }
}
