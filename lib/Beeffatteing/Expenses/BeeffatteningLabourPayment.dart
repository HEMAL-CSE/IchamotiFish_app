import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:tania_farm/components/CustomTextField.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class BeefFatteningLabourPayment extends StatefulWidget {
  const BeefFatteningLabourPayment({super.key});

  @override
  State<BeefFatteningLabourPayment> createState() => _BeefFatteningLabourPaymentState();
}

class _BeefFatteningLabourPaymentState extends State<BeefFatteningLabourPayment> {
  String? shed_id;

  DateTime selectDate = DateTime.now();

  DateTime selectEditDate = DateTime.now();

  String? seat_id;

  String? labour_id;

  TextEditingController payment = TextEditingController();

  String? edit_shed_id;

  String? edit_seat_id;

  String? edit_labour_id;

  TextEditingController editid = TextEditingController();

  TextEditingController editpayment = TextEditingController();

  List<dynamic> data = [];

  List<dynamic> sheds = [];

  List<dynamic> seats = [];

  List<dynamic> labours = [];

  void getSheds() async {
    final url = Uri.parse('http://68.178.163.174:5010/breeding/sheds');

    Response res = await get(url);

    setState(() {
      sheds = jsonDecode(res.body);
    });
  }

  // void getSeats(id) async {
  //   final url = Uri.parse('http://68.178.163.174:5010/breeding/seats?shed_id=${id}');
  //
  //   Response res = await get(url);
  //
  //   setState(() {
  //     seats = jsonDecode(res.body);
  //   });
  // }

  void getLabours(shed_id) async {
    final url = Uri.parse('http://68.178.163.174:5010/cattles/beef_labour?shed_id=${shed_id}');

    Response res = await get(url);

    setState(() {
      labours = jsonDecode(res.body);
    });
  }

  void getData() async {
    final url = Uri.parse('http://68.178.163.174:5010/cattles/beef_labour_payment');

    Response res = await get(url);

    setState(() {
      data = jsonDecode(res.body);
    });
  }

