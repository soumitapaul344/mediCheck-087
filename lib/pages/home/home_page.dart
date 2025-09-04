import 'package:flutter/material.dart';
import 'bmi_page.dart';
import 'diet_page.dart';
import '../../pages/notes/note_page.dart';
import '../../pages/profile/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const NotePage(),
    const BmiPage(),
    const DietPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.notes), label: "Notes"),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: "BMI",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: "Diet"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
