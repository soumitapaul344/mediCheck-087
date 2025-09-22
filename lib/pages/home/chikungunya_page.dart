import 'package:flutter/material.dart';

class ChikungunyaPage extends StatefulWidget {
  const ChikungunyaPage({super.key});

  @override
  State<ChikungunyaPage> createState() => _ChikungunyaPageState();
}

class _ChikungunyaPageState extends State<ChikungunyaPage> {
  // A map to hold the state of each symptom checkbox
  final Map<String, bool> _symptoms = {
    "High Fever": false,
    "Severe Joint Pain": false,
    "Muscle Pain": false,
    "Headache": false,
    "Nausea": false,
    "Rash": false,
  };

  String _result = "";
  String _message = "Select your symptoms and tap 'Check' to see the result.";

  void _checkSymptoms() {
    // Count the number of selected symptoms
    int selectedSymptomsCount = 0;
    _symptoms.forEach((key, value) {
      if (value) {
        selectedSymptomsCount++;
      }
    });

    // Simple logic for diagnosis
    if (selectedSymptomsCount >= 3 &&
        _symptoms["High Fever"]! &&
        _symptoms["Severe Joint Pain"]!) {
      setState(() {
        _result = "Positive";
        _message =
            "Based on your symptoms, there's a high probability of Chikungunya. Please consult a doctor for a proper diagnosis.";
      });
    } else if (selectedSymptomsCount > 0) {
      setState(() {
        _result = "Negative";
        _message =
            "Your symptoms do not strongly suggest Chikungunya, but you should still monitor your health. Consult a doctor if symptoms worsen.";
      });
    } else {
      setState(() {
        _result = "";
        _message = "Please select at least one symptom to get a result.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chikungunya Detection"),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Select your symptoms:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Loop through the symptoms map to build a list of CheckboxListTile
            Expanded(
              child: ListView.builder(
                itemCount: _symptoms.length,
                itemBuilder: (context, index) {
                  String symptom = _symptoms.keys.elementAt(index);
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: CheckboxListTile(
                      title: Text(symptom),
                      value: _symptoms[symptom],
                      onChanged: (bool? newValue) {
                        setState(() {
                          _symptoms[symptom] = newValue!;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkSymptoms,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Check",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            // Display diagnosis result
            if (_result.isNotEmpty)
              Column(
                children: [
                  const Text(
                    "Diagnosis Result:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _result,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _result == "Positive" ? Colors.red : Colors.green,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 10),
            Text(
              _message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
