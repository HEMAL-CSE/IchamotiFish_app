import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:tania_farm/components/CustomTextField.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class OthersList extends StatefulWidget {
  const OthersList({super.key});

  @override
  State<OthersList> createState() => _OthersListState();
}

class _OthersListState extends State<OthersList> {


  TextEditingController name = TextEditingController(); // labourname


  TextEditingController editid = TextEditingController();

  TextEditingController editname = TextEditingController(); // labourname


  List<dynamic> data = [];



  void getData() async{
    final url = Uri.parse('http://68.178.163.174:5010/vermi_compost/others_list');

    Response res = await get(url);

    setState(() {
      data = jsonDecode(res.body);

    });

    FocusManager.instance.primaryFocus?.unfocus();
  }

  void addData() async {
    final url = Uri.parse('http://68.178.163.174:5010/vermi_compost/others_list/add');

    Map<String, dynamic> data = { 'name': name.text };

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
        name.text = '';
        // seller = '';
      });
    }


    getData();
  }

  void editData() async {
    final url = Uri.parse('http://68.178.163.174:5010/vermi_compost/others_list/edit?id=${editid.text}');

    Map<String, dynamic> data = { 'name': editname.text };

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
    final url = Uri.parse('http://68.178.163.174:5010/vermi_compost/others_list/delete?id=${id}');
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
        appBar: CustomAppBar(title: 'অন্যান্য খরচসমূহ',), //Appbar
        body: ListView(children: [


          Container(
              margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
              child: CustomTextField(controller: name, hintText: "নাম", obscureText: false, textinputtypephone: false)), //Custom TextFeild

          const SizedBox(
            height: 20,
          ),


          Container( padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(04),
            child: ElevatedButton(onPressed: (){
              addData();
            }, child: const Text("জমা দিন")),
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
                                child: Text('${i['name']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
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
                                    editname.text = i['name'].toString();
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
                                                      margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
                                                      child: CustomTextField(controller: editname, hintText: "Labour Name", obscureText: false, textinputtypephone: false)), //Custom TextFeild

                                                  const SizedBox(
                                                    height: 20,
                                                  ),

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


        ],)

    );
  }
}
