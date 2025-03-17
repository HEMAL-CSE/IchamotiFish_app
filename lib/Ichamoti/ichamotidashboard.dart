import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';

class Ichamotidashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'ইছামতী পুকুর ড্যাশবোর্ড',),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            DashboardButton(
              icon: Icons.perm_device_information_sharp,
              label: 'পুকুরের তথ্য',
              color: Colors.pink,
              onTap: () {
                Navigator.pushNamed(context, '/ichamotiponds');
              },
            ),
            DashboardButton(
              icon: Icons.houseboat,
              label: 'মাছের পোনার তথ্য',
              color: Colors.lightBlue,
              onTap: () {
                Navigator.pushNamed(context, '/ichamotifishinfo');
              },
            ),
            DashboardButton(
              icon: Icons.feed_rounded,
              label: 'খাদ্য ব্যবস্থাপনা',
              color: Colors.lightBlue,
              onTap: () {
                Navigator.pushNamed(context, '/cowexpenses');
              },
            ),
            DashboardButton(
              icon: Icons.medical_information,
              label: 'স্বাস্থ্য ব্যবস্থাপনা',
              color: Colors.green,
              onTap: () {
                print('Job Card clicked');
              },
            ),
            DashboardButton(
              icon: Icons.production_quantity_limits_sharp,
              label: 'উৎপাদন',
              color: Colors.deepPurple,
              onTap: () {
                Navigator.pushNamed(context, '/fishproduction');
              },
            ),
            DashboardButton(
              icon: Icons.task,
              label: 'বিক্রয়',
              color: Colors.pinkAccent,
              onTap: () {
                print('Task clicked');
              },
            ),

            DashboardButton(
              icon: Icons.task,
              label: 'অন্যান্য ফিচার',
              color: Colors.pinkAccent,
              onTap: () {
                print('Task clicked');
              },
            ),

            DashboardButton(
              icon: Icons.report_sharp,
              label: 'রিপোর্ট',
              color: Colors.redAccent,
              onTap: () {
                print('Task clicked');
              },
            ),

          ],
        ),
      ),
    );
  }
}

class DashboardButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Function() onTap;

  DashboardButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(

        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: color,
              ),

              SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
  home: Ichamotidashboard(),
));
