import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:tania_farm/components/CustomTextField.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class CalfCustomer extends StatefulWidget {
  const CalfCustomer({super.key});

  @override
  State<CalfCustomer> createState() => _CalfCustomerState();
}

class _CalfCustomerState extends State<CalfCustomer> {
  TextEditingController customer_name = TextEditingController();
  TextEditingController customer_address = TextEditingController();
  TextEditingController customer_mobile = TextEditingController();


  TextEditingController edit_customer_name = TextEditingController();
  TextEditingController edit_customer_address = TextEditingController();
  TextEditingController edit_customer_mobile = TextEditingController();


  List<dynamic> customers = [];



  void getData() async {
    final url = Uri.parse('http://68.178.163.174:5010/calf/customers');

    Response res = await get(url);

    setState(() {
      customers = jsonDecode(res.body);
    });
  }

  void addData() async {
    final url = Uri.parse('http://68.178.163.174:5010/calf/customers/add');
    Map body = {
      'name': customer_name.text,
      'address': customer_address.text,
      'mobile': customer_mobile.text
    };

    Response res = await post(url, body: body);

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

  void editData(id) async {
    final url = Uri.parse('http://68.178.163.174:5010/calf/customers/edit?id=${id}');
    Map body = {
      'name': edit_customer_name.text,
      'address': edit_customer_address.text,
      'mobile': edit_customer_mobile.text
    };

    Response res = await put(url, body: body);

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
    final url = Uri.parse('http://68.178.163.174:5010/calf/customers/delete?id=${id}');

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'ক্রেতাদের তালিকা',),
      body: ListView(children: [

        Container(
            margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
            child: CustomTextField(controller: customer_name, hintText: "নাম", obscureText: false, textinputtypephone: false)),
        Container(
            margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
            child: CustomTextField(controller: customer_address, hintText: "ঠিকানা", obscureText: false, textinputtypephone: false)),
        Container(
            margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
            child: CustomTextField(controller: customer_mobile, hintText: "ফোন নাম্বার", obscureText: false, textinputtypephone: false)),

        SizedBox(height: 10,),

        Container( padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(04),
          child: ElevatedButton(onPressed: (){
            addData();
          }, child: const Text("জমা দিন")),
        ),

        for(var i in customers)
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
                            child: Text('ক্রেতার নাম: ${i['name']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2),
                            child: Text('ক্রেতার ঠিকানা: ${i['address']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2),
                            child: Text('ক্রেতার ফোন নাম্বার: ${i['mobile']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
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
                               edit_customer_name.text = i['name'];
                               edit_customer_address.text = i['address'];
                               edit_customer_mobile.text = i['mobile'];

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
                                              Container(
                                                  margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
                                                  child: CustomTextField(controller: edit_customer_name, hintText: "নাম", obscureText: false, textinputtypephone: false)),
                                              Container(
                                                  margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
                                                  child: CustomTextField(controller: edit_customer_address, hintText: "ঠিকানা", obscureText: false, textinputtypephone: false)),
                                              Container(
                                                  margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
                                                  child: CustomTextField(controller: edit_customer_mobile, hintText: "ফোন নাম্বার", obscureText: false, textinputtypephone: false)),

                                              SizedBox(height: 10,),



                                              Container( padding: EdgeInsets.symmetric(horizontal: 80, vertical: 08),
                                                margin: EdgeInsets.all(04),
                                                child: ElevatedButton(onPressed: (){
                                                  editData(i['id']);
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
