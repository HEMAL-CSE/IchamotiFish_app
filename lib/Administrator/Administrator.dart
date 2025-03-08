import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';

class Administrator extends StatefulWidget {
  const Administrator({super.key});

  @override
  State<Administrator> createState() => _AdministratorState();
}

class _AdministratorState extends State<Administrator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Administrator',),
      body: Center(
        child: ListView(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, '/approve_doctor');
              },
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                ),
                child: Text('Approve Doctor', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
              ),
            ),


            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, '/approved_doctor');
              },
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                ),
                child: Text('Approved Doctors', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
