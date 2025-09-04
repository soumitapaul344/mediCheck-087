import 'package:flutter/material.dart';

class DietPage extends StatelessWidget {
  final String bmiCategory;
  const DietPage({super.key, this.bmiCategory = "Normal"});

  @override
  Widget build(BuildContext context) {
    String recommendation = "";

    switch (bmiCategory) {
      case "Underweight":
        recommendation =
            "Increase calorie intake: eat more proteins, carbs, healthy fats.";
        break;
      case "Normal":
        recommendation =
            "Maintain your diet: balanced carbs, protein, fats, vitamins.";
        break;
      case "Overweight":
        recommendation =
            "Reduce calorie intake: low fat, avoid sugary foods, exercise.";
        break;
      case "Obese":
        recommendation =
            "Strict diet plan with medical guidance: low carbs, low fat, exercise.";
        break;
      default:
        recommendation = "Maintain a healthy balanced diet.";
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Diet Recommendation")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(recommendation, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
