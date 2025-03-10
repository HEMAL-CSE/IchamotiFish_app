import 'package:flutter/material.dart';
import 'package:tania_farm/components/CustomAppBar.dart';

class Ichamotidashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'পদ্মা সম্পর্কিত ড্যাশবোর্ড',),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            DashboardButton(
              icon: Icons.access_time,
              label: 'My Attendance',
              color: Colors.pink,
              onTap: () {
                print('Attendance clicked');
              },
            ),
            DashboardButton(
              icon: Icons.beach_access_rounded,
              label: 'Employee Profile',
              color: Colors.purple,
              onTap: () {
                print('Profile clicked');
              },
            ),
            DashboardButton(
              icon: Icons.exit_to_app,
              label: 'Leave Application',
              color: Colors.lightBlue,
              onTap: () {
                Navigator.pushNamed(context, '/cowexpenses');
              },
            ),
            DashboardButton(
              icon: Icons.badge,
              label: 'Job Card View',
              color: Colors.green,
              onTap: () {
                print('Job Card clicked');
              },
            ),
            DashboardButton(
              icon: Icons.notifications,
              label: 'Notice Board',
              color: Colors.deepPurple,
              onTap: () {
                print('Notice clicked');
              },
            ),
            DashboardButton(
              icon: Icons.task,
              label: 'Task Management',
              color: Colors.pinkAccent,
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
                color: color,
              ),
              SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
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
