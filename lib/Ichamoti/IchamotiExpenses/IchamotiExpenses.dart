import 'package:flutter/material.dart';
import 'package:tania_farm/Ichamoti/ichamotidashboard.dart';
import 'package:tania_farm/components/CustomAppBar.dart';

class IchamotiExpenses extends StatefulWidget {
  const IchamotiExpenses({super.key});

  @override
  State<IchamotiExpenses> createState() => _IchamotiExpensesState();
}

class _IchamotiExpensesState extends State<IchamotiExpenses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'খরচসমূহ',),


      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            DashboardButton(
              icon: Icons.feed_rounded,
              label: 'খাদ্য ব্যবস্থাপনা খরচ',
              color: Colors.lightBlue,
              onTap: () {
                Navigator.pushNamed(context, '/foodexpenses');
              },
            ),
            DashboardButton(
              icon: Icons.people,
              label: 'শ্রমিকদের তালিকা',
              color: Colors.lightBlue,
              onTap: () {
                print('Job Card clicked');
              },
            ),
            DashboardButton(
              icon: Icons.money_sharp,
              label: 'শ্রমিকদের বেতন',
              color: Colors.deepPurple,
              onTap: () {
                Navigator.pushNamed(context, '/fishproduction');
              },
            ),
            DashboardButton(
              icon: Icons.task,
              label: 'অন্যান্য খরচ',
              color: Colors.pinkAccent,
              onTap: () {
                Navigator.pushNamed(context, '/fishsells');
              },
            ),

            DashboardButton(
              icon: Icons.money,
              label: 'অন্যান্য পেমেন্ট',
              color: Colors.pinkAccent,
              onTap: () {
                Navigator.pushNamed(context, '/othersfeatures');
              },
            ),

          ],
        ),
      ),

    );
  }
}
