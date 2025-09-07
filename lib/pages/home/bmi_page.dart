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

      // Navigate to Diet Page after calculation
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => DietPage(bmiCategory: cat)),
      );
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
            if (bmi != null)
              Column(
                children: [
                  Text(
                    "BMI: ${bmi!.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Category: $category",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
