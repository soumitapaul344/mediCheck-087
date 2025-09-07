import 'package:flutter/material.dart';
import 'diet_page.dart';

class BmiPage extends StatefulWidget {
  const BmiPage({super.key});

  @override
  State<BmiPage> createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  double? bmi;
  String category = "";

  // BMI Calculation Function
  void calculateBMI() {
    final height = double.tryParse(_heightController.text);
    final weight = double.tryParse(_weightController.text);

    if (height != null && weight != null && height > 0) {
      final heightM = height / 100;
      final bmiValue = weight / (heightM * heightM);

      String cat;
      if (bmiValue < 18.5) {
        cat = "Underweight";
      } else if (bmiValue < 25) {
        cat = "Normal";
      } else if (bmiValue < 30) {
        cat = "Overweight";
      } else {
        cat = "Obese";
      }

      setState(() {
        bmi = bmiValue;
        category = cat;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter valid height & weight")),
      );
    }
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  // Suggest a logical button label based on BMI category
  String getDietButtonText() {
    switch (category) {
      case "Underweight":
        return "Gain Weight – See Diet Plan";
      case "Normal":
        return "Maintain Health – See Diet Plan";
      case "Overweight":
        return "Lose Weight – See Diet Plan";
      case "Obese":
        return "Strict Diet Required – See Plan";
      default:
        return "See Diet Plan";
    }
  }

  // Suggest a color for button based on BMI category
  Color getDietButtonColor() {
    switch (category) {
      case "Underweight":
        return Colors.blue;
      case "Normal":
        return Colors.green;
      case "Overweight":
        return Colors.orange;
      case "Obese":
        return Colors.red;
      default:
        return Colors.cyan;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Calculator"),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _heightController,
              decoration: const InputDecoration(
                labelText: "Height (cm)",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _weightController,
              decoration: const InputDecoration(
                labelText: "Weight (kg)",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateBMI,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
              child: const Text(
                "Calculate BMI",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            if (bmi != null) ...[
              // BMI Result Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        "Your BMI: ${bmi!.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.cyan,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Category: $category",
                        style: TextStyle(
                          fontSize: 18,
                          color: getDietButtonColor(),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Diet Plan Button
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DietPage(bmiCategory: category),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: getDietButtonColor(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.restaurant_menu, color: Colors.white),
                label: Text(
                  getDietButtonText(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
