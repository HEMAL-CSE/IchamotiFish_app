import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';
import 'package:tania_farm/components/CustomTextField.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DairyTreatment extends StatefulWidget {
  const DairyTreatment({super.key});

  @override
  State<DairyTreatment> createState() => _DairyTreatmentState();
}

class _DairyTreatmentState extends State<DairyTreatment> {
  String? shed_id;

  String? seat_id;

  String? cow_id;

  String? farm_id;

  TextEditingController diseases_description = TextEditingController();

  TextEditingController treatment = TextEditingController();

  TextEditingController cost = TextEditingController();

  TextEditingController remarks = TextEditingController();



  String? edit_shed_id;

  String? edit_seat_id;

  String? edit_cow_id;



  TextEditingController editid = TextEditingController();

  List<dynamic> data = [];

  List<dynamic> sheds = [];

  List<dynamic> seats = [];

  List<dynamic> cows = [];

  List doctors = [];
  List<File>? imageFiles;

  // List<dynamic> data = [];


  Future pickImages() async {
    // try {
    //   final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    //   if(image == null) return;
    //   final imageTemp = File(image.path);
    //   setState(() {
    //     imageFile = imageTemp;
    //   });
    // } on PlatformException catch(e) {
    //   print('Failed to pick image: $e');
    // }

    // final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    // if(image == null) return;
    // final imageTemp = File(image.path);
    // setState(() {
    //   imageFile = imageTemp;
    // });

    ImagePicker imagePicker = ImagePicker();
    List<File>? imageFileList = [];
    final List<XFile>? selectedImages = await
    imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      for(var image in selectedImages)
        imageFileList.add(File(image.path));
    }
    print("Image List Length:" + imageFileList!.length.toString());
    setState(() {
      imageFiles = imageFileList;
    });
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

  void getFarmInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? owner_id = prefs.getString('user_id');

    final url = Uri.parse('http://68.178.163.174:5010/farm/info?owner_id=${owner_id}');

    Response res = await get(url);

    var x = jsonDecode(res.body);

    print(x);

