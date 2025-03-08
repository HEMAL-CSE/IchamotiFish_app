import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:tania_farm/components/CustomTextField.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class BeefSlaughtering extends StatefulWidget {
  const BeefSlaughtering({super.key});

  @override
  State<BeefSlaughtering> createState() => _BeefSlaughteringState();
}

class _BeefSlaughteringState extends State<BeefSlaughtering> {

  String? shed_id;
  String? seat_id;

  String? cattle_id;

  DateTime slaughtering_date = DateTime.now();

  List<dynamic> sheds = [];

  List<dynamic> seats = [];

  List<dynamic> cattles = [];

  List<dynamic> data = [];

  TextEditingController cattle_body_weight = TextEditingController();
  TextEditingController beef_weight = TextEditingController();
  TextEditingController per_kg_cost = TextEditingController();
  TextEditingController others_income = TextEditingController();
  TextEditingController expenses = TextEditingController();

  DateTime edit_slaughtering_date = DateTime.now();


  String? edit_shed_id;
  String? edit_seat_id;

  String? edit_cattle_id;

  TextEditingController edit_cattle_body_weight = TextEditingController();
  TextEditingController edit_beef_weight = TextEditingController();
  TextEditingController edit_per_kg_cost = TextEditingController();
  TextEditingController edit_others_income = TextEditingController();
  TextEditingController edit_expenses = TextEditingController();
  TextEditingController editid = TextEditingController();
  // TextEditingController net_profit = TextEditingController();
  // TextEditingController total_cost = TextEditingController();




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

  void getCattles(shed_id, seat_id) async {
    final url = Uri.parse('http://68.178.163.174:5010/cattles?shed_id=${shed_id}&seat_id=${seat_id}');

    Response res = await get(url);

    setState(() {
      cattles = jsonDecode(res.body);
    });
  }

  void getData() async {
    final url = Uri.parse('http://68.178.163.174:5010/cattles/slaughter_info?slaughtered=1');
 
    Response res = await get(url);
    print(jsonDecode(res.body));

    setState(() {
      data = jsonDecode(res.body);
    });

  }

