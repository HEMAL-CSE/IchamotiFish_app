import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:tania_farm/components/CustomTextField.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class DairyPurchase extends StatefulWidget {
  const DairyPurchase({super.key});

  @override
  State<DairyPurchase> createState() => _DairyPurchaseState();
}

class _DairyPurchaseState extends State<DairyPurchase> {
  List<dynamic> sheds = [];

  List<dynamic> seats = [];

  List<dynamic> pregnants = [
    {
      'name': 'Yes',
      'value': '1'
    },
    {
      'name': 'No',
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
    final url = Uri.parse('http://68.178.163.174:5010/dairy/dairy_cows');

    Response res = await get(url);


    setState(() {
      data = jsonDecode(res.body);
    });
  }

  void addData() async {
    final url = Uri.parse('http://68.178.163.174:5010/dairy/dairy_cows/add');

    Map<String, dynamic> data = { 'shed_id': shed_id, 'seat_id': seat_id, 'cow_id': cow_id.text, 'purchase_date': purchase_date.toIso8601String(), 'purchase_price': price.text, 'weight': weight.text,  };

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
      });
    }
    getData();
  }

  void editData() async {
    final url = Uri.parse('http://68.178.163.174:5010/dairy/dairy_cows/edit?id=${editid.text}');
    Map<String, dynamic> data = { 'shed_id': edit_shed_id, 'seat_id': edit_seat_id, 'cow_id': edit_cow_id.text, 'purchase_date': edit_purchase_date.toIso8601String(), 'purchase_price': edit_price.text, 'weight': edit_weight.text, };

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
    final url = Uri.parse('http://68.178.163.174:5010/dairy/dairy_cows/delete?id=${id}');

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
      appBar: CustomAppBar(title: 'দুধ ক্রয়',),
      body: ListView(
        children: [
          SizedBox(height: 07,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 04),
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
          SizedBox(height: 02,),

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
              margin: EdgeInsets.fromLTRB(2, 12, 2, 0),
              child: CustomTextField(controller: cow_id, hintText: "গরু নাম্বার দিন", obscureText: false, textinputtypephone: true)),

          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(' ক্রয়ের তারিখ: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
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
              margin: EdgeInsets.fromLTRB(2, 12, 2, 0),
              child: CustomTextField(controller: price, hintText: "ক্রয়কৃত গরুর দাম", obscureText: false, textinputtypephone: true)),

          Container(
              margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
              child: CustomTextField(controller: weight, hintText: "ওজন (কেজি)", obscureText: false, textinputtypephone: true)),


          Container( padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(04),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent[400],
                foregroundColor: Colors.black,
              ),
                onPressed: (){
              addData();
            }, child: const Text("জমা দিন", style: TextStyle(fontSize: 16),)),
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
                                child: Text('গরু নাম্বার: ${i['cow_id']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
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
                                child: Text('ওজন (কেজি): ${i['weight']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),),
                              ),



                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                                child: Text('ক্রয়কৃত দাম: ${i['purchase_price']} টাকা', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, ),),
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
                                                              hint: Text('সিট নাম্বার সিলেক্ট করুন'),
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



                                                  Container( padding: EdgeInsets.symmetric(horizontal: 80, vertical: 08),
                                                    margin: EdgeInsets.all(04),
                                                    child: ElevatedButton(onPressed: (){
                                                      editData();
                                                      Navigator.pop(context);
                                                    }, child: const Text("জমা দিন")),
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