    setState(() {
      farm_id = x[0]['id'].toString();
    });
  }

  void getCows(shed_id, seat_id) async {
    final url = Uri.parse('http://68.178.163.174:5010/dairy/dairy_cows?shed_id=${shed_id}&seat_id=${seat_id}');

    Response res = await get(url);

    setState(() {
      cows = jsonDecode(res.body);
    });
  }

  void handleSubmit() async {
    for(var i in doctors){
      if(i['selected'] == true){
        MultipartRequest request = MultipartRequest('POST', Uri.parse('http://68.178.163.174:5010/dairy/treatment'));

        // print(MultipartFile('file', imageFile!.readAsBytes().asStream(), imageFile!.lengthSync()));


        // request.files.add(MultipartFile('file', imageFile!.readAsBytes().asStream(), imageFile!.lengthSync(), filename: imageFile!.path.split('/').last));
        final uploadList = <MultipartFile>[];
        for (final imageFile in imageFiles!) {
          uploadList.add(
            await MultipartFile(
              'files',
              imageFile!.readAsBytes().asStream(),
              imageFile.lengthSync(),
              filename: imageFile.path
                  .split('/')
                  .last,
            ),
          );
        }

        request.files.addAll(uploadList);

        Map<String, String> _fields = Map();

        _fields.addAll({
          'shed_id': shed_id!,
          'seat_id': seat_id!,
          'cow_id': cow_id!,
          'disease_desc': diseases_description.text,
          'farm_id': farm_id!,
          'doctor_id': i['doctor_id'].toString()
        });

        request.fields.addAll(_fields);

        StreamedResponse res = await request.send();

        if(res.statusCode == 201){
          Fluttertoast.showToast(
              msg: "Successfully Saved",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0

          );


        }
      }
    }

    setState(() {
      shed_id = null;
      seat_id = null;
      cow_id = null;
      diseases_description.text = '';
      imageFiles = [];
    });

    getData();

  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? user_id = prefs.getString('user_id');

    String? farm_id = prefs.getString('farm_id');

    final url = Uri.parse('http://68.178.163.174:5010/doctors/dairy?farm_id=${farm_id}');

    Response res = await get(url);

    print(jsonDecode(res.body));

    var resbody = jsonDecode(res.body);

    List result = resbody
        .fold({}, (previousValue, element) {
      Map val = previousValue as Map;
      // print(val);
      var id = element['doctor_id'];
      if (!val.containsKey(id)) {
        val[id] = [];
      }
      element.remove('doctor_id');
      val[id]?.add(element);
      return val;
    })
        .entries
        .map((e) => {e.key: e.value})
        .toList();

    print(result);


    setState(() {
      data = result;
    });
  }

  void deleteData(cow_id, doctor_id) async {
    final url = Uri.parse('http://68.178.163.174:5010/dairy/treatment/delete?cow_id=${cow_id}&doctor_id=${doctor_id}');

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

  void getDoctors() async {
    final url = Uri.parse('http://68.178.163.174:5010/dairy/doctors');
    Response res = await get(url);

    var resbody = jsonDecode(res.body);

    var result = resbody.map((item) {
      item['selected'] = false;
      return item;
    }).toList();

    print(result);

    setState(() {
      doctors = result;
    });
  }

  @override void initState() {
    // TODO: implement initState
    super.initState();
    getSheds();
    getFarmInfo();
    getData();
    getDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Treatment',),
      body: ListView(
        children: [
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
                        getCows(shed_id, value);
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
                      value: cow_id,
                      isExpanded: true,
                      menuMaxHeight: 350,
                      hint: Text('Select Cow ID'),
                      items: [
                        ...cows.map<DropdownMenuItem<String>>((data) {
                          return DropdownMenuItem(
                              child: Text(data['cow_id'].toString()), value: data['id'].toString());
                        }).toList(),
                      ],

                      onChanged: (value) {
                        print("selected Value $value");

                        setState(() {
                          cow_id = value!;
                        });
                      }),


                )

              // CustomTextField()
            ),
          ),


          CustomTextField(controller: diseases_description, hintText: 'Disease Description', obscureText: false, textinputtypephone: false, maxLines: 8,),

          // MaterialButton(
          //     color: Colors.blue,
          //     child: const Text(
          //         "Pick Image from Gallery",
          //         style: TextStyle(
          //             color: Colors.white70, fontWeight: FontWeight.bold
          //         )
          //     ),
          //     onPressed: () {
          //       pickImages();
          //     }
          // ),
          //
          // if(imageFiles != null)
          //   Image.file(
          //       File(imageFile!.path), // You can access it with . operator and path property
          //     fit: BoxFit.cover,
          //
          //   ),
          ElevatedButton(
            onPressed: () {
              pickImages();
            },
            child: Text('Select Images'),
          ),
          if(imageFiles != null)
            GridView.builder(
                physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                shrinkWrap: true,
                itemCount: imageFiles!.length,
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return Image.file(File(imageFiles![index].path),
                    fit: BoxFit.cover,);
                }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Container( padding: EdgeInsets.symmetric(horizontal: 10, vertical: 08),
              //   // margin: EdgeInsets.all(04),
              //   child: ElevatedButton(onPressed: (){
              //       handleSubmit();
              //   }, child: const Text("Save")),
              // ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 08),
                // margin: EdgeInsets.all(04),
                child: ElevatedButton(onPressed: (){
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                      content: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for(var i in doctors)
                                    Row(
                                      children: [
                                        Text('${i['doctor_name']}'),
                                        Expanded(
                                          child: CheckboxListTile(
                                            value: i["selected"],
                                            onChanged: (value) {
                                              setState(() {
                                                i["selected"] = value!;
                                              });
                                            },

                                          ),
                                        ),
                                      ],
                                    )
                                ],
                              ),

                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.greenAccent[400],
                                  foregroundColor: Colors.black
                                ),
                                  onPressed: (){
                                handleSubmit();
                                Navigator.pop(context, 'OK');
                              }, child: Text('Submit', style: TextStyle(fontSize: 16),)),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                }, child: const Text("Send to doctors")),
              ),
              Spacer(),
            ],
          ),

          for(var i in data)
            Card(
              elevation: 5,
              child: Container(
                // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                    color: Colors.green[300]
                ),
                child: Column(
                  children: [
                    Text('Doctor ID: ${i.keys.toList()[0]}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    Text('Cow ID: ${i[i.keys.toList()[0]][0]['cow_id']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    Text('${i[i.keys.toList()[0]][0]['disease_desc']}', style: TextStyle(fontSize: 15),),

                    i[i.keys.toList()[0]][0]['image_url'] != null && i[i.keys.toList()[0]][0]['image_url'] != '' ?
                    GridView.builder(
                        physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                        shrinkWrap: true,
                        itemCount: i[i.keys.toList()[0]]!.length,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: i[i.keys.toList()[0]]!.length > 3 ? 3 : i[i.keys.toList()[0]]!.length
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(margin:EdgeInsets.all(5),child: CachedNetworkImage(imageUrl: i[i.keys.toList()[0]][index]['image_url'], errorWidget: (context, url, error) => Icon(Icons.error),));
                        })
                        : Text(''),

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 100),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.green[500],
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet<void>(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context)
                                  {
                                    return StatefulBuilder(
                                        builder: (context, setStateSB) {
                                          return FractionallySizedBox(
                                            heightFactor: 0.7,
                                            child: Column(
                                              children: [
                                                Text('Treatment', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                                Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    padding: EdgeInsets.all(10),
                                                    margin: EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[300]
                                                    ),
                                                    child: Text('${i[i.keys.toList()[0]][0]['treatment_desc'] != null ? i[i.keys.toList()[0]][0]['treatment_desc'] : ''}'))
                                              ],
                                            ),
                                          );
                                        }
                                    );
                                  }
                              );

                              // height: 200,``
                            },
                            child: Icon(CupertinoIcons.eye, color: Colors.grey[300],),
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
                                        deleteData(i[i.keys.toList()[0]][0]['cow_id'],i.keys.toList()[0]);
                                        Navigator.pop(context, 'OK');
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Icon(Icons.delete, color: Colors.red[300],),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),




        ],
      ),
    );
  }
}
