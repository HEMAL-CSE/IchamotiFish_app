import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';

class ExpensesLabourList extends StatefulWidget {
  const ExpensesLabourList({super.key});

  @override
  State<ExpensesLabourList> createState() => _ExpensesLabourListState();
}

class _ExpensesLabourListState extends State<ExpensesLabourList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: CustomAppBar(title: 'Labour List',),

      body: ListView(
        children: [

        ],
      ),
    );
  }
}
