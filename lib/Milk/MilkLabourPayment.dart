import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:tania_farm/components/CustomTextField.dart';

class MilkLabourPayment extends StatefulWidget {
  const MilkLabourPayment({super.key});

  @override
  State<MilkLabourPayment> createState() => _MilkLabourPaymentState();
}

class _MilkLabourPaymentState extends State<MilkLabourPayment> {
  String? shed_id;

  String? seat_id;

  String? others_id;

  TextEditingController payment = TextEditingController();

  String? edit_shed_id;

  String? edit_seat_id;

  String? edit_others_id;

  TextEditingController editid = TextEditingController();

  TextEditingController editpayment = TextEditingController();

  List<dynamic> data = [];

  List<dynamic> sheds = [];

  List<dynamic> seats = [];

  List<dynamic> others = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'শ্রমিক পেমেন্ট',),
      body: ListView(
        children: [
          SizedBox(height: 06,),

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
                      value: others_id,
                      isExpanded: true,
                      menuMaxHeight: 350,
                      hint: Text('বাছাই করুন'),
                      items: [
                        ...others.map<DropdownMenuItem<String>>((data) {
                          return DropdownMenuItem(
                              child: Text(data['name']), value: data['id'].toString());
                        }).toList(),
                      ],

                      onChanged: (value) {
                        print("selected Value $value");
                        setState(() {
                          others_id = value!;
                        });
                      }),


                )

              // CustomTextField()
            ),
          ),

          Container(
              margin: EdgeInsets.fromLTRB(2, 12, 2, 0),
              child: CustomTextField(controller: payment, hintText: "বেতন", obscureText: false, textinputtypephone: true)),

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
                              child: Text('শ্রমিক নাম্বার: 1', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 2),
                              child: Text('বেতন: 2000 BDT', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),),
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
                                //   edit_others_id = i['others_id'].toString();
                                //   editpayment.text = i['payment'];
                                //
                                // });
                                //
                                // getSeats(i['shed_id']);
                                // getOthers(i['shed_id'], i['seat_id']);
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
                                                            value: edit_others_id,
                                                            isExpanded: true,
                                                            menuMaxHeight: 350,
                                                            hint: Text('Select'),
                                                            items: [
                                                              ...others.map<DropdownMenuItem<String>>((data) {
                                                                return DropdownMenuItem(
                                                                    child: Text(data['name']), value: data['id'].toString());
                                                              }).toList(),
                                                            ],

                                                            onChanged: (value) {
                                                              print("selected Value $value");
                                                              setStateSB(() {
                                                                edit_others_id = value!;
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

        ],
      ),
    );
  }
}
