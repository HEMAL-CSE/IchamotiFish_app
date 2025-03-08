import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';

class EarthWormEnvironment extends StatefulWidget {
  const EarthWormEnvironment({super.key});

  @override
  State<EarthWormEnvironment> createState() => _EarthWormEnvironmentState();
}

class _EarthWormEnvironmentState extends State<EarthWormEnvironment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Earthworm Environment',),
      body: ListView(children: [

      ],),
    );
  }
}
