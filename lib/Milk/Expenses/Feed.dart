import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:tania_farm/components/CustomDatePicker.dart';
import 'package:tania_farm/components/CustomTextField.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class DairyFeed extends StatefulWidget {
  const DairyFeed({super.key});

  @override
  State<DairyFeed> createState() => _DairyFeedState();
}

class _DairyFeedState extends State<DairyFeed> {
  String? shed_id;

  String? seat_id;

  String? cow_id;

  TextEditingController amount = TextEditingController();

  TextEditingController price = TextEditingController();

  String? edit_shed_id;

  String? edit_seat_id;

  String? edit_cow_id;

  TextEditingController edit_amount = TextEditingController();

  TextEditingController edit_price = TextEditingController();

  TextEditingController editid = TextEditingController();

  var date = DateTime.now();

  var editDate = DateTime.now();

  List<dynamic> data = [];

  List<dynamic> sheds = [];

  List<dynamic> seats = [];

  List<dynamic> cows = [];

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

  void getCows(shed_id, seat_id) async {
    final url = Uri.parse('http://68.178.163.174:5010/dairy/dairy_cows?shed_id=${shed_id}&seat_id=${seat_id}');

    Response res = await get(url);

    setState(() {
      cows = jsonDecode(res.body);
    });
  }

  void getData() async {
    final url = Uri.parse('http://68.178.163.174:5010/dairy/expenses/feed');

    Response res = await get(url);

    setState(() {
      data = jsonDecode(res.body);
    });
  }

  void addData() async {
    final url = Uri.parse('http://68.178.163.174:5010/dairy/expenses/feed/add');

    Map<String, dynamic> data = { 'shed_id': shed_id, 'seat_id': seat_id, 'cow_id': cow_id, 'amount': amount.text, 'price': price.text, 'date': date.toIso8601String()};

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
        cow_id = null;
        amount.text = '';
        price.text = '';
      });
    }
    getData();
  }

  void editData() async {
    final url = Uri.parse('http://68.178.163.174:5010/dairy/expenses/feed/edit?id=${editid.text}');
    Map<String, dynamic> data = { 'shed_id': edit_shed_id, 'seat_id': edit_seat_id, 'cow_id': edit_cow_id, 'amount': edit_amount.text, 'price': edit_price.text, 'date': editDate.toIso8601String()};

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
    final url = Uri.parse('http://68.178.163.174:5010/dairy/expenses/feed/delete?id=${id}');

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
    getSheds();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Feed',),
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
                        getSeats(value);
                        setState(() {
                          shed_id = value!;
                        });
                      }),

                )

              // CustomTextField()
            ),
          ),

          SizedBox(height: 04,),

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
                      value: seat_id,
                      isExpanded: true,
                      menuMaxHeight: 350,
                      hint: Text('Select Seat ID'),
                      items: [
                        ...seats.map<DropdownMenuItem<String>>((data) {
                          return DropdownMenuItem(
                              child: Text(data['name']), value: data['id'].toString());
                        }).toList(),
                      ],

                      onChanged: (value) {
                        print("selected Value $value");
                        getCows(shed_id, value);
                        setState(() {
                          seat_id = value!;
                        });
                      }),

                )

              // CustomTextField()
            ),
          ),

          SizedBox(height: 04,),

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
                      value: cow_id,
                      isExpanded: true,
                      menuMaxHeight: 350,
                      hint: Text('Select Cow ID'),
                      items: [
                        ...cows.map<DropdownMenuItem<String>>((data) {
                          return DropdownMenuItem(
                              child: Text(data['cow_id'].toString()), value: data['id'].toString());
                        }).toList(),
                      ],

                      onChanged: (value) {
                        print("selected Value $value");

                        setState(() {
                          cow_id = value!;
                        });
                      }),


                )

              // CustomTextField()
            ),
          ),

          Container(
              margin: EdgeInsets.fromLTRB(2, 14, 2, 0),
              child: CustomTextField(controller: amount, hintText: "Amount KG", obscureText: false, textinputtypephone: true)),

          Container(
              margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
              child: CustomTextField(controller: price, hintText: "Amount BDT", obscureText: false, textinputtypephone: true)),

          Container( padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(04),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent[400],
                  foregroundColor: Colors.black,
                ),
                onPressed: (){
              addData();
            }, child: const Text("Submit", style: TextStyle(fontSize: 16),)),
          ),

          SizedBox(height: 18,),

          for(var i in data)
            Column(
              children: [
                Container(
                  height: 180,
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
                                child: Text('Cow ID: ${i['cow_id']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 2),
                                child: Text('Shed ID: ${i['shed_id']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 2),
                                child: Text('Seat ID: ${i['seat_id']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 2),
                                child: Text('Amount: ${i['amount']} kg', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey),),
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                                child: Text('Price: ${i['price']} kg', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey),),
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
                                    edit_shed_id = i['shed_id'].toString();
                                    edit_seat_id = i['seat_id'].toString();
                                    edit_cow_id = i['cow_id'].toString();
                                    edit_amount.text = i['amount'].toString();
                                    edit_price.text = i['price'].toString();
                                    editDate = DateTime.parse('${i['date']}');

                                  });

                                  getSeats(i['shed_id']);
                                  getCows(i['shed_id'], i['seat_id']);

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
                                                                getSeats(value);
                                                                setStateSB(() {
                                                                  edit_shed_id = value!;
                                                                });
                                                              }),

                                                        )

                                                      // CustomTextField()
                                                    ),
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
                                                              value: edit_seat_id,
                                                              isExpanded: true,
                                                              menuMaxHeight: 350,
                                                              hint: Text('Select Seat ID'),
                                                              items: [
                                                                ...seats.map<DropdownMenuItem<String>>((data) {
                                                                  return DropdownMenuItem(
                                                                      child: Text(data['name']), value: data['id'].toString());
                                                                }).toList(),
                                                              ],

                                                              onChanged: (value) {
                                                                print("selected Value $value");
                                                                getCows(edit_shed_id, value);
                                                                setStateSB(() {
                                                                  edit_seat_id = value!;
                                                                });
                                                              }),


                                                        )

                                                      // CustomTextField()
                                                    ),
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
                                                              value: edit_cow_id,
                                                              isExpanded: true,
                                                              menuMaxHeight: 350,
                                                              hint: Text('Select Cow ID'),
                                                              items: [
                                                                ...cows.map<DropdownMenuItem<String>>((data) {
                                                                  return DropdownMenuItem(
                                                                      child: Text(data['cow_id'].toString()), value: data['id'].toString());
                                                                }).toList(),
                                                              ],

                                                              onChanged: (value) {
                                                                print("selected Value $value");

                                                                setState(() {
                                                                  edit_cow_id = value!;
                                                                });
                                                              }),


                                                        )

                                                      // CustomTextField()
                                                    ),
                                                  ),

                                                  Container(
                                                      margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
                                                      child: CustomTextField(controller: edit_amount, hintText: "Amount", obscureText: false, textinputtypephone: true)),



                                                  Container(
                                                      margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
                                                      child: CustomTextField(controller: edit_price, hintText: "Price", obscureText: false, textinputtypephone: true)),


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
