import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';

class othersFeatures extends StatefulWidget {
  const othersFeatures({super.key});

  @override
  State<othersFeatures> createState() => _othersFeaturesState();
}

class _othersFeaturesState extends State<othersFeatures> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Others Features',),
    );
  }
}
