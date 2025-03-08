import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:tania_farm/components/CustomTextField.dart';

class TotalMilkProd extends StatefulWidget {
  const TotalMilkProd({super.key});

  @override
  State<TotalMilkProd> createState() => _TotalMilkProdState();
}

class _TotalMilkProdState extends State<TotalMilkProd> {

  DateTime date = DateTime.now();
  DateTime edit_date = DateTime.now();

  TextEditingController amount = TextEditingController();

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'মোট উৎপাদিত দুধ',),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('তারিখ: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                    Text("${date!.toLocal()}".split(' ')[0], style: TextStyle(fontSize: 20),),
                    GestureDetector(
                      onTap: () {
                        _selectDate(context, setState, date, (value) { date = value; });
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

            CustomTextField(controller: amount, hintText: 'পরিমাণ', obscureText: false, textinputtypephone: false),

            SizedBox(height: 10,),

            Container( padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(04),
              child: ElevatedButton(onPressed: (){
                // addData();
              }, child: const Text("জমা দিন")),
            ),

            SizedBox(height: 20,),

            Column(
              children: [
                Container(
                  height: 200,
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
                                child: Text('তারিখ: 22/03/2024', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                                child: Text('পরিমাণ: 2 kg', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),),
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
                                                  Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Text('তারিখ: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                                                          Text("${edit_date!.toLocal()}".split(' ')[0], style: TextStyle(fontSize: 20),),
                                                          GestureDetector(
                                                            onTap: () {
                                                              _selectDate(context, setState, edit_date, (value) { edit_date = value; });
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

                                                  CustomTextField(controller: amount, hintText: 'পরিমাণ', obscureText: false, textinputtypephone: false),

                                                  SizedBox(height: 08,),

                                                  Container( padding: EdgeInsets.all(10),
                                                    margin: EdgeInsets.all(04),
                                                    child: ElevatedButton(
                                                        onPressed: (){
                                                      // addData();
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
      ),
    );
  }
}