  void addData() async {
    final url = Uri.parse('http://68.178.163.174:5010/cattles/slaughter/add?id=${cattle_id}');

    Map<String, dynamic> data = {'slaughtering_date': slaughtering_date.toIso8601String(), 'weight': cattle_body_weight.text, 'per_kg_cost': per_kg_cost.text, 'others_income': others_income.text, 'expenses': expenses.text};



    Response res = await put(url, body: data);

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
        cattle_id = null;
        slaughtering_date = DateTime.now();
        cattle_body_weight.text = '';
        per_kg_cost.text = '';
        others_income.text = '';
        expenses.text = '';
      });
    }

    getData();
  }

  void editData() async {
    final url = Uri.parse('http://68.178.163.174:5010/cattles/slaughter/add?id=${editid.text}');
    Map<String, dynamic> data = {'slaughtering_date': edit_slaughtering_date.toIso8601String(), 'weight': edit_cattle_body_weight.text, 'per_kg_cost': edit_per_kg_cost.text, 'others_income': edit_others_income.text, 'expenses': edit_expenses.text};

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
    final url = Uri.parse('http://68.178.163.174:5010/cattles/delete?id=${id}');

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
      appBar: CustomAppBar(title: 'Beef Slaughtering',),
      body: ListView(children: [

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
                      getCattles(shed_id, value);
                      setState(() {
                        seat_id = value!;
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
                    value: cattle_id,
                    isExpanded: true,
                    menuMaxHeight: 350,
                    hint: Text('Select Cattle ID'),
                    items: [
                      ...cattles.map<DropdownMenuItem<String>>((data) {
                        return DropdownMenuItem(
                            child: Text(data['cattle_id'].toString()), value: data['id'].toString());
                      }).toList(),
                    ],

                    onChanged: (value) {
                      print("selected Value $value");

                      setState(() {
                        cattle_id = value!;
                      });
                    }),


              )

            // CustomTextField()
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Slaughtering Date: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                Text("${slaughtering_date!.toLocal()}".split(' ')[0], style: TextStyle(fontSize: 20),),
                GestureDetector(
                  onTap: () {
                    _selectDate(context, setState, slaughtering_date, (value) { slaughtering_date = value; });
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
            margin: EdgeInsets.fromLTRB(2, 10, 2, 0),
            child: CustomTextField(controller: cattle_body_weight, hintText: "Cattle Body Weight", obscureText: false, textinputtypephone: true)),

        // Container(
        //     margin: EdgeInsets.fromLTRB(2, 13, 2, 0),
        //     child: CustomTextField(controller: purchase_cost, hintText: "Purchase Cost", obscureText: false, textinputtypephone: true)),

        // Container(
        //     margin: EdgeInsets.fromLTRB(2, 13, 2, 0),
        //     child: CustomTextField(controller: cattle_body_weight, hintText: "Body Weight KG ", obscureText: false, textinputtypephone: true)),

        Container(
            margin: EdgeInsets.fromLTRB(2, 13, 2, 0),
            child: CustomTextField(controller: per_kg_cost, hintText: "Per Kg Cost", obscureText: false, textinputtypephone: true)),

        // Container(
        //     margin: EdgeInsets.fromLTRB(2, 13, 2, 0),
        //     child: CustomTextField(controller: total_cost, hintText: "Total Cost", obscureText: false, textinputtypephone: true)),

        Container(
            margin: EdgeInsets.fromLTRB(2, 13, 2, 0),
            child: CustomTextField(controller: others_income, hintText: "Others Income", obscureText: false, textinputtypephone: true)),

        Container(
            margin: EdgeInsets.fromLTRB(2, 13, 2, 0),
            child: CustomTextField(controller: expenses, hintText: "Expenses", obscureText: false, textinputtypephone: true)),

        // Container(
        //     margin: EdgeInsets.fromLTRB(2, 13, 2, 0),
        //     child: CustomTextField(controller: net_profit, hintText: "Net Profit", obscureText: false, textinputtypephone: true)),

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
                              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2),
                              child: Text('Cattle ID: ${i['cattle_id']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
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
                              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                              child: Text('Slaughtering Date: ${i['slaughtering_date'] != null ? DateFormat('dd/MM/yyyy').format(DateTime.parse(i['slaughtering_date'])) : ''}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),),
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                              child: Text('Cattle Body Weight: ${i['cattle_body_weight']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),),
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                              child: Text('Per Kg Cost: ${i['per_kg_cost']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),),
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                              child: Text('Others Income: ${i['others_income']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),),
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                              child: Text('Expenses: ${i['expenses']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),),
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 2),
                              child: Text('Net Profit: ${i['net_profit']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),),
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
                                  edit_cattle_id = i['id'].toString();
                                  edit_cattle_body_weight.text = i['weight'].toString();
                                  edit_per_kg_cost.text = i['per_kg_cost'].toString();
                                  edit_others_income.text = i['others_income'].toString();
                                  edit_expenses.text = i['expenses'].toString();


                                });

                                getSeats(i['shed_id']);
                                getCattles(i['shed_id'], i['seat_id']);
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
                                                            value: edit_cattle_id,
                                                            isExpanded: true,
                                                            menuMaxHeight: 350,
                                                            hint: Text('Select Cattle ID'),
                                                            items: [
                                                              ...cattles.map<DropdownMenuItem<String>>((data) {
                                                                return DropdownMenuItem(
                                                                    child: Text(data['cattle_id'].toString()), value: data['id'].toString());
                                                              }).toList(),
                                                            ],

                                                            onChanged: (value) {
                                                              print("selected Value $value");

                                                              setStateSB(() {
                                                                edit_cattle_id = value!;
                                                              });
                                                            }),


                                                      )

                                                    // CustomTextField()
                                                  ),
                                                ),
                                                Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Text('Slaughtering Date: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                                                        Text("${edit_slaughtering_date!.toLocal()}".split(' ')[0], style: TextStyle(fontSize: 20),),
                                                        GestureDetector(
                                                          onTap: () {
                                                            _selectDate(context, setStateSB, edit_slaughtering_date, (value) { edit_slaughtering_date = value; });
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
                                                    margin: EdgeInsets.fromLTRB(2, 10, 2, 0),
                                                    child: CustomTextField(controller: edit_cattle_body_weight, hintText: "Cattle Body Weight", obscureText: false, textinputtypephone: true)),

                                                // Container(
                                                //     margin: EdgeInsets.fromLTRB(2, 13, 2, 0),
                                                //     child: CustomTextField(controller: purchase_cost, hintText: "Purchase Cost", obscureText: false, textinputtypephone: true)),

                                                // Container(
                                                //     margin: EdgeInsets.fromLTRB(2, 13, 2, 0),
                                                //     child: CustomTextField(controller: cattle_body_weight, hintText: "Body Weight KG ", obscureText: false, textinputtypephone: true)),

                                                Container(
                                                    margin: EdgeInsets.fromLTRB(2, 13, 2, 0),
                                                    child: CustomTextField(controller: edit_per_kg_cost, hintText: "Per Kg Cost", obscureText: false, textinputtypephone: true)),

                                                // Container(
                                                //     margin: EdgeInsets.fromLTRB(2, 13, 2, 0),
                                                //     child: CustomTextField(controller: total_cost, hintText: "Total Cost", obscureText: false, textinputtypephone: true)),

                                                Container(
                                                    margin: EdgeInsets.fromLTRB(2, 13, 2, 0),
                                                    child: CustomTextField(controller: edit_others_income, hintText: "Others Income", obscureText: false, textinputtypephone: true)),

                                                Container(
                                                    margin: EdgeInsets.fromLTRB(2, 13, 2, 0),
                                                    child: CustomTextField(controller: edit_expenses, hintText: "Expenses", obscureText: false, textinputtypephone: true)),





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
