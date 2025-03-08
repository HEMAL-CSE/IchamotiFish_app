import 'dart:convert';

import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:tania_farm/components/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class CowPurchase extends StatefulWidget {
  const CowPurchase({super.key});

  @override
  State<CowPurchase> createState() => _CowPurchaseState();
}

class _CowPurchaseState extends State<CowPurchase> {

  List<dynamic> sheds = [];

  List<dynamic> seats = [];

  List<dynamic> pregnants = [
    {
      'name': 'হ্যাঁ',
      'value': '1'
    },
    {
      'name': 'না',
      'value': '0'
    },
  ];

  List<dynamic> data = [];

  String? pregnant;

  String? shed_id;

  String? seat_id;

  TextEditingController cow_id = TextEditingController();

  DateTime purchase_date = DateTime.now();

  TextEditingController price = TextEditingController();


  TextEditingController weight = TextEditingController();

  TextEditingController pregnant_month = TextEditingController();

  DateTime supposed_delivery_date = DateTime.now();

  TextEditingController editid = TextEditingController();

  String? edit_pregnant;

  String? edit_shed_id;

  String? edit_seat_id;

  TextEditingController edit_cow_id = TextEditingController();

  DateTime edit_purchase_date = DateTime.now();

  TextEditingController edit_price = TextEditingController();


  TextEditingController edit_weight = TextEditingController();

  TextEditingController edit_pregnant_month = TextEditingController();

  DateTime edit_supposed_delivery_date = DateTime.now();

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

  void getData() async {
    final url = Uri.parse('http://68.178.163.174:5010/breeding/cows');

    Response res = await get(url);


    setState(() {
      data = jsonDecode(res.body);
    });
  }

