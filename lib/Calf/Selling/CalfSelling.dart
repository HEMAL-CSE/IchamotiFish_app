import 'dart:convert';

import 'package:tania_farm/components/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class CalfSelling extends StatefulWidget {
  const CalfSelling({super.key});

  @override
  State<CalfSelling> createState() => _CalfSellingState();
}

class _CalfSellingState extends State<CalfSelling> {
  String? shed_id;

  String? seat_id;

  String? calf_id;

  DateTime selling_date = DateTime.now();


  TextEditingController calf_price = TextEditingController();


  String? edit_shed_id;

  String? edit_seat_id;

  String? edit_calf_id;

  DateTime edit_selling_date = DateTime.now();


  TextEditingController edit_calf_price = TextEditingController();


  TextEditingController editid = TextEditingController();

  List<dynamic> data = [];

  List<dynamic> sheds = [];

  List<dynamic> seats = [];

  List<dynamic> calfs = [];

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

  void getCalfs(shed_id, seat_id) async {
    final url = Uri.parse('http://68.178.163.174:5010/calf?shed_id=${shed_id}&&seat_id=${seat_id}');

    Response res = await get(url);

    setState(() {
      calfs = jsonDecode(res.body);
    });
  }

  void getData() async {
    final url = Uri.parse('http://68.178.163.174:5010/calf/?sold=1');

    Response res = await get(url);

    setState(() {
      seats = jsonDecode(res.body);
    });
  }

  void addData() async {
    final url = Uri.parse('http://68.178.163.174:5010/calf/selling?shed_id=${shed_id}&seat_id=${seat_id}&calf_id=${calf_id}');
    Map body = {
      'selling_date': selling_date.toIso8601String(),
      'selling_price': calf_price.text
    };

    Response res = await put(url,body: body);

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

  void editData() async {
    final url = Uri.parse('http://68.178.163.174:5010/calf/selling?shed_id=${edit_shed_id}&seat_id=${edit_seat_id}&calf_id=${edit_calf_id}');
    Map body = {
      'selling_date': edit_selling_date.toIso8601String(),
      'selling_price': edit_calf_price.text
    };

    Response res = await put(url,body: body);

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSheds();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'বিক্রয়',),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('বিক্রয় তারিখ: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                    Text("${selling_date!.toLocal()}".split(' ')[0], style: TextStyle(fontSize: 20),),
                    GestureDetector(
                      onTap: () {
                        _selectDate(context, setState, selling_date, (value) { selling_date = value; });
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

            Container( padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                        hint: Text('শেড নাম্বার বাছাই করুন'),
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

            Container( padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                        hint: Text('সিট নাম্বার বাছাই করুন'),
                        items: [
                          ...seats.map<DropdownMenuItem<String>>((data) {
                            return DropdownMenuItem(
                                child: Text(data['name']), value: data['id'].toString());
                          }).toList(),
                        ],

                        onChanged: (value) {
                          // getCows(shed_id, value);
                          getCalfs(shed_id, value);
                          print("selected Value $value");

                          setState(() {
                            seat_id = value!;
                          });
                        }),


                  )

                // CustomTextField()
              ),
            ),

            Container( padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                        value: calf_id,
                        isExpanded: true,
                        menuMaxHeight: 350,
                        hint: Text('বাছুর নাম্বার বাছাই করুন'),
                        items: [
                          ...calfs.map<DropdownMenuItem<String>>((data) {
                            return DropdownMenuItem(
                                child: Text(data['cow_id'].toString()), value: data['cow_id'].toString());
                          }).toList(),
                        ],

                        onChanged: (value) {
                          print("selected Value $value");

                          setState(() {
                            calf_id = value!;
                          });
                        }),
                  )

                // CustomTextField()
              ),
            ),

            Container(
                margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
                child: CustomTextField(controller: calf_price, hintText: "বাছুর বিক্রয় মূল্য", obscureText: false, textinputtypephone: true)),

            SizedBox(height: 04,),
            Container( padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(04),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent[400],
                    foregroundColor: Colors.black,
                  ),
                  onPressed: (){
                addData();
              }, child: const Text("জমা দিন", style: TextStyle(fontSize: 14.8),)),
            ),

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
                                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                                child: Text('বাছুর নাম্বার: ${i['calf_id']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                                child: Text('শেড নাম্বার: ${i['shed_id']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                                child: Text('বিক্রয় মূল্য: ${i['selling_price']} tk', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),),
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
                                  // setState(() {
                                  //   editid.text = i['id'].toString();
                                  //   edit_shed_id = i['shed_id'].toString();
                                  //   edit_seat_id = i['seat_id'].toString();
                                  //   edit_cow_id = i['cow_id'].toString();
                                  //   edit_selling_date = DateTime.parse(i['selling_date']);
                                  //   edit_calf_price.text = i['calf_selling_price'];
                                  //   edit_cow_price.text = i['cow_selling_price'];
                                  // });
                                  // seats.clear();
                                  // cows.clear();
                                  //
                                  // getSeats(i['shed_id']);
                                  // getCows(i['shed_id'], i['seat_id']);

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
                                                                // getCows(edit_shed_id, value);
                                                                setStateSB(() {
                                                                  edit_seat_id = value!;
                                                                });
                                                              }),


                                                        )

                                                      // CustomTextField()
                                                    ),
                                                  ),

                                                  Container( padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                                                              value: edit_calf_id,
                                                              isExpanded: true,
                                                              menuMaxHeight: 350,
                                                              hint: Text('Select Cow ID'),
                                                              items: [
                                                                ...calfs.map<DropdownMenuItem<String>>((data) {
                                                                  return DropdownMenuItem(
                                                                      child: Text(data['id'].toString()), value: data['id'].toString());
                                                                }).toList(),
                                                              ],

                                                              onChanged: (value) {
                                                                print("selected Value $value");

                                                                setState(() {
                                                                  edit_calf_id = value!;
                                                                });
                                                              }),
                                                        )

                                                      // CustomTextField()
                                                    ),
                                                  ),

                                                  Container(
                                                      margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
                                                      child: CustomTextField(controller: edit_calf_price, hintText: "Enter Calf Price", obscureText: false, textinputtypephone: true)),




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
                              // GestureDetector(
                              //   onTap: () {
                              //     showDialog<String>(
                              //       context: context,
                              //       builder: (BuildContext context) => AlertDialog(
                              //         title: const Text('Do you want to delete this?'),
                              //         // content: const Text('AlertDialog description'),
                              //         actions: <Widget>[
                              //
                              //           TextButton(
                              //             onPressed: () => Navigator.pop(context, 'Cancel'),
                              //             child: const Text('Cancel'),
                              //           ),
                              //           TextButton(
                              //             onPressed: ()
                              //             {
                              //               deleteData(i['id']);
                              //               Navigator.pop(context, 'OK');
                              //             },
                              //             child: const Text('OK'),
                              //           ),
                              //         ],
                              //       ),
                              //     );
                              //   },
                              //   child: Icon(Icons.delete, color: Colors.red[300],),
                              // )
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
