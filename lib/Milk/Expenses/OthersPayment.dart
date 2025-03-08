import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:tania_farm/components/CustomDatePicker.dart';
import 'package:tania_farm/components/CustomTextField.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class DairyOthersPayment extends StatefulWidget {
  const DairyOthersPayment({super.key});

  @override
  State<DairyOthersPayment> createState() => _DairyOthersPaymentState();
}

class _DairyOthersPaymentState extends State<DairyOthersPayment> {
  String? shed_id;

  String? seat_id;

  String? others_id;

  TextEditingController payment = TextEditingController();

  String? edit_shed_id;

  String? edit_seat_id;

  String? edit_others_id;

  TextEditingController editid = TextEditingController();

  TextEditingController editpayment = TextEditingController();

  List<dynamic> data = [];

  List<dynamic> sheds = [];

  List<dynamic> seats = [];

  List<dynamic> others = [];

  var date = DateTime.now();

  var editDate = DateTime.now();

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

  void getSheds() async {
    final url = Uri.parse('http://68.178.163.174:5010/breeding/sheds');

    Response res = await get(url);

    setState(() {
      sheds = jsonDecode(res.body);
    });
  }

  void getSeats(id) async {
    final url = Uri.parse('http://68.178.163.174:5010/breeding/seats?shed_id=${id}');

    Response res = await get(url);

    setState(() {
      seats = jsonDecode(res.body);
    });
  }

  void getOthers() async {
    final url = Uri.parse('http://68.178.163.174:5010/dairy/expenses/other');

    Response res = await get(url);

    setState(() {
      others = jsonDecode(res.body);
    });
  }

  void getData() async {
    final url = Uri.parse('http://68.178.163.174:5010/dairy/expenses/other_payment');

    Response res = await get(url);

    setState(() {
      data = jsonDecode(res.body);
    });
  }

  void addData() async {
    final url = Uri.parse('http://68.178.163.174:5010/dairy/expenses/other_payment/add');

    Map<String, dynamic> data = { 'shed_id': shed_id, 'seat_id': seat_id, 'others_id': others_id, 'payment': payment.text, 'date': date.toIso8601String()};

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
        shed_id = null;
        seat_id = null;
        others_id = null;
        payment.text = '';
      });
    }
    getData();
  }

  void editData() async {
    final url = Uri.parse('http://68.178.163.174:5010/dairy/expenses/other_payment/edit?id=${editid.text}');
    Map<String, dynamic> data = { 'shed_id': edit_shed_id, 'seat_id': edit_seat_id, 'others_id': edit_others_id, 'payment': editpayment.text, 'date': editDate.toIso8601String()};

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
    final url = Uri.parse('http://68.178.163.174:5010/dairy/expenses/other_payment/delete?id=${id}');

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
    getOthers();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Dairy Others Payment',),
      body: ListView(
        children: [
          CustomDatePicker(date: date, selectDate: () {
            selectDate(context, setState, date, (value) {
              setState(() {
                date = value;
              });
            });
          }, title: 'Select Date: '),




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
                      value: others_id,
                      isExpanded: true,
                      menuMaxHeight: 350,
                      hint: Text('Select'),
                      items: [
                        ...others.map<DropdownMenuItem<String>>((data) {
                          return DropdownMenuItem(
                              child: Text(data['name']), value: data['id'].toString());
                        }).toList(),
                      ],

                      onChanged: (value) {
                        print("selected Value $value");
                        setState(() {
                          others_id = value!;
                        });
                      }),


                )

              // CustomTextField()
            ),
          ),

          Container(
              margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
              child: CustomTextField(controller: payment, hintText: "Payment", obscureText: false, textinputtypephone: true)),

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
                                child: Text('Others ID: ${i['others_id']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              ),


                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 2),
                                child: Text('Payment: ${i['payment']} BDT', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),),
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                                child: Text('Date: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(i['date']))}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey),),
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
                                    edit_others_id = i['others_id'].toString();
                                    editpayment.text = i['payment'];
                                    editDate = DateTime.parse('${i['date']}');

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
                                                  CustomDatePicker(date: editDate, selectDate: () {
                                                    selectDate(context, setStateSB, editDate, (value) {
                                                      setState(() {
                                                        editDate = value;
                                                      });
                                                    });
                                                  }, title: 'Select Date: '),


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
                                                              value: edit_others_id,
                                                              isExpanded: true,
                                                              menuMaxHeight: 350,
                                                              hint: Text('Select'),
                                                              items: [
                                                                ...others.map<DropdownMenuItem<String>>((data) {
                                                                  return DropdownMenuItem(
                                                                      child: Text(data['name']), value: data['id'].toString());
                                                                }).toList(),
                                                              ],

                                                              onChanged: (value) {
                                                                print("selected Value $value");
                                                                setStateSB(() {
                                                                  edit_others_id = value!;
                                                                });
                                                              }),


                                                        )

                                                      // CustomTextField()
                                                    ),
                                                  ),



                                                  Container(
                                                      margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
                                                      child: CustomTextField(controller: editpayment, hintText: "Payment", obscureText: false, textinputtypephone: true)),





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
    );
  }
}