  void addData() async {
    final url = Uri.parse('http://68.178.163.174:5010/breeding/cow_purchase');

    Map<String, dynamic> data = { 'shed_id': shed_id, 'seat_id': seat_id, 'cow_id': cow_id.text, 'purchase_date': purchase_date.toIso8601String(), 'price': price.text, 'weight': weight.text, 'pregnant': pregnant, 'pregnant_month': pregnant_month.text, 'supposed_delivery_date': supposed_delivery_date.toIso8601String() };

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
        cow_id.text = '';
        purchase_date = DateTime.now();
        weight.text = '';
        pregnant = null;
        pregnant_month.text = '';
        supposed_delivery_date = DateTime.now();
      });
    }
    getData();
  }

  void editData() async {
    final url = Uri.parse('http://68.178.163.174:5010/breeding/cow_purchase/edit?id=${editid.text}');
    Map<String, dynamic> data = { 'shed_id': edit_shed_id, 'seat_id': edit_seat_id, 'cow_id': edit_cow_id.text, 'purchase_date': edit_purchase_date.toIso8601String(), 'price': edit_price.text, 'weight': edit_weight.text, 'pregnant': edit_pregnant, 'pregnant_month': edit_pregnant_month.text, 'supposed_delivery_date': edit_supposed_delivery_date.toIso8601String() };

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
    final url = Uri.parse('http://68.178.163.174:5010/breeding/cow_purchase/delete?id=${id}');

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
      appBar: CustomAppBar(title: 'গাভী ক্রয়',),
      body: ListView(
        children: [
          SizedBox(height: 05,),
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
                      hint: Text('শেড নাম্বার সিলেক্ট করুন'),
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

          SizedBox(height: 03,),
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
                      hint: Text('সিট নাম্বার সিলেক্ট করুন'),
                      items: [
                        ...seats.map<DropdownMenuItem<String>>((data) {
                          return DropdownMenuItem(
                              child: Text(data['name']), value: data['id'].toString());
                        }).toList(),
                      ],

                      onChanged: (value) {
                        print("selected Value $value");

                        setState(() {
                          seat_id = value!;
                        });
                      }),


                )

              // CustomTextField()
            ),
          ),

          Container(
              margin: EdgeInsets.fromLTRB(2, 10, 2, 0),
              child: CustomTextField(controller: cow_id, hintText: "গাভী নাম্বার দিন", obscureText: false, textinputtypephone: true)),

          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('ক্রয়ের তারিখ সিলেক্ট করুন: ', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),),
                  Text("${purchase_date!.toLocal()}".split(' ')[0], style: TextStyle(fontSize: 20),),
                  GestureDetector(
                    onTap: () {
                      _selectDate(context,setState, purchase_date, (value) {purchase_date = value;});
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

          Container(
              margin: EdgeInsets.fromLTRB(2, 04, 2, 0),
              child: CustomTextField(controller: price, hintText: "ক্রয়কৃত গাভীর দাম", obscureText: false, textinputtypephone: true)),

          Container(
              margin: EdgeInsets.fromLTRB(2, 12, 2, 0),
              child: CustomTextField(controller: weight, hintText: "গাভীর ওজন (কেজি)", obscureText: false, textinputtypephone: true)),

          SizedBox(height: 09,),
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
                      value: pregnant,
                      isExpanded: true,
                      menuMaxHeight: 350,
                      hint: Text('গর্ভবতী স্টাটাস'),
                      items: [
                        ...pregnants.map<DropdownMenuItem<String>>((data) {
                          return DropdownMenuItem(
                              child: Text(data['name']), value: data['value'].toString());
                        }).toList(),
                      ],

                      onChanged: (value) {
                        print("selected Value $value");

                        setState(() {
                          pregnant = value!;
                        });
                      }),


                )

              // CustomTextField()
            ),
          ),

          if(pregnant == '1')
            Column(
              children: [
                Container(
                    margin: EdgeInsets.fromLTRB(2, 12, 2, 0),
                    child: CustomTextField(controller: pregnant_month, hintText: "গর্ভবতীর সময়কাল", obscureText: false, textinputtypephone: true)),

                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('আনুমানিক প্রসব তারিখ: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                        Text("${supposed_delivery_date!.toLocal()}".split(' ')[0], style: TextStyle(fontSize: 20),),
                        GestureDetector(
                          onTap: () {
                            _selectDate(context,setState, supposed_delivery_date, (value) {supposed_delivery_date = value;});
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
              ],
            ),
        SizedBox(height: 04,),
          Container( padding: EdgeInsets.symmetric(),
            margin: EdgeInsets.all(04),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent[400],
                  foregroundColor: Colors.black,
                ),
                onPressed: (){
              addData();
            }, child: const Text("জমা দিন", style: TextStyle(fontSize: 15.5),)),
          ),


          SizedBox(height: 20,),

          for(var i in data)
            Column(
              children: [
                Container(
                  height: 300,
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
                                child: Text('গাভী নাম্বার: ${i['cow_id']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                                child: Text('শেড নাম্বার: ${i['shed_id']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                                child: Text('ক্রয়ের তারিখ: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(i['purchase_date']))}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),),
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                                child: Text('ওজন: ${i['weight']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),),
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                                child: Text('গর্ভবতী: ${i['pregnant'] == 1 ? 'Yes' : 'No' }', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),),
                              ),
                              if(i['pregnant'] == 1)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                                      child: Text('গর্ভবতী সময়কাল: ${i['pregnant_month']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                                      child: Text('আনুমানিক প্রসব তারিখ: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(i['supposed_delivery_date']))}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),),
                                    ),
                                  ],
                                ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                                child: Text('ক্রয়কৃত দাম: ${i['purchase_price']} BDT', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, ),),
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
                                    edit_cow_id.text = i['cow_id'].toString();
                                    edit_purchase_date = DateTime.parse(i['purchase_date']);
                                    edit_price.text = i['purchase_price'];
                                    edit_weight.text = i['weight'].toString();
                                    edit_pregnant = i['pregnant'].toString();
                                    edit_pregnant_month.text = i['pregnant_month'];
                                    edit_supposed_delivery_date = DateTime.parse(i['supposed_delivery_date']);
                                  });

                                  getSeats(i['shed_id']);

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

                                                                setStateSB(() {
                                                                  edit_seat_id = value!;
                                                                });
                                                              }),


                                                        )

                                                      // CustomTextField()
                                                    ),
                                                  ),

                                                  Container(
                                                      margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
                                                      child: CustomTextField(controller: edit_cow_id, hintText: "Cow ID", obscureText: false, textinputtypephone: true)),

                                                  Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Text('Purchase Date: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                                                          Text("${edit_purchase_date!.toLocal()}".split(' ')[0], style: TextStyle(fontSize: 20),),
                                                          GestureDetector(
                                                            onTap: () {
                                                              _selectDate(context,setStateSB, edit_purchase_date, (value) {edit_purchase_date = value;});
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

                                                  Container(
                                                      margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
                                                      child: CustomTextField(controller: edit_price, hintText: "Purchase Price", obscureText: false, textinputtypephone: true)),

                                                  Container(
                                                      margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
                                                      child: CustomTextField(controller: edit_weight, hintText: "Weight KG", obscureText: false, textinputtypephone: true)),

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
                                                              value: edit_pregnant,
                                                              isExpanded: true,
                                                              menuMaxHeight: 350,
                                                              hint: Text('Pregnant'),
                                                              items: [
                                                                ...pregnants.map<DropdownMenuItem<String>>((data) {
                                                                  return DropdownMenuItem(
                                                                      child: Text(data['name']), value: data['value'].toString());
                                                                }).toList(),
                                                              ],

                                                              onChanged: (value) {
                                                                print("selected Value $value");

                                                                setStateSB(() {
                                                                  edit_pregnant = value!;
                                                                });
                                                              }),


                                                        )

                                                      // CustomTextField()
                                                    ),
                                                  ),

                                                  if(edit_pregnant == '1')
                                                    Column(
                                                      children: [
                                                        Container(
                                                            margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
                                                            child: CustomTextField(controller: edit_pregnant_month, hintText: "Pregnant Month", obscureText: false, textinputtypephone: true)),

                                                        Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                                                            child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Text('Supposed Delivery Date: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                                                                Text("${edit_supposed_delivery_date!.toLocal()}".split(' ')[0], style: TextStyle(fontSize: 20),),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    _selectDate(context,setStateSB, edit_supposed_delivery_date, (value) {edit_supposed_delivery_date = value;});
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
                                                      ],
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
        ],
      ),
    );
  }
}