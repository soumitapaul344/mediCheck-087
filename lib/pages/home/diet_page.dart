import 'package:flutter/material.dart';

class DietPage extends StatelessWidget {
  final String bmiCategory;

  const DietPage({super.key, required this.bmiCategory});

  @override
  Widget build(BuildContext context) {
    // Category-wise suggestions and diet plans
    final Map<String, Map<String, String>> dietPlans = {
      "Underweight": {
        "Goal": "Gain healthy weight",
        "Suggestions":
            "• Eat 5-6 small meals/day\n• Include high-calorie, nutrient-dense foods\n• Strength training to build muscle",
        "Diet Plan":
            "Breakfast: Oatmeal with milk, nuts, banana\nSnack: Peanut butter sandwich or smoothie\nLunch: Rice/roti, dal, paneer/chicken, vegetables\nSnack: Yogurt with fruits\nDinner: Quinoa/rice, fish/chicken, vegetables\nBefore bed: Glass of milk or protein shake",
      },
      "Normal": {
        "Goal": "Maintain healthy weight",
        "Suggestions":
            "• Eat balanced meals\n• Stay active regularly\n• Avoid excessive processed foods",
        "Diet Plan":
            "Breakfast: Eggs, whole-grain toast, fruits\nSnack: Nuts or fruits\nLunch: Brown rice/roti, lean protein, vegetables\nSnack: Yogurt or smoothie\nDinner: Lentils, vegetables, small portion of rice",
      },
      "Overweight": {
        "Goal": "Reduce weight gradually",
        "Suggestions":
            "• Eat low-calorie, high-protein foods\n• Include vegetables, whole grains, lean proteins\n• Avoid sugary drinks and fried foods\n• Exercise regularly",
        "Diet Plan":
            "Breakfast: Oatmeal with berries or egg whites with vegetables\nSnack: Fruits or nuts\nLunch: Grilled chicken/fish, salad, brown rice/quinoa\nSnack: Carrot sticks or low-fat yogurt\nDinner: Steamed vegetables, lentils, small portion of rice",
      },
      "Obese": {
        "Goal": "Reduce weight safely",
        "Suggestions":
            "• Strict portion control\n• Eat low-calorie, nutrient-dense foods\n• Avoid sugar, fried food, processed snacks\n• Exercise under supervision\n• Consult a doctor or nutritionist",
        "Diet Plan":
            "Breakfast: Vegetable omelet or smoothie with protein powder\nSnack: Fresh fruits\nLunch: Grilled fish/chicken, steamed vegetables, small portion of quinoa\nSnack: Cucumber/carrot sticks or unsalted nuts\nDinner: Salad with protein (lentils, tofu, fish)",
      },
    };

    final Map<String, String> recommendation =
        dietPlans[bmiCategory] ??
        {"Goal": "Eat healthy", "Suggestions": "", "Diet Plan": ""};

    return Scaffold(
      appBar: AppBar(
        title: const Text("Diet Recommendation"),
        backgroundColor: Colors.cyan,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCard("Goal", recommendation["Goal"]!),
            const SizedBox(height: 12),
            _buildCard("Suggestions", recommendation["Suggestions"]!),
            const SizedBox(height: 12),
            _buildCard("Diet Plan", recommendation["Diet Plan"]!),
          ],
        ),
      ),
    );
  }

  // Helper method to create a card
  Widget _buildCard(String title, String content) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.cyan,
              ),
            ),
            const SizedBox(height: 8),
            Text(content, style: const TextStyle(fontSize: 16, height: 1.5)),
          ],
        ),
      ),
    );
  }
}
