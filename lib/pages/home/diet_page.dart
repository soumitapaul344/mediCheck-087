import 'package:flutter/material.dart';

class DietPage extends StatelessWidget {
  final String bmiCategory;
  const DietPage({super.key, required this.bmiCategory});

  @override
  Widget build(BuildContext context) {
    String recommendation;

    switch (bmiCategory) {
      case "Underweight":
        recommendation = "Increase calories: proteins, carbs, healthy fats.";
        break;
      case "Normal":
        recommendation = "Maintain a balanced diet and stay active.";
        break;
      case "Overweight":
        recommendation =
            "Control calories, eat more vegetables, exercise daily.";
        break;
      case "Obese":
        recommendation =
            "Strict medical diet: low carbs, exercise, doctor consult.";
        break;
      default:
        recommendation = "Eat healthy and stay active.";
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Diet Recommendation"),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(recommendation, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
