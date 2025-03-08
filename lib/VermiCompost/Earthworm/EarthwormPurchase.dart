import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:tania_farm/components/CustomTextField.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class EarthwormPurchase extends StatefulWidget {
  const EarthwormPurchase({super.key});

  @override
  State<EarthwormPurchase> createState() => _EarthwormPurchaseState();
}

class _EarthwormPurchaseState extends State<EarthwormPurchase> {
  List<dynamic> seller_list = [];

  String? seller;




  TextEditingController kg = TextEditingController();
  TextEditingController rate = TextEditingController();

  DateTime selectedDate = DateTime.now();

  TextEditingController editid = TextEditingController();
  TextEditingController editkg = TextEditingController();
  TextEditingController editrate = TextEditingController();

  DateTime selectedEditDate = DateTime.now();

  String? editseller;


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



  void getSellerList() async {
    final url = Uri.parse('http://68.178.163.174:5010/vermi_compost/earthworm_seller');

    Response res = await get(url);

    setState(() {
      seller_list = jsonDecode(res.body);
    });
  }

  void getData() async{
    final url = Uri.parse('http://68.178.163.174:5010/vermi_compost/earthworm_purchase');

    Response res = await get(url);

    setState(() {
      data = jsonDecode(res.body);

    });

    FocusManager.instance.primaryFocus?.unfocus();
  }

  void addData() async {
    final url = Uri.parse('http://68.178.163.174:5010/vermi_compost/earthworm_purchase/add');

    Map<String, dynamic> data = { 'seller_id': seller, 'amount': kg.text, 'date': selectedDate.toIso8601String(), 'rate_per_kg': rate.text  };

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
        kg.text = '';
        seller = null;
        selectedDate = DateTime.now();
        rate.text = '';
        // seller = '';
      });
    }


    getData();
  }

  void editData() async {
    final url = Uri.parse('http://68.178.163.174:5010/vermi_compost/earthworm_purchase/edit?id=${editid.text}');

    Map<String, dynamic> data = { 'seller_id': editseller, 'amount': editkg.text, 'date': selectedEditDate.toIso8601String(), 'rate_per_kg': editrate.text };

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
    final url = Uri.parse('http://68.178.163.174:5010/vermi_compost/earthworm_purchase/delete?id=${id}');
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
    getSellerList();
    getData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: ' Purchase',), //Appbar
        body: ListView(children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Select Date: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                  Text("${selectedDate!.toLocal()}".split(' ')[0], style: TextStyle(fontSize: 20),),
                  GestureDetector(
                    onTap: () {
                      _selectDate(context);
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
              child: CustomTextField(controller: kg, hintText: "kg", obscureText: false, textinputtypephone: true)), //Custom TextFeild

          Container(
              margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
              child: CustomTextField(controller: rate, hintText: "Rate per kg", obscureText: false, textinputtypephone: false)),

          const SizedBox(
            height: 20,
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
                      value: seller,
                      isExpanded: true,
                      menuMaxHeight: 350,
                      hint: Text('Select Seller'),
                      items: [
                        ...seller_list.map<DropdownMenuItem<String>>((data) {
                          return DropdownMenuItem(
                              child: Text(data['name']), value: data['seller_id'].toString());
                        }).toList(),
                      ],

                      onChanged: (value) {
                        print("selected Value $value");

                        setState(() {
                          seller = value!;
                        });
                      }),


                )

              // CustomTextField()
            ),
          ),






          Container( padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(04),
            child: ElevatedButton(onPressed: (){
              addData();
            }, child: const Text("Submit")),
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
                                child: Text('Seller ID: ${i['seller_id']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                                child: Text('amount: ${i['amount']} kg', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                                child: Text('Rate Per KG: ${i['rate_per_kg']} kg', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                                child: Text('${DateTime.parse(i['date']).toLocal()}'.split(' ')[0], style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey),),
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
                                    editkg.text = i['amount'].toString();
                                    editseller = i['seller_id'].toString();
                                    selectedEditDate = DateTime.parse(i['date']);
                                    editrate.text = i['rate_per_kg'] != null ? i['rate_per_kg'] : '';
                                  });

                                  showModalBottomSheet<void>(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (BuildContext context) {

                                      return StatefulBuilder(
                                          builder: (context, setStateSB) {
                                            return FractionallySizedBox(
                                              heightFactor: 0.7,
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
                                                          Text("${selectedEditDate!.toLocal()}".split(' ')[0], style: TextStyle(fontSize: 20),),
                                                          GestureDetector(
                                                            onTap: () {
                                                              _selectEditDate(context, setStateSB);
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
                                                      child: CustomTextField(controller: editkg, hintText: "Kg", obscureText: false, textinputtypephone: false)), //Custom TextFeild

                                                  Container(
                                                      margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
                                                      child: CustomTextField(controller: editrate, hintText: "Rate per kg", obscureText: false, textinputtypephone: false)),


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
                                                              value: editseller,
                                                              isExpanded: true,
                                                              menuMaxHeight: 350,
                                                              hint: Text('Select Seller'),
                                                              items: [
                                                                ...seller_list.map<DropdownMenuItem<String>>((data) {
                                                                  return DropdownMenuItem(
                                                                      child: Text(data['name']), value: data['seller_id'].toString());
                                                                }).toList(),
                                                              ],

                                                              onChanged: (value) {
                                                                print("selected Value $value");

                                                                setStateSB(() {
                                                                  editseller = value;
                                                                });
                                                              }),


                                                        )

                                                      // CustomTextField()
                                                    ),
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
        ],)
    );
  }
}
