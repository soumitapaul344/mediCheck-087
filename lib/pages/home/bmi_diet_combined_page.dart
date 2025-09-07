import 'package:flutter/material.dart';
import 'bmi_page.dart';
import 'diet_page.dart';

class BmiDietCombinedPage extends StatefulWidget {
  const BmiDietCombinedPage({super.key});

  @override
  State<BmiDietCombinedPage> createState() => _BmiDietCombinedPageState();
}

class _BmiDietCombinedPageState extends State<BmiDietCombinedPage> {
  double? bmiValue;
  String category = "Normal";

  void updateBmi(double bmi, String cat) {
    setState(() {
      bmiValue = bmi;
      category = cat;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: BmiPageWithCallback(onBmiCalculated: updateBmi)),
        if (bmiValue != null) Expanded(child: DietPage(bmiCategory: category)),
      ],
    );
  }
}

class BmiPageWithCallback extends StatefulWidget {
  final void Function(double bmi, String category) onBmiCalculated;
  const BmiPageWithCallback({super.key, required this.onBmiCalculated});

  @override
  State<BmiPageWithCallback> createState() => _BmiPageWithCallbackState();
}

class _BmiPageWithCallbackState extends State<BmiPageWithCallback> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  void _calculateAndNotify() {
    final height = double.tryParse(_heightController.text);
    final weight = double.tryParse(_weightController.text);
    if (height == null || weight == null) return;

    final heightM = height / 100;
    final bmi = weight / (heightM * heightM);
    String category;
    if (bmi < 18.5) {
      category = "Underweight";
    } else if (bmi < 25) {
      category = "Normal";
    } else if (bmi < 30) {
      category = "Overweight";
    } else {
      category = "Obese";
    }

    widget.onBmiCalculated(bmi, category);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("BMI Calculator", style: TextStyle(fontSize: 18)),
          const SizedBox(height: 12),
          TextField(
            controller: _heightController,
            decoration: const InputDecoration(labelText: "Height (cm)"),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _weightController,
            decoration: const InputDecoration(labelText: "Weight (kg)"),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton(
              onPressed: _calculateAndNotify,
              child: const Text("Calculate"),
            ),
          ),
        ],
      ),
    );
  }
}
