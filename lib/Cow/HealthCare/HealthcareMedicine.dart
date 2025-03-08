import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:tania_farm/components/CustomTextField.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class BreedingMedicines extends StatefulWidget {
  const BreedingMedicines({super.key});

  @override
  State<BreedingMedicines> createState() => _BreedingMedicinesState();
}

class _BreedingMedicinesState extends State<BreedingMedicines> {
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();

  List data = [];

  TextEditingController editId = TextEditingController();
  TextEditingController editName = TextEditingController();
  TextEditingController editPrice = TextEditingController();


  void getData() async {
    final url = Uri.parse('http://68.178.163.174:5010/breeding/medicines');

    Response res = await get(url);

    setState(() {
      data = jsonDecode(res.body);
    });
  }

  void addData() async {
    final url = Uri.parse('http://68.178.163.174:5010/breeding/medicines/add');

    Map data = {
      'name': name.text,
      'price': price.text,
    };

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
    }

    getData();
  }

  void editData() async{
    final url = Uri.parse('http://68.178.163.174:5010/breeding/medicines/edit?id=${editId.text}');

    Map data = {
      'name': editName.text,
      'price': editPrice.text,
    };

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
    final url = Uri.parse('http://68.178.163.174:5010/breeding/medicines/delete?id=${id}');

    Response res = await delete(url);

    if(res.statusCode == 201) {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Vaccines',),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            CustomTextField(controller: name, hintText: 'Medicine Name', obscureText: false, textinputtypephone: false),
            SizedBox(height: 10,),
            CustomTextField(controller: price, hintText: 'Medicine Price', obscureText: false, textinputtypephone: true),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: (){
              addData();
            }, child: Text('Submit')),

            SizedBox(height: 20,),

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
                                  child: Text('Medicine Name: ${i['name']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 2),
                                  child: Text('Medicine Price: ${i['price']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),),
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
                                      editId.text = i['id'].toString();
                                      editName.text = i['name'].toString();
                                      editPrice.text = i['price'].toString();


                                    });
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


                                                    Container(
                                                        margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
                                                        child: CustomTextField(controller: editName, hintText: "Vaccine Name", obscureText: false, textinputtypephone: false)),

                                                    Container(
                                                        margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
                                                        child: CustomTextField(controller: editPrice, hintText: "Vaccine Price", obscureText: false, textinputtypephone: true)),




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
          ],
        ),
      ),
    );
  }
}