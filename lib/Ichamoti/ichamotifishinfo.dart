import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';

class Ichamotifishinfo extends StatefulWidget {
  const Ichamotifishinfo({super.key});

  @override
  State<Ichamotifishinfo> createState() => _IchamotifishinfoState();
}

class _IchamotifishinfoState extends State<Ichamotifishinfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'মাছের পোনার তথ্য',),
    );
  }
}
