import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tania_farm/components/CustomTextField.dart';
import 'package:tania_farm/components/ClickButton.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:firebase_auth/firebase_auth.dart';

import 'package:http/http.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {




  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  // TextEditingController usernameController = TextEditingController();
  //
  // TextEditingController passwordController = TextEditingController();
  //
  //  TextEditingController phoneController = TextEditingController(text: "+880");
  //
  // TextEditingController otpController = TextEditingController();
  //
  // final FirebaseAuth auth = FirebaseAuth.instance;
  //
  // bool otpVisibility = false;
  //
  // String verificationID = "";
  //
  // String? selectedRole;
  //
  // List<String> roles = [
  //   'Admin',
  //   // 'Store Admin',
  //   // 'Seller',
  //   // 'Viewer'
  // ];
  //
  // void signUserUp(context) {
  //   auth.verifyPhoneNumber(
  //     phoneNumber: phoneController.text,
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       await auth.signInWithCredential(credential).then((value){
  //         print("You are logged in successfully");
  //       });
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       print(e.message);
  //     },
  //     codeSent: (String verificationId, int? resendToken) {
  //       print(verificationId);
  //       otpVisibility = true;
  //       verificationID = verificationId;
  //       setState(() {});
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //
  //     },
  //   );
  //   // Navigator.pushNamed(context, '/superadmin');
  // }
  //
  // void verifyOTP() async {
  //
  //   PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationID, smsCode: otpController.text);
  //
  //   await auth.signInWithCredential(credential).then((value) async{
  //     print("You are registered successfully");
  //
  //     final uri = Uri.parse('http://192.168.0.101:5008/users/add');
  //     final headers = {'Content-Type': 'application/json'};
  //     Map<String, dynamic> body = {'username': usernameController.text, 'phone_number': phoneController.text, 'role': selectedRole};
  //     String jsonBody = json.encode(body);
  //     final encoding = Encoding.getByName('utf-8');
  //
  //     Response response = await post(
  //       uri,
  //       headers: headers,
  //       body: jsonBody,
  //       encoding: encoding,
  //     );
  //
  //     int statusCode = response.statusCode;
  //     String responseBody = response.body;
  //
  //
  //     print(responseBody);
  //
  //     // Navigator.pushNamed(context, '/superadmin');
  //     Fluttertoast.showToast(
  //         msg: "You are registered successfully",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.red,
  //         textColor: Colors.white,
  //         fontSize: 16.0
  //     );
  //   });
  // }

  String? user_type_id;

  List<dynamic> user_types = [
    // {
    //   'id': 2,
    //   'name': 'Administrator'
    // },

    {
      'id': 3,
      'name': 'Doctor'
    },


  ];

  TextEditingController farm_name = TextEditingController();



  TextEditingController otp = TextEditingController();

  bool showOTP = false;
  var receivedID = '';

  List<dynamic> divisions = [];

  String? selectedDivision;

  bool buttonDisabled = false;

  List<dynamic> districts = [];

  String? selectedDistrict;

  List<dynamic> upazilas = [];

  String? selectedUpazila;

  TextEditingController village = TextEditingController();

  TextEditingController mobile = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController name = TextEditingController();

  TextEditingController address = TextEditingController();

  TextEditingController password = TextEditingController();



  // final FirebaseAuth auth = FirebaseAuth.instance;


  // List<dynamic> types = [
  //   {
  //     'id': 1,
  //     'name': 'Vermi Compost',
  //     "isChecked": false,
  //   },
  //   {
  //     'id': 2,
  //     'name': 'Breeding',
  //     "isChecked": false,
  //   },
  //   {
  //     'id': 3,
  //     'name': 'Beef Fattening',
  //     "isChecked": false,
  //   },
  //   {
  //     'id': 4,
  //     'name': 'Dairy',
  //     "isChecked": false,
  //   },
  //   {
  //     'id': 5,
  //     'name': 'Goat',
  //     "isChecked": false,
  //   },
  //   {
  //     'id': 6,
  //     'name': 'Duck',
  //     "isChecked": false,
  //   },
  //   {
  //     'id': 7,
  //     'name': 'Fish',
  //     "isChecked": false,
  //   },
  //   {
  //     'id': 8,
  //     'name': 'Chicken',
  //     "isChecked": false,
  //   },
  // ];

  Future<void> getDivisions() async {
    final String response = await rootBundle.loadString('assets/divisions.json');
    final data = await jsonDecode(response);
    print(data);

    setState(() {
      divisions = data;
    });
  }

  Future<void> getUpazilas(id) async {
    upazilas.clear();
    final String response = await rootBundle.loadString('assets/upazilas.json');
    final data = await jsonDecode(response);
    print(data);
    for(var i in data){
      if(i['district_id'] == id){
        setState(() {
          upazilas.add(i);
        });
      }
    }

  }

  Future<void> getDistricts(id) async {
    districts.clear();
    final String response = await rootBundle.loadString('assets/districts.json');
    final data = await jsonDecode(response);
    print(data);
    for(var i in data){
      if(i['division_id'] == id){
        setState(() {
          districts.add(i);
        });
      }
    }

  }

  // void handleFarmSubmit() async {
  //   final url = Uri.parse('http://68.178.163.174:5010/users/register');
  //
  //   Map<String, dynamic> bodyData = {'name': farm_name.text, 'mobile': mobile.text, 'email': email.text, 'user_type_id': user_type_id, 'password': password.text};
  //
  //   Response res = await post(url, body: bodyData);
  //
  //   var data = jsonDecode(res.body);
  //
  //   final url2 = Uri.parse('http://68.178.163.174:5010/farm/add');
  //
  //
  //   Map<String, dynamic> bodyData2 = {'farm_name': farm_name.text, 'division': selectedDivision.toString(), 'district': selectedDistrict.toString(), 'upazila': selectedUpazila.toString(), 'village': village.text, 'owner_id': data['user_id'].toString(), 'types': jsonEncode({'types': types}) };
  //
  //   Response res2 = await post(url2, body: bodyData2);
  //   print(res2.statusCode);
  //
  //   if(res2.statusCode == 200){
  //     Fluttertoast.showToast(
  //         msg: "Registration Successful, You will be notified soon.",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.red,
  //         textColor: Colors.white,
  //         fontSize: 16.0
  //
  //     );
  //
  //
  //   }
  //
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   await prefs.remove('user_type_id');
  //   await prefs.remove('user_id');
  //   Navigator.pushNamed(context, '/');
  //
  // }

  // void verifyUserPhoneNumber() async {
  //   setState(() {
  //     buttonDisabled = true;
  //   });
  //       auth.verifyPhoneNumber(
  //         phoneNumber: '+88' + mobile.text,
  //         verificationCompleted: (PhoneAuthCredential credential) async {
  //           await auth.signInWithCredential(credential).then(
  //                 (value) => print('Logged In Successfully'),
  //           );
  //         },
  //
  //         verificationFailed: (FirebaseAuthException e) {
  //           print(e.message);
  //         },
  //         codeSent: (String verificationId, int? resendToken) async {
  //
  //           receivedID = verificationId;
  //           showOTP = true;
  //           buttonDisabled = false;
  //           setState(() {});
  //         },
  //         codeAutoRetrievalTimeout: (String verificationId) {
  //           print('TimeOut');
  //         },
  //       );
  //     }

  Future<void> handleDoctorSubmit() async {
    // PhoneAuthCredential credential = PhoneAuthProvider.credential(
    //   verificationId: receivedID,
    //   smsCode: otp.text,
    // );
    // await auth
    //     .signInWithCredential(credential)
    //     .then((value) async {
      final url = Uri.parse('http://68.178.163.174:5010/users/register');

      Map<String, dynamic> bodyData = {
        'name': name.text,
        'mobile': mobile.text,
        'email': email.text,
        'user_type_id': user_type_id,
        'password': password.text
      };

      Response res = await post(url, body: bodyData);
      var data = jsonDecode(res.body);
      if(res.statusCode == 201){


        print(data);

        final url2 = Uri.parse('http://68.178.163.174:5010/doctors/add');

        Map<String, dynamic> bodyData2 = {
          'user_id': data['user_id'].toString(),
          'address': address.text
        };

        Response res2 = await post(url2, body: bodyData2);

        if (res2.statusCode == 201) {
          Fluttertoast.showToast(
              msg: "Registration Successful, You will be notified soon.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0

          );
          SharedPreferences prefs = await SharedPreferences.getInstance();

          await prefs.remove('user_type_id');
          await prefs.remove('user_id');

Navigator.pushNamed(context, '/');

        }
      }else {
        Fluttertoast.showToast(
            msg: "${data['msg']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0

        );
      }


    // }).catchError((onError) {
    //   print(onError);
    //   Fluttertoast.showToast(
    //       msg: "Wrong Otp",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.CENTER,
    //       timeInSecForIosWeb: 1,
    //       backgroundColor: Colors.green,
    //       textColor: Colors.white,
    //       fontSize: 16.0
    //
    //   );
    //   setState(() {
    //     buttonDisabled = false;
    //   });
    // });



  }

  // Future<Position> _determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('Location services are disabled.');
  //   }
  //
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //
  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //
  //   return await Geolocator.getCurrentPosition();
  // }


  @override
  void initState() {
    super.initState();
    getDivisions();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,

          children: [

            Center(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Text('Sign Up', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent),),
                decoration: BoxDecoration(

                ),
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
                        value: user_type_id,
                        isExpanded: true,
                        menuMaxHeight: 350,
                        hint: Text('Select User Type'),
                        items: [
                          ...user_types.map<DropdownMenuItem<String>>((data) {
                            return DropdownMenuItem(
                                child: Text(data['name']), value: data['id'].toString());
                          }).toList(),
                        ],

                        onChanged: (value) {
                          print("selected Value $value");
                          // getSeats(value);
                          setState(() {
                            user_type_id = value!;
                          });
                        }),


                  )

                // CustomTextField()
              ),
            ),


            if(user_type_id == '3')
              Column(
                children: [
                  CustomTextField(
                      controller: name,
                      hintText: 'Name',
                      obscureText: false,
                      textinputtypephone: false
                  ),

                  SizedBox(height: 10,),

                  CustomTextField(
                      controller: address,
                      hintText: 'Address',
                      obscureText: false,
                      textinputtypephone: false
                  ),



                  SizedBox(height: 10,),

                  CustomTextField(
                      controller: email,
                      hintText: 'Email',
                      obscureText: false,
                      textinputtypephone: false
                  ),
                  SizedBox(height: 10,),

                  CustomTextField(
                      controller: password,
                      hintText: 'Password',
                      obscureText: false,
                      textinputtypephone: false
                  ),

                  SizedBox(height: 10,),
                  CustomTextField(
                      controller: mobile,
                      hintText: 'Phone Number',
                      obscureText: false,
                      textinputtypephone: false
                  ),

                  SizedBox(height: 10,),

                  if(showOTP)
                    CustomTextField(controller: otp, hintText: 'OTP', obscureText: true,
                        textinputtypephone: true),

                  Container( padding: EdgeInsets.symmetric(horizontal: 10, vertical: 08),
                    // margin: EdgeInsets.all(04),
                    child: ElevatedButton(onPressed:buttonDisabled ? null : (){
                      // if(showOTP == false){
                      //   verifyUserPhoneNumber();
                      // }else
                      //   {
                          handleDoctorSubmit();
                        // }

                    }, child: const Text("Save")),
                  ),
                ],
              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(width: 4),
                InkWell(
                  child:  Text(
                    'Login now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () { Navigator.pushNamed(context, '/'); },
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}

