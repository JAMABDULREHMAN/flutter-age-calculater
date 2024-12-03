import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const AgeCalculatorApp());
}

class AgeCalculatorApp extends StatelessWidget {
  const AgeCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AgeCalculatorScreen(),
    );
  }
}

class AgeCalculatorScreen extends StatefulWidget {
  const AgeCalculatorScreen({super.key});

  @override
  _AgeCalculatorScreenState createState() => _AgeCalculatorScreenState();
}

class _AgeCalculatorScreenState extends State<AgeCalculatorScreen> {
  final TextEditingController dobController = TextEditingController();
  String ageResult = "";

  void calculateAge() {
    if (dobController.text.isEmpty) {
      setState(() {
        ageResult = "Please enter your date of birth!";
      });
      return;
    }

    try {
      DateTime dob = DateTime.parse(dobController.text);
      DateTime today = DateTime.now();

      int years = today.year - dob.year;
      int months = today.month - dob.month;
      int days = today.day - dob.day;

      if (days < 0) {
        months--;
        days += 30; // Approximate adjustment
      }

      if (months < 0) {
        years--;
        months += 12;
      }

      setState(() {
        ageResult = "$years years, $months months, $days days";
      });
    } catch (e) {
      setState(() {
        ageResult = "Invalid date format! Use YYYY-MM-DD.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Age Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/123.json',
              fit: BoxFit.cover, // Add your Lottie file here
            ),
            TextField(
              controller: dobController,
              decoration: const InputDecoration(
                labelText: "Enter Date of Birth (YYYY-MM-DD)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: calculateAge,
              child: const Text("Calculate Age"),
            ),
            const SizedBox(height: 16),
            Text(
              ageResult,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
