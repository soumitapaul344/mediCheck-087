import 'package:flutter/material.dart';
import 'bmi_page.dart';
import 'diet_page.dart';
import '../profile/profile_page.dart';
import '../notes/note_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Navigate to next pages
  void _navigate(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Health Assistant"),
        centerTitle: true,
        backgroundColor: Colors.cyan,
        actions: [
          // Profile Button in the AppBar
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => _navigate(context, const ProfilePage()),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          children: [
            // BMI CALCULATION
            _buildGridItem(
              context,
              title: "BMI Calculation",
              icon: Icons.monitor_weight_outlined,
              page: const BmiPage(),
            ),

            // DIET PLAN
            // This is a temporary fix. The bmiCategory should be
            // calculated in the BmiPage and passed here.
            // _buildGridItem(
            //   context,
            //   title: "Diet Plan",
            //   icon: Icons.local_dining,
            //   page: const DietPage(bmiCategory: "Normal"),
            // ),

            // // NOTES
            // _buildGridItem(
            //   context,
            //   title: "Notes",
            //   icon: Icons.notes_outlined,
            //   page: const NotePage(),
            // ),

            // CHIKUNGUNYA DETECTION
            _buildGridItem(
              context,
              title: "Chikungunya Detection",
              icon: Icons.bug_report,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Chikungunya Detection Coming Soon"),
                  ),
                );
              },
            ),

            // COVID DETECTION
            _buildGridItem(
              context,
              title: "Covid-19 Detection",
              icon: Icons.coronavirus,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Covid-19 Detection Coming Soon"),
                  ),
                );
              },
            ),

            // ALLERGY DETECTION
            _buildGridItem(
              context,
              title: "Allergy Detection",
              icon: Icons.sick_outlined,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Allergy Detection Coming Soon"),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(
    BuildContext context, {
    required String title,
    required IconData icon,
    Widget? page,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap ?? () => _navigate(context, page!),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.lightBlueAccent,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: Colors.white),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
