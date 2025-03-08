import 'dart:convert';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomTextField.dart';
import 'package:tania_farm/components/ClickButton.dart';
import 'package:http/http.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Login extends StatefulWidget {
   Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
    final usernameController = TextEditingController();

    final passwordController = TextEditingController();

    // final GoogleSignIn _googleSignIn = GoogleSignIn();



    // final FirebaseAuth auth = FirebaseAuth.instance;

    Map<String, dynamic> user = {};

   final TextEditingController phoneController = TextEditingController(text: "+880");

   final TextEditingController otpController = TextEditingController();

    bool otpVisibility = false;

    String verificationID = "";

    TextEditingController mobileorusercode = TextEditingController();

    TextEditingController password = TextEditingController();
    

    @override
    void initState(){
      super.initState();

      // getUser();

      navigateToDashboard();

    }
    
    void getUser() async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final jsonUser = prefs.getString('user') ?? '';
      print(jsonUser);
      if(jsonUser.isNotEmpty){
        if(jsonDecode(jsonUser)['phone_number'].isNotEmpty){
          Navigator.pushNamed(context, '/');
        }
      }
      
    }

  // void signUserIn(context) async {
  //   print(phoneController.text);
  //   final res = await get(Uri.parse('http://192.168.0.104:5008/users/${phoneController.text}'));
  //   print(res.body);
  //   if(jsonDecode(res.body)["no_results"]){
  //     Fluttertoast.showToast(
  //         msg: "Phone number doesn't exist",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.red,
  //         textColor: Colors.white,
  //         fontSize: 16.0
  //     );
  //   }else{
  //     setState(() {
  //       user = jsonDecode(res.body)["result"][0];
  //       print(user);
  //     });
  //     auth.verifyPhoneNumber(
  //       phoneNumber: phoneController.text,
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         await auth.signInWithCredential(credential).then((value){
  //           print("You are logged in successfully");
  //         });
  //       },
  //       verificationFailed: (FirebaseAuthException e) {
  //         print(e.message);
  //       },
  //       codeSent: (String verificationId, int? resendToken) {
  //         print(verificationId);
  //         otpVisibility = true;
  //         verificationID = verificationId;
  //         setState(() {});
  //       },
  //       codeAutoRetrievalTimeout: (String verificationId) {
  //
  //       },
  //     );
  //
  //   }
  //
  //
  //
  //     // Navigator.pushNamed(context, '/superadmin');
  // }

   // void verifyOTP() async {
   //   final SharedPreferences prefs = await SharedPreferences.getInstance();
   //
   //   PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationID, smsCode: otpController.text);
   //
   //   await auth.signInWithCredential(credential).then((value) async{
   //     print("You are logged in successfully");
   //     if(user["role"] == 'Admin'){
   //       await prefs.setString('user', jsonEncode(user));
   //       Navigator.pushNamed(context, '/');
   //     }
   //
   //     Fluttertoast.showToast(
   //         msg: "You are logged in successfully",
   //         toastLength: Toast.LENGTH_SHORT,
   //         gravity: ToastGravity.CENTER,
   //         timeInSecForIosWeb: 1,
   //         backgroundColor: Colors.red,
   //         textColor: Colors.white,
   //         fontSize: 16.0
   //     );
   //   });
   // }



   void goToLink(user_type_id, user_id) async {
      switch (user_type_id){
        case 1:
            Navigator.pushNamed(context, '/admin');
          break;
        case 2:
          Navigator.pushNamed(context, '/admin');
          break;
        case 3:
          final url = Uri.parse('http://68.178.163.174:5010/doctors/check_approved?user_id=${user_id}');
          Response res = await get(url);
          print(res.body);
          var resbody = jsonDecode(res.body);
          print(resbody);
          if(resbody['checked'] == true){
            Fluttertoast.showToast(
                msg: "Login Successful",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0

            );
            Navigator.pushNamed(context, '/doctor');
          } else if(resbody['checked'] == false){
            Fluttertoast.showToast(
                msg: "Not Approved",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0

            );
          }
          break;
        case 4:
          Navigator.pushNamed(context, '/generalmanager');
          break;
        case 5:
          Navigator.pushNamed(context, '/manager');
          break;
        case 6:
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('farm_id', '1');
          Navigator.pushNamed(context, '/home');
          break;
      }
   }
   
   void navigateToDashboard() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      
      String? user_type_id = prefs.getString('user_type_id');
      String? user_id = prefs.getString('user_id');
      
      if(user_type_id != null) {
        goToLink(int.parse(user_type_id!), int.parse(user_id!));
      }
   }

   void handleSubmit() async {

         // final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

     final phoneRegex = RegExp(r'^\d{11}$');
         
         var x = phoneRegex.hasMatch(mobileorusercode.text);

        final url = Uri.parse('http://68.178.163.174:5010/users/login?email=${x ? '1': '0'}');

        SharedPreferences prefs = await SharedPreferences.getInstance();

        Map<String, dynamic> bodyData = { 'mobile': mobileorusercode.text, 'password': password.text };

        Response res = await post(url, body: bodyData);

        var body = jsonDecode(res.body);
print(body['msg']);
        if(res.statusCode == 201){

          await prefs.setString('user_type_id', body['user_type_id'].toString());
          await prefs.setString('user_id', body['user_id'].toString());
          goToLink(body['user_type_id'],body['user_id']);
        }

   }


   // void loginWithPhone() async {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[300],
      body:  Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Text('Welcome to Ichamoti Fisheries', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Color(0xff076614)),),
              decoration: BoxDecoration(

              ),
            ),

            Center(
              child:
              Container(
                padding: EdgeInsets.all(15),
                child: Text('Login', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Color(0xff076614)),),
                decoration: BoxDecoration(

                ),
              ),


            ),
            CustomTextField(
                controller: mobileorusercode,
                hintText: 'Phone Number',
                obscureText: false,
                textinputtypephone: false
            ),
            SizedBox(height: 10,),

            CustomTextField(
                controller: password,
                hintText: 'Password',
                obscureText: true,
                textinputtypephone: false
            ),

            SizedBox(height: 10,),

            Container( padding: EdgeInsets.symmetric(horizontal: 10, vertical: 08),
              // margin: EdgeInsets.all(04),
              child: ElevatedButton(onPressed: (){
                handleSubmit();
              },
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xff076614)),
                  child: const Text("Login", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),)),
            ),

            SizedBox(height: 10,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Do not have an account?',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(width: 4),
                InkWell(
                  child:  Text(
                    'Register now',
                    style: TextStyle(
                      color: Color(0xff076614),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  onTap: () { Navigator.pushNamed(context, '/register'); },
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}


// class Login extends StatefulWidget {
//   const Login({Key? key}) : super(key: key);
//
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   @override
//
//   final usernameController = TextEditingController();
//   final passwordController = TextEditingController();
//
//   void signUserIn() {
//
//   }
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       body: const SafeArea(
//         child: Center(
//           child: Column(
//             children : [
//               Icon(
//                   Icons.lock,
//                   size: 100,
//               ),
//               SizedBox(height: 50,),
//
//               LoginTextField(
//                 controller: usernameController,
//                 hintText: 'Username',
//                 obscureText: false,
//               ),
//
//               const SizedBox(height: 10),
//
//               // password textfield
//               LoginTextField(
//                 controller: passwordController,
//                 hintText: 'Password',
//                 obscureText: true,
//               ),
//               const SizedBox(height: 25),
//
//               // sign in button
//               Button(
//                 onTap: signUserIn,
//               ),
//             ],
//           ),
//         ),
//       )
//     );
//   }
// }