  void addData() async {
    final url = Uri.parse('http://68.178.163.174:5010/cattles/beef_labour_payment/add');

    Map<String, dynamic> data = { 'shed_id': shed_id, 'labour_id': labour_id, 'payment': payment.text, 'date': selectDate.toIso8601String()};

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
        selectDate = DateTime.now();
        shed_id = null;
        labour_id = null;
        payment.text = '';
      });
    }
    getData();
  }

  void editData() async {
    final url = Uri.parse('http://68.178.163.174:5010/cattles/beef_labour_payment/edit?id=${editid.text}');
    Map<String, dynamic> data = { 'shed_id': edit_shed_id,  'labour_id': edit_labour_id, 'payment': editpayment.text, 'date': selectEditDate.toIso8601String()};

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
    final url = Uri.parse('http://68.178.163.174:5010/cattles/beef_labour_payment/delete?id=${id}');

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



  @override void initState() {
    // TODO: implement initState
    super.initState();
    getSheds();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Beef Labour Payment',),
      body: ListView(
        children: [

          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Select Date: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                  Text("${selectDate!.toLocal()}".split(' ')[0], style: TextStyle(fontSize: 20),),
                  GestureDetector(
                    onTap: () {
                      _selectDate(context, setState, selectDate, (value) {selectDate = value;});
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
                      value: shed_id,
                      isExpanded: true,
                      menuMaxHeight: 350,
                      hint: Text('Select Shed ID'),
                      items: [
                        ...sheds.map<DropdownMenuItem<String>>((data) {
                          return DropdownMenuItem(
                              child: Text(data['name']), value: data['id'].toString());
                        }).toList(),
                      ],

                      onChanged: (value) {
                        print("selected Value $value");
                        // getSeats(value);
                        getLabours(value);
                        setState(() {
                          shed_id = value!;
                        });
                      }),

                )

              // CustomTextField()
            ),
          ),

          // Container( padding: EdgeInsets.symmetric(horizontal: 12, vertical: 04),
          //   child: InputDecorator(
          //       decoration: InputDecoration(
          //         border:
          //         OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(15.0)),
          //         contentPadding: const EdgeInsets.all(10),
          //       ),
          //       child: DropdownButtonHideUnderline(
          //         child: DropdownButton<String>(
          //             isDense: true,
          //             value: seat_id,
          //             isExpanded: true,
          //             menuMaxHeight: 350,
          //             hint: Text('Select Seat ID'),
          //             items: [
          //               ...seats.map<DropdownMenuItem<String>>((data) {
          //                 return DropdownMenuItem(
          //                     child: Text(data['name']), value: data['id'].toString());
          //               }).toList(),
          //             ],
          //
          //             onChanged: (value) {
          //               print("selected Value $value");
          //               getLabours(shed_id, value);
          //               setState(() {
          //                 seat_id = value!;
          //               });
          //             }),
          //
          //
          //       )
          //
          //     // CustomTextField()
          //   ),
          // ),



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
                      value: labour_id,
                      isExpanded: true,
                      menuMaxHeight: 350,
                      hint: Text('Select Labour'),
                      items: [
                        ...labours.map<DropdownMenuItem<String>>((data) {
                          return DropdownMenuItem(
                              child: Text(data['name']), value: data['id'].toString());
                        }).toList(),
                      ],

                      onChanged: (value) {
                        print("selected Value $value");
                        setState(() {
                          labour_id = value!;
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
                                child: Text('Labour ID: ${i['labour_id']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 2),
                                child: Text('Shed ID: ${i['shed_id']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),),
                              ),
                              // Padding(
                              //   padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 2),
                              //   child: Text('Seat ID: ${i['seat_id']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),),
                              // ),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 2),
                                child: Text('Payment: ${i['payment']} BDT', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),),
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
                                    edit_shed_id = i['shed_id'].toString();
                                    // edit_seat_id = i['seat_id'].toString();
                                    edit_labour_id = i['labour_id'].toString();
                                    editpayment.text = i['payment'];
                                    selectEditDate = DateTime.parse(i['date']);

                                  });

                                  // getSeats(i['shed_id']);
                                  getLabours(i['shed_id']);
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
                                                  Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Text('Select Date: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                                                          Text("${selectEditDate!.toLocal()}".split(' ')[0], style: TextStyle(fontSize: 20),),
                                                          GestureDetector(
                                                            onTap: () {
                                                              _selectDate(context, setStateSB, selectEditDate, (value) {selectEditDate = value;});
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
                                                              value: edit_shed_id,
                                                              isExpanded: true,
                                                              menuMaxHeight: 350,
                                                              hint: Text('Select Shed ID'),
                                                              items: [
                                                                ...sheds.map<DropdownMenuItem<String>>((data) {
                                                                  return DropdownMenuItem(
                                                                      child: Text(data['name']), value: data['id'].toString());
                                                                }).toList(),
                                                              ],

                                                              onChanged: (value) {
                                                                print("selected Value $value");
                                                                // getSeats(value);
                                                                getLabours(value);
                                                                setStateSB(() {
                                                                  edit_shed_id = value!;
                                                                });
                                                              }),


                                                        )

                                                      // CustomTextField()
                                                    ),
                                                  ),

                                                  // Container( padding: EdgeInsets.symmetric(horizontal: 12, vertical: 04),
                                                  //   child: InputDecorator(
                                                  //       decoration: InputDecoration(
                                                  //         border:
                                                  //         OutlineInputBorder(
                                                  //             borderRadius: BorderRadius.circular(15.0)),
                                                  //         contentPadding: const EdgeInsets.all(10),
                                                  //       ),
                                                  //       child: DropdownButtonHideUnderline(
                                                  //         child: DropdownButton<String>(
                                                  //             isDense: true,
                                                  //             value: edit_seat_id,
                                                  //             isExpanded: true,
                                                  //             menuMaxHeight: 350,
                                                  //             hint: Text('Select Seat ID'),
                                                  //             items: [
                                                  //               ...seats.map<DropdownMenuItem<String>>((data) {
                                                  //                 return DropdownMenuItem(
                                                  //                     child: Text(data['name']), value: data['id'].toString());
                                                  //               }).toList(),
                                                  //             ],
                                                  //
                                                  //             onChanged: (value) {
                                                  //               print("selected Value $value");
                                                  //               getLabours(edit_shed_i);
                                                  //               setStateSB(() {
                                                  //                 edit_seat_id = value!;
                                                  //               });
                                                  //             }),
                                                  //
                                                  //
                                                  //       )
                                                  //
                                                  //     // CustomTextField()
                                                  //   ),
                                                  // ),

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
                                                              value: edit_labour_id,
                                                              isExpanded: true,
                                                              menuMaxHeight: 350,
                                                              hint: Text('Select Labour'),
                                                              items: [
                                                                ...labours.map<DropdownMenuItem<String>>((data) {
                                                                  return DropdownMenuItem(
                                                                      child: Text(data['name']), value: data['id'].toString());
                                                                }).toList(),
                                                              ],

                                                              onChanged: (value) {
                                                                print("selected Value $value");
                                                                setStateSB(() {
                                                                  edit_labour_id = value!;
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
