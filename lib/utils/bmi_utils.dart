import '../models/bmi_model.dart';

class BmiUtils {
  static BmiModel calculateBmi(double height, double weight) {
    return BmiModel(height: height, weight: weight);
  }

  static String getRecommendation(String category) {
    switch (category) {
      case "Underweight":
        return "Increase calorie intake: eat more proteins, carbs, healthy fats.";
      case "Normal":
        return "Maintain your diet: balanced carbs, protein, fats, vitamins.";
      case "Overweight":
        return "Reduce calorie intake: low fat, avoid sugary foods, exercise.";
      case "Obese":
        return "Strict diet plan with medical guidance: low carbs, low fat, exercise.";
      default:
        return "Maintain a healthy balanced diet.";
    }
  }
}
