import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DairyDoctors extends StatefulWidget {
  const DairyDoctors({super.key});

  @override
  State<DairyDoctors> createState() => _DairyDoctorsState();
}

class _DairyDoctorsState extends State<DairyDoctors> {
  String? doctor_id;

  String? edit_doctor_id;

  List<dynamic> doctors = [];

  TextEditingController editid = TextEditingController();



  List<dynamic> data = [];

  void getData() async {
    final url = Uri.parse('http://68.178.163.174:5010/dairy/doctors');

    Response res = await get(url);

    setState(() {
      data = jsonDecode(res.body);
    });
  }

  void getDoctors() async {
    final url = Uri.parse('http://68.178.163.174:5010/doctors/approved');
    Response res = await get(url);

    setState(() {
      doctors = jsonDecode(res.body);
    });
  }

  void addData() async {
    final url = Uri.parse('http://68.178.163.174:5010/doctors/approved');

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? farm_id = await prefs.getString('farm_id');

    Map<String, dynamic> data = {'doctor_id': doctor_id, 'farm_id': farm_id};

    Response res = await post(url, body: data);

    if(res.statusCode == 201){
      Fluttertoast.showToast(
          msg: "Submitted",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0

      );
      setState(() {
        doctor_id = null;
      });
    }

    getData();

  }

  void editData() async {
    final url = Uri.parse('http://68.178.163.174:5010/dairy/doctors/edit?id=${editid.text}');

    Map<String, dynamic> data = {'doctor_id': edit_doctor_id};

    Response res = await put(url, body: data);

    if(res.statusCode == 201){
      Fluttertoast.showToast(
          msg: "Updated",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0

      );
    }

    getData();
  }

  void deleteData(id) async {
    final url = Uri.parse('http://68.178.163.174:5010/dairy/doctors/delete?id=${id}');

    Response res = await delete(url);

    if(res.statusCode == 201){
      Fluttertoast.showToast(
          msg: "Deleted",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0

      );
    }

    getData();
  }

  @override void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    getDoctors();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Doctor List',),
      body: ListView(children: [

        Container( padding: EdgeInsets.symmetric(horizontal: 12, vertical: 04),
          child: InputDecorator(
              decoration: InputDecoration(
                border:
                OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                contentPadding: const EdgeInsets.all(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                    isDense: true,
                    value: doctor_id,
                    isExpanded: true,
                    menuMaxHeight: 350,
                    hint: Text('Select Doctor'),
                    items: [
                      ...doctors.map<DropdownMenuItem<String>>((data) {
                        return DropdownMenuItem(
                            child: Text(data['name']), value: data['id'].toString());
                      }).toList(),
                    ],

                    onChanged: (value) {
                      print("selected Value $value");
                      setState(() {
                        doctor_id = value!;
                      });
                    }),


              )

            // CustomTextField()
          ),
        ),
        Container( padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(04),
          child: ElevatedButton(onPressed: (){
            addData();
          }, child: const Text("Submit")),
        ),

        for(var i in data)
          Column(
            children: [
              Container(
                height: 150,
                child: Card(
                  elevation: 5,

                  color: Colors.green[50],
                  child: Row(

                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2),
                              child: Text('Doctor Name: ${i['doctor_name']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 2),
                              child: Text('Email: ${i['doctor_email']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),),
                            ),

                          ]
                      ),
                      Spacer(),

                      Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.green[200],
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  editid.text = i['id'].toString();
                                  edit_doctor_id = i['doctor_id'].toString();

                                });

                                // getSeats(i['shed_id']);
                                showModalBottomSheet<void>(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {

                                    return StatefulBuilder(
                                        builder: (context, setStateSB) {
                                          return FractionallySizedBox(
                                            heightFactor: 0.9,
                                            // height: 200,
                                            // color: Colors.amber,
                                            child: Column(
                                              // mainAxisAlignment: MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Container( padding: EdgeInsets.symmetric(horizontal: 12, vertical: 04),
                                                  child: InputDecorator(
                                                      decoration: InputDecoration(
                                                        border:
                                                        OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(15.0)),
                                                        contentPadding: const EdgeInsets.all(10),
                                                      ),
                                                      child: DropdownButtonHideUnderline(
                                                        child: DropdownButton<String>(
                                                            isDense: true,
                                                            value: edit_doctor_id,
                                                            isExpanded: true,
                                                            menuMaxHeight: 350,
                                                            hint: Text('Select Doctor'),
                                                            items: [
                                                              ...doctors.map<DropdownMenuItem<String>>((data) {
                                                                return DropdownMenuItem(
                                                                    child: Text(data['name']), value: data['id'].toString());
                                                              }).toList(),
                                                            ],

                                                            onChanged: (value) {
                                                              print("selected Value $value");
                                                              setState(() {
                                                                edit_doctor_id = value!;
                                                              });
                                                            }),


                                                      )

                                                    // CustomTextField()
                                                  ),
                                                ),



                                                Container( padding: EdgeInsets.symmetric(horizontal: 80, vertical: 08),
                                                  margin: EdgeInsets.all(04),
                                                  child: ElevatedButton(onPressed: (){
                                                    editData();
                                                    Navigator.pop(context);
                                                  }, child: const Text("Save")),
                                                ),

                                                // SizedBox(height: MediaQuery.of(context).viewInsets.bottom+20,)

                                              ],
                                            ),
                                          );
                                        }
                                    );
                                  },
                                );
                              },
                              child: Icon(Icons.edit, color: Colors.green[500],),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    title: const Text('Do you want to delete this?'),
                                    // content: const Text('AlertDialog description'),
                                    actions: <Widget>[

                                      TextButton(
                                        onPressed: () => Navigator.pop(context, 'Cancel'),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: ()
                                        {
                                          deleteData(i['id']);
                                          Navigator.pop(context, 'OK');
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Icon(Icons.delete, color: Colors.red[300],),
                            )
                          ],
                        ),
                      )

                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,)
            ],
          )


      ],),
    );
  }
}
