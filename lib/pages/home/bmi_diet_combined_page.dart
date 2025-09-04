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
