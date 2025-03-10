import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final title;

  @override
  Size get preferredSize => const Size.fromHeight(50);


  const CustomAppBar({super.key, this.title});


  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xff076614),
      title: Text('${this.title}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
      centerTitle: true,
    );
  }
}
