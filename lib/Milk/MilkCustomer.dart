import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:tania_farm/components/CustomTextField.dart';

class MilkCustomer extends StatefulWidget {
  const MilkCustomer({super.key});

  @override
  State<MilkCustomer> createState() => _MilkCustomerState();
}

class _MilkCustomerState extends State<MilkCustomer> {
  TextEditingController customer_name = TextEditingController();

  TextEditingController edit_customer_name = TextEditingController();

  List<dynamic> doctors = [];

  TextEditingController editid = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'ক্রেতাদের তালিকা',),
      body: ListView(children: [

        Container(
            margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
            child: CustomTextField(controller: customer_name, hintText: "নাম", obscureText: false, textinputtypephone: false)),

        SizedBox(height: 10,),

        Container( padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(04),
          child: ElevatedButton(onPressed: (){
            // addData();
          }, child: const Text("জমা দিন")),
        ),

        // for(var i in data)
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
                            child: Text('ক্রেতার নাম: Rayat', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
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
                              //   edit_doctor_id = i['doctor_id'].toString();
                              //
                              // });

                              // getSeats(i['shed_id']);
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
                                              Container(
                                                  margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
                                                  child: CustomTextField(controller: edit_customer_name, hintText: "নাম", obscureText: false, textinputtypephone: false)),

                                              SizedBox(height: 10,),



                                              Container( padding: EdgeInsets.symmetric(horizontal: 80, vertical: 08),
                                                margin: EdgeInsets.all(04),
                                                child: ElevatedButton(onPressed: (){
                                                  // editData();
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
                                        // deleteData(i['id']);
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
