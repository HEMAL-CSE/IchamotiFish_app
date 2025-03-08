import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:tania_farm/components/CustomTextField.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class VermiSellsBuyersList extends StatefulWidget {
  const VermiSellsBuyersList({super.key});

  @override
  State<VermiSellsBuyersList> createState() => _VermiSellsBuyersListState();
}

class _VermiSellsBuyersListState extends State<VermiSellsBuyersList> {
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phone = TextEditingController();


  TextEditingController editname = TextEditingController();
  TextEditingController editaddress = TextEditingController();
  TextEditingController editphone = TextEditingController();

  TextEditingController editid = TextEditingController();

  List data = [];

  void getData() async{
    final url = Uri.parse('http://68.178.163.174:5010/vermi_compost/vermicompost_buyer');

    Response res = await get(url);

    setState(() {
      data = jsonDecode(res.body);

    });

    FocusManager.instance.primaryFocus?.unfocus();
  }

  void addData() async {
    final url = Uri.parse('http://68.178.163.174:5010/vermi_compost/vermicompost_buyer/add');

    Map<String, dynamic> data = { 'name': name.text, 'address': address.text, 'mobile_no': phone.text  };

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
        name.text = '';
        address.text = '';
        phone.text = '';
      });

    }


    getData();
  }

  void editData() async {
    final url = Uri.parse('http://68.178.163.174:5010/vermi_compost/vermicompost_buyer/edit?id=${editid.text}');

    Map<String, dynamic> data = {  'name': editname.text, 'address': editaddress.text, 'mobile_no': editphone.text };

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

      getData();
    }


    getData();
  }

  void deleteData(id) async{
    final url = Uri.parse('http://68.178.163.174:5010/vermi_compost/vermicompost_buyer/delete?id=${id}');
    Response res = await delete(url);

    if(res.statusCode == 201){
      Fluttertoast.showToast(
          msg: "Deleted",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0

      );

      getData();
    }

    getData();
  }

  @override void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ' Buyers Information',),
      body: ListView(children: [
        Container(
            margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
            child: CustomTextField(controller: name, hintText: "Enter Buyers Name", obscureText: false, textinputtypephone: false)),

        Container(
            margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
            child: CustomTextField(controller: address, hintText: "Enter Buyers Address", obscureText: false, textinputtypephone: false)),

        Container(
            margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
            child: CustomTextField(controller: phone, hintText: "Enter Mobile Number", obscureText: false, textinputtypephone: true)),

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
                              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                              child: Text('ID: ${i['id']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                              child: Text('Name: ${i['name']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),),
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                              child: Text('Mobile: ${i['mobile_no']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),),
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
                                  editname.text = i['name'];
                                  editaddress.text = i['address'];
                                  editphone.text = i['mobile_no'].toString();
                                });

                                showModalBottomSheet<void>(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {

                                    return StatefulBuilder(
                                        builder: (context, setStateSB) {
                                          return FractionallySizedBox(
                                            heightFactor: 0.8,
                                            // height: 200,
                                            // color: Colors.amber,
                                            child: Column(
                                              // mainAxisAlignment: MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Container(
                                                    margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
                                                    child: CustomTextField(controller: editname, hintText: "Enter Buyers Name", obscureText: false, textinputtypephone: false)),

                                                Container(
                                                    margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
                                                    child: CustomTextField(controller: editaddress, hintText: "Enter Buyers Address", obscureText: false, textinputtypephone: false)),

                                                Container(
                                                    margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
                                                    child: CustomTextField(controller: editphone, hintText: "Enter Mobile Number", obscureText: false, textinputtypephone: true)),

                                                const SizedBox(
                                                  height: 20,
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
