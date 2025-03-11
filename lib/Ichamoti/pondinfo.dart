import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';

class IchamotiPond extends StatefulWidget {
  const IchamotiPond({super.key});

  @override
  State<IchamotiPond> createState() => _IchamotiPondState();
}

class _IchamotiPondState extends State<IchamotiPond> {


  String? shed_id;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Pond Info',),



    );
  }
}
