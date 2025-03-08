import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class ApproveDoctor extends StatefulWidget {
  const ApproveDoctor({super.key});

  @override
  State<ApproveDoctor> createState() => _ApproveDoctorState();
}

class _ApproveDoctorState extends State<ApproveDoctor> {

  var data = [];

  void getData() async {
    final url = Uri.parse('http://68.178.163.174:5010/doctors');

    Response res = await get(url);

    setState(() {
      data = jsonDecode(res.body);
    });
  }

  void handleApprove(id, user_id) async {
    final url = Uri.parse('http://68.178.163.174:5010/doctors/approve?id=${id}&user_id=${user_id}');

    Response res = await put(url);

    if(res.statusCode == 201){
      Fluttertoast.showToast(
          msg: "Submited",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0

      );

      getData();
    }
  }

  @override void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Approve Doctor',),
      body: ListView(
        children: [
          for(var i in data)
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: Card(
              elevation:5,
              child: Column(
                children: [
                  Text('Name: ${i['name']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  Text('Address: ${i['address']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  Text('Email: ${i['email']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          handleApprove(i['id'],i['user_id']);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent
                          ),
                          child: Text('Approve', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
