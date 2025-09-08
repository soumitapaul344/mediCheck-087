class BmiModel {
  final double height; // in cm
  final double weight; // in kg
  double bmi = 0;
  String category = "Normal";

  BmiModel({required this.height, required this.weight}) {
    calculateBmi();
  }

  void calculateBmi() {
    final heightM = height / 100;
    bmi = weight / (heightM * heightM);

    if (bmi < 18.5) {
      category = "Underweight";
    } else if (bmi < 25) {
      category = "Normal";
    } else if (bmi < 30) {
      category = "Overweight";
    } else {
      category = "Obese";
    }
  }
}
