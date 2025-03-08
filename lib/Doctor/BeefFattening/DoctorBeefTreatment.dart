import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:tania_farm/components/CustomTextField.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorBeefTreatment extends StatefulWidget {
  final cattle_id;
  const DoctorBeefTreatment({super.key, this.cattle_id});

  @override
  State<DoctorBeefTreatment> createState() => _DoctorBeefTreatmentState();
}

class _DoctorBeefTreatmentState extends State<DoctorBeefTreatment> {
  var cattle = {};



  TextEditingController treatment = TextEditingController();

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? user_id = prefs.getString('user_id');

    final url = Uri.parse('http://68.178.163.174:5010/doctors/beef/cattle?user_id=${user_id}&cattle_id=${widget.cattle_id}');

    Response res = await get(url);
    print(user_id);
    print(jsonDecode(res.body));

    var resbody = jsonDecode(res.body);
    List result = resbody
        .fold({}, (previousValue, element) {
      Map val = previousValue as Map;
      // print(val);
      var id = element['cattle_id'];
      if (!val.containsKey(id)) {
        val[id] = [];
      }
      element.remove('cattle_id');
      val[id]?.add(element);
      return val;
    })
        .entries
        .map((e) => {e.key: e.value})
        .toList();
    print(result[0][result[0].keys.toList()[0]][0]['disease_desc']);
    // print(result);


    setState(() {
      cattle = result[0];
      treatment.text = result[0][result[0].keys.toList()[0]][0]['treatment_desc'] != null ? result[0][result[0].keys.toList()[0]][0]['treatment_desc'] : '';
    });

  }

  void handleSubmit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? user_id = prefs.getString('user_id');
    final url = Uri.parse('http://68.178.163.174:5010/doctors/beef/treatment?doctor_id=${user_id}');
    Map<String, dynamic> body = {'treatment': treatment.text};

    Response res = await put(url, body: body);

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
  }



  @override void initState() {
    // TODO: implement initState
    super.initState();
    getData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Treatment',),
      body: ListView(
        children: [
          Text('Cattle ID: ${cattle.keys.toList()[0]}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          Text('${cattle[cattle.keys.toList()[0]][0]['disease_desc']}', style: TextStyle(fontSize: 15),),

          cattle[cattle.keys.toList()[0]][0]['image_url'] != null && cattle[cattle.keys.toList()[0]][0]['image_url'] != '' ?
          GridView.builder(
              physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
              shrinkWrap: true,
              itemCount: cattle[cattle.keys.toList()[0]]!.length,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cattle[cattle.keys.toList()[0]]!.length > 3 ? 3 : cattle[cattle.keys.toList()[0]]!.length
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(margin:EdgeInsets.all(5),child: CachedNetworkImage(imageUrl: cattle[cattle.keys.toList()[0]][index]['image_url'], errorWidget: (context, url, error) => Icon(Icons.error),));
              })
              : Text(''),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: CustomTextField(controller: treatment, hintText: 'treatment', obscureText: false, textinputtypephone: false, maxLines: 6,),
          ),

          Container( padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(04),
            child: ElevatedButton(onPressed: (){
              handleSubmit();
            }, child: const Text("Submit")),
          ),
        ],
      ),
    );
  }
}
