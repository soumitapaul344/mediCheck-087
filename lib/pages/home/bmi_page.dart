import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/user_provider.dart';

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

  void calculateBMI() {
    final height = double.tryParse(_heightController.text);
    final weight = double.tryParse(_weightController.text);

    if (height != null && weight != null) {
      final heightM = height / 100;
      final bmiValue = weight / (heightM * heightM);
      String cat;
      if (bmiValue < 18.5)
        cat = "Underweight";
      else if (bmiValue < 25)
        cat = "Normal";
      else if (bmiValue < 30)
        cat = "Overweight";
      else
        cat = "Obese";

      setState(() {
        bmi = bmiValue;
        category = cat;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(title: const Text("BMI Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            if (user != null)
              Text("Hi, ${user.name}", style: const TextStyle(fontSize: 18)),
            TextField(
              controller: _heightController,
              decoration: const InputDecoration(labelText: "Height (cm)"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _weightController,
              decoration: const InputDecoration(labelText: "Weight (kg)"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateBMI,
              child: const Text("Calculate BMI"),
            ),
            if (bmi != null)
              Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "BMI: ${bmi!.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 20),
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
