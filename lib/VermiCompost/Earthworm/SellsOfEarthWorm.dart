import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:tania_farm/components/CustomTextField.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class EarthWormSells extends StatefulWidget {
  const EarthWormSells({Key? key}) : super(key: key);

  @override
  State<EarthWormSells> createState() => _EarthWormSellsState();
}

class _EarthWormSellsState extends State<EarthWormSells> {
  TextEditingController kg = TextEditingController(); // C.ADDRESS
  TextEditingController amount = TextEditingController(); // C.ADDRESS

  TextEditingController editkg = TextEditingController();
  TextEditingController editid = TextEditingController();
  TextEditingController editamount = TextEditingController();

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

  void getData() async{
    final url = Uri.parse('http://68.178.163.174:5010/vermi_compost/earthworm_sells');

    Response res = await get(url);

    setState(() {
      data = jsonDecode(res.body);

    });

    FocusManager.instance.primaryFocus?.unfocus();
  }

  void addData() async {
    final url = Uri.parse('http://68.178.163.174:5010/vermi_compost/earthworm_sells/add');

    Map<String, dynamic> data = { 'amount': kg.text, 'date': selectedDate.toIso8601String(), 'price': amount.text  };

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
        selectedDate = DateTime.now();
        amount.text = '';
        // seller = '';
      });
    }


    getData();
  }

  void editData() async {
    final url = Uri.parse('http://68.178.163.174:5010/vermi_compost/earthworm_sells/edit?id=${editid.text}');

    Map<String, dynamic> data = {  'amount': editkg.text, 'date': selectedEditDate.toIso8601String(), 'price': editamount.text };

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
    final url = Uri.parse('http://68.178.163.174:5010/vermi_compost/earthworm_sells/delete?id=${id}');
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
        appBar: CustomAppBar(title: 'EarthWorm Sells Details',), //Appbar
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
              child: CustomTextField(controller: kg, hintText: "kg", obscureText: false, textinputtypephone: false)),

          Container(
              margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
              child: CustomTextField(controller: amount, hintText: "Amount BDT", obscureText: false, textinputtypephone: false)),

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
                                child: Text('ID: ${i['id']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                                child: Text('Amount: ${i['amount']} kg', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),),
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                                child: Text('Price: ${i['price']} BDT', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),),
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
                                    selectedEditDate = DateTime.parse(i['date']);
                                    editamount.text = i['price'].toString();
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
                                                      child: CustomTextField(controller: editkg, hintText: "Kg", obscureText: false, textinputtypephone: true)), //Custom TextFeild

                                                  Container(
                                                      margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
                                                      child: CustomTextField(controller: editamount, hintText: "Amount", obscureText: false, textinputtypephone: true)), //Custom TextFeild


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

        ],)
    );
  }
}
