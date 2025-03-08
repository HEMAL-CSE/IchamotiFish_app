import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:tania_farm/components/CustomTextField.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class LabourList extends StatefulWidget {
  const LabourList({Key? key}) : super(key: key);

  @override
  State<LabourList> createState() => _LabourListState();
}

class _LabourListState extends State<LabourList> {
  List dropDownListData = [
    {"title": "Daily", "value": 'Daily'},
    {"title": "Monthly", "value": 'Monthly'},
    // {"title": "Suppliers", "value": "3"},
  ];
  String? shed_id;

  String? edit_shed_id;

  List sheds = [];

  TextEditingController name = TextEditingController(); // labourname
  TextEditingController mobile_no = TextEditingController();
  TextEditingController edit_mobile_no = TextEditingController();

  TextEditingController amount = TextEditingController(); //amount

  String? salary_status;

  TextEditingController editid = TextEditingController();

  TextEditingController editname = TextEditingController(); // labourname

  TextEditingController editamount = TextEditingController(); //amount

  String? edit_salary_status;

  DateTime selectedDate = DateTime.now();

  DateTime selectedEditDate = DateTime.now();

  List<dynamic> data = [];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectEditDate(BuildContext context, setStateSB) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedEditDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedEditDate) {
      setStateSB(() {
        selectedEditDate = picked;
      });
    }
  }

  void getSheds() async {
    final url = Uri.parse('http://68.178.163.174:5010/vermi_compost/sheds');

    Response res = await get(url);

    setState(() {
      sheds = jsonDecode(res.body);
    });
  }

  void getData() async {
    final url =
        Uri.parse('http://68.178.163.174:5010/vermi_compost/labour_list');

    Response res = await get(url);

    setState(() {
      data = jsonDecode(res.body);
    });

    FocusManager.instance.primaryFocus?.unfocus();
  }

  void addData() async {
    final url =
        Uri.parse('http://68.178.163.174:5010/vermi_compost/labour_list/add');

    Map<String, dynamic> data = {
      'name': name.text,
      'amount': amount.text,
      'date': selectedDate.toIso8601String(),
      'salary_status': salary_status,
      'mobile_no': mobile_no.text,
      'shed_id': shed_id.toString()
    };

    Response res = await post(url, body: data);

    if (res.statusCode == 201) {
      Fluttertoast.showToast(
          msg: "Submitted",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);

      setState(() {
        mobile_no.text = '';
        name.text = '';
        salary_status = null;
        shed_id = null;
      });
    }

    getData();
  }

  void editData() async {
    final url = Uri.parse(
        'http://68.178.163.174:5010/vermi_compost/labour_list/edit?id=${editid.text}');

    Map<String, dynamic> data = {
      'name': editname.text,
      'amount': editamount.text,
      'date': selectedEditDate.toIso8601String(),
      'salary_status': edit_salary_status,
      'mobile_no': edit_mobile_no.text,
      'shed_id': edit_shed_id.toString()
    };

    Response res = await put(url, body: data);

    if (res.statusCode == 201) {
      Fluttertoast.showToast(
          msg: "Updated",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);

      // getData();
    }

    getData();
  }

  void deleteData(id) async {
    final url = Uri.parse(
        'http://68.178.163.174:5010/vermi_compost/labour_list/delete?id=${id}');
    Response res = await delete(url);

    if (res.statusCode == 201) {
      Fluttertoast.showToast(
          msg: "Deleted",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      // getData();
    }

    getData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    getSheds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'শ্রমিকদের তালিকা',
        ), //Appbar
        body: ListView(
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
                child: CustomTextField(
                    controller: name,
                    hintText: "শ্রমিকের নাম",
                    obscureText: false,
                    textinputtypephone: false)), //Custom TextFeild

            Container(
                margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
                child: CustomTextField(
                    controller: mobile_no,
                    hintText: "মোবাইল নাম্বার",
                    obscureText: false,
                    textinputtypephone: true)),

            const SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 04),
              child: InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    contentPadding: const EdgeInsets.all(10),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                        isDense: true,
                        value: salary_status,
                        isExpanded: true,
                        menuMaxHeight: 350,
                        hint: Text('বেতনের অবস্থা সিলেক্ট করুন'),
                        items: [
                          ...dropDownListData
                              .map<DropdownMenuItem<String>>((data) {
                            return DropdownMenuItem(
                                child: Text(data['title']),
                                value: data['value']);
                          }).toList(),
                        ],
                        onChanged: (value) {
                          print("selected Value $value");

                          setState(() {
                            salary_status = value!;
                          });
                        }),
                  )

                  // CustomTextField()
                  ),
            ),

            SizedBox(
              height: 10,
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 04),
              child: InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    contentPadding: const EdgeInsets.all(10),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                        isDense: true,
                        value: shed_id,
                        isExpanded: true,
                        menuMaxHeight: 350,
                        hint: Text('বরাদ্দকৃত শেড'),
                        items: [
                          ...sheds.map<DropdownMenuItem<String>>((data) {
                            return DropdownMenuItem(
                                child: Text(data['name']),
                                value: data['id'].toString());
                          }).toList(),
                        ],
                        onChanged: (value) {
                          print("selected Value $value");

                          setState(() {
                            shed_id = value!;
                          });
                        }),
                  )

                  // CustomTextField()
                  ),
            ),

            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(04),
              child: ElevatedButton(
                  onPressed: () {
                    addData();
                  },
                  child: const Text("জমা দিন")),
            ),

            SizedBox(
              height: 20,
            ),

            for (var i in data)
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 5),
                                  child: Text(
                                    '${i['name']}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 5),
                                  child: Text(
                                    'Shed ID: ${i['shed_id']}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 5),
                                  child: Text(
                                    'Salary Staus: ${i['salary_status']}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 5),
                                  child: Text(
                                    'Mobile Number: ${i['mobile_no']}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey),
                                  ),
                                ),
                              ]),
                          Spacer(),
                          Container(
                            margin: EdgeInsets.all(15),
                            padding: EdgeInsets.symmetric(vertical: 10),
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.green[200],
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      editid.text = i['id'].toString();
                                      editname.text = i['name'].toString();
                                      edit_salary_status =
                                          i['salary_status'].toString();
                                      edit_mobile_no.text =
                                          i['mobile_no'] != null
                                              ? i['mobile_no']
                                              : '';
                                      edit_shed_id = i['shed_id'] != null
                                          ? i['shed_id'].toString()
                                          : null;
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
                                                    margin: EdgeInsets.fromLTRB(
                                                        2, 16, 2, 0),
                                                    child: CustomTextField(
                                                        controller: editname,
                                                        hintText: "Labour Name",
                                                        obscureText: false,
                                                        textinputtypephone:
                                                            false)), //Custom TextFeild

                                                Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        2, 16, 2, 0),
                                                    child: CustomTextField(
                                                        controller:
                                                            edit_mobile_no,
                                                        hintText:
                                                            "Mobile Number",
                                                        obscureText: false,
                                                        textinputtypephone:
                                                            false)), //Custom TextFeild

                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 04),
                                                  child: InputDecorator(
                                                      decoration:
                                                          InputDecoration(
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0)),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .all(10),
                                                      ),
                                                      child:
                                                          DropdownButtonHideUnderline(
                                                        child: DropdownButton<
                                                                String>(
                                                            isDense: true,
                                                            value:
                                                                edit_salary_status,
                                                            isExpanded: true,
                                                            hint: Text(
                                                                'Select Salary Status'),
                                                            menuMaxHeight: 350,
                                                            items: [
                                                              ...dropDownListData.map<
                                                                  DropdownMenuItem<
                                                                      String>>((data) {
                                                                return DropdownMenuItem(
                                                                    child: Text(
                                                                        data[
                                                                            'title']),
                                                                    value: data[
                                                                        'value']);
                                                              }).toList(),
                                                            ],
                                                            onChanged: (value) {
                                                              print(
                                                                  "selected Value $value");

                                                              setStateSB(() {
                                                                edit_salary_status =
                                                                    value!;
                                                              });
                                                            }),
                                                      )

                                                      // CustomTextField()
                                                      ),
                                                ),

                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 04),
                                                  child: InputDecorator(
                                                      decoration:
                                                          InputDecoration(
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0)),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .all(10),
                                                      ),
                                                      child:
                                                          DropdownButtonHideUnderline(
                                                        child: DropdownButton<
                                                                String>(
                                                            isDense: true,
                                                            value: edit_shed_id,
                                                            isExpanded: true,
                                                            menuMaxHeight: 350,
                                                            hint: Text(
                                                                'Assign Shed'),
                                                            items: [
                                                              ...sheds.map<
                                                                  DropdownMenuItem<
                                                                      String>>((data) {
                                                                return DropdownMenuItem(
                                                                    child: Text(
                                                                        data[
                                                                            'name']),
                                                                    value: data[
                                                                            'id']
                                                                        .toString());
                                                              }).toList(),
                                                            ],
                                                            onChanged: (value) {
                                                              print(
                                                                  "selected Value $value");

                                                              setStateSB(() {
                                                                edit_shed_id =
                                                                    value!;
                                                              });
                                                            }),
                                                      )

                                                      // CustomTextField()
                                                      ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 80,
                                                      vertical: 08),
                                                  margin: EdgeInsets.all(04),
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        editData();
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          const Text("")),
                                                ),

                                                // SizedBox(height: MediaQuery.of(context).viewInsets.bottom+20,)
                                              ],
                                            ),
                                          );
                                        });
                                      },
                                    );
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.green[500],
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text(
                                            'Do you want to delete this?'),
                                        // content: const Text('AlertDialog description'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancel'),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              deleteData(i['id']);
                                              Navigator.pop(context, 'OK');
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red[300],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              )
          ],
        ));
  }
}
